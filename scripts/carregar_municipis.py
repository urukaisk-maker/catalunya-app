#!/usr/bin/env python3
"""
Script per carregar tots els municipis de Catalunya a la base de dades.
Descarrega les dades del portal de dades obertes de la Generalitat
i les injecta al contenidor de PostgreSQL.
"""
import json
import urllib.request
import subprocess
import sys
import os

# Força UTF-8 a stdout
sys.stdout.reconfigure(encoding='utf-8')

# URL de l'API de Socrata (dades obertes Generalitat)
API_URL = "https://analisi.transparenciacatalunya.cat/resource/wpyq-we8x.json?$limit=1000"


def descarregar_municipis():
    """Descarrega la llista completa de municipis amb coordenades."""
    print("[1/4] Descarregant dades de municipis...")
    try:
        with urllib.request.urlopen(API_URL, timeout=30) as response:
            dades = json.loads(response.read().decode('utf-8'))
        print(f"      OK: {len(dades)} municipis descarregats")
        return dades
    except Exception as e:
        print(f"      ERROR: {e}")
        sys.exit(1)


def generar_sql(municipis):
    """Genera les sentències SQL per inserir els municipis."""
    print("[2/4] Generant SQL...")

    files = []
    for m in municipis:
        nom = m.get('municipi', '').strip()
        comarca = m.get('comarca', '').strip()
        lat = m.get('latitud')
        lon = m.get('longitud')

        if not (nom and comarca and lat and lon):
            continue

        # Escapar cometes simples per SQL
        nom_sql = nom.replace("'", "''")
        comarca_sql = comarca.replace("'", "''")

        files.append(f"('{nom_sql}', '{comarca_sql}', {lat}, {lon})")

    if not files:
        print("      ERROR: No s'han trobat municipis amb dades completes")
        sys.exit(1)

    print(f"      OK: {len(files)} municipis preparats per inserir")

    sql = f"""-- =====================================================
--  05 - TOTS ELS MUNICIPIS DE CATALUNYA
--  Generat automaticament des de dades obertes de la Generalitat
-- =====================================================
SET client_encoding TO 'UTF8';

INSERT INTO municipis (nom, comarca_id, latitud, longitud)
SELECT v.nom, c.id, v.latitud, v.longitud
FROM (VALUES
{','.join(files)}
) AS v(nom, comarca, latitud, longitud)
JOIN comarques c ON c.nom = v.comarca
ON CONFLICT (nom) DO NOTHING;
"""
    return sql


def injectar_sql(sql):
    """Injecta el SQL al contenidor de PostgreSQL."""
    print("[3/4] Injectant SQL a PostgreSQL...")

    # Guardar SQL temporalment
    tmp_path = '/tmp/municipis_complets.sql'
    with open(tmp_path, 'w', encoding='utf-8') as f:
        f.write(sql)

    # Copiar al contenidor
    subprocess.run(
        ['docker', 'cp', tmp_path, 'catalunya_db:/tmp/municipis.sql'],
        check=True
    )

    # Executar
    result = subprocess.run(
        [
            'docker', 'exec', '-i', 'catalunya_db',
            'psql', '-U', 'catalunya_user', '-d', 'catalunya_db',
            '-v', 'ON_ERROR_STOP=1',
            '-f', '/tmp/municipis.sql'
        ],
        capture_output=True, text=True, encoding='utf-8'
    )

    if result.returncode != 0:
        print(f"      ERROR injectant: {result.stderr}")
        sys.exit(1)

    print("      OK: Municipis injectats correctament")


def verificar():
    """Verifica el total de municipis a la base de dades."""
    print("[4/4] Verificant...")
    count = subprocess.run(
        [
            'docker', 'exec', '-i', 'catalunya_db',
            'psql', '-U', 'catalunya_user', '-d', 'catalunya_db',
            '-t', '-c', 'SELECT COUNT(*) FROM municipis;'
        ],
        capture_output=True, text=True, encoding='utf-8'
    )
    total = count.stdout.strip()
    print(f"      Total de municipis a la BD: {total}")


def main():
    municipis = descarregar_municipis()
    sql = generar_sql(municipis)

    # Guardar SQL al projecte per persistència
    os.makedirs('db', exist_ok=True)
    with open('db/05_municipis_complets.sql', 'w', encoding='utf-8') as f:
        f.write(sql)
    print("      SQL guardat a db/05_municipis_complets.sql")

    injectar_sql(sql)
    verificar()


if __name__ == '__main__':
    main()
