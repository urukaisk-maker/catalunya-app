#!/usr/bin/env python3
"""
Script per carregar tots els municipis de Catalunya a la base de dades.
Descarrega les dades del portal de dades obertes de la Generalitat.
"""
import json
import urllib.request
import subprocess
import sys

# URL de l'API de Socrata (dades obertes Generalitat)
API_URL = "https://analisi.transparenciacatalunya.cat/resource/wpyq-we8x.json?$limit=1000"

def descarregar_municipis():
    """Descarrega la llista completa de municipis amb coordenades."""
    print("📥 Descarregant dades de municipis...")
    try:
        with urllib.request.urlopen(API_URL) as response:
            dades = json.loads(response.read().decode('utf-8'))
        print(f"✅ Descarregats {len(dades)} municipis")
        return dades
    except Exception as e:
        print(f"❌ Error descarregant: {e}")
        sys.exit(1)

def generar_sql(municipis):
    """Genera les sentències SQL per inserir els municipis."""
    print("🔧 Generant SQL...")
    
    # Construir les files del VALUES
    files = []
    for m in municipis:
        nom = m.get('municipi', '').replace("'", "''")
        comarca = m.get('comarca', '').replace("'", "''")
        lat = m.get('latitud')
        lon = m.get('longitud')
        
        if nom and comarca and lat and lon:
            files.append(f"('{nom}', '{comarca}', {lat}, {lon})")
    
    if not files:
        print("❌ No s'han trobat municipis amb dades completes")
        sys.exit(1)
    
    # Generar l'INSERT amb subconsulta per obtenir l'ID de la comarca
    sql = f"""-- =====================================================
--  05 — TOTS ELS MUNICIPIS DE CATALUNYA
--  Generat automàticament des de dades obertes de la Generalitat
-- =====================================================
INSERT INTO municipis (nom, comarca_id, latitud, longitud)
SELECT v.nom, c.id, v.latitud, v.longitud
FROM (VALUES
{','.join(files)}
) AS v(nom, comarca, latitud, longitud)
JOIN comarques c ON c.nom = v.comarca
ON CONFLICT DO NOTHING;
"""
    return sql

def injectar_sql(sql):
    """Injecta el SQL al contenidor de PostgreSQL."""
    print("💉 Injectant SQL a PostgreSQL...")
    
    # Guardar SQL temporalment
    with open('/tmp/municipis_complets.sql', 'w') as f:
        f.write(sql)
    
    # Copiar al contenidor
    subprocess.run(['docker', 'cp', '/tmp/municipis_complets.sql', 'catalunya_db:/tmp/municipis.sql'], check=True)
    
    # Executar
    result = subprocess.run(
        ['docker', 'exec', '-i', 'catalunya_db', 'psql', '-U', 'catalunya_user', '-d', 'catalunya_db', '-f', '/tmp/municipis.sql'],
        capture_output=True, text=True
    )
    
    if result.returncode == 0:
        print("✅ Municipis injectats correctament!")
        # Comptar quants municipis hi ha ara
        count = subprocess.run(
            ['docker', 'exec', '-i', 'catalunya_db', 'psql', '-U', 'catalunya_user', '-d', 'catalunya_db', '-t', '-c', 'SELECT COUNT(*) FROM municipis;'],
            capture_output=True, text=True
        )
        print(f"📊 Total de municipis a la base de dades: {count.stdout.strip()}")
    else:
        print(f"❌ Error injectant: {result.stderr}")
        sys.exit(1)

def main():
    municipis = descarregar_municipis()
    sql = generar_sql(municipis)
    
    # Guardar SQL per si de cas
    with open('db/05_municipis_complets.sql', 'w') as f:
        f.write(sql)
    print("💾 SQL guardat a db/05_municipis_complets.sql")
    
    injectar_sql(sql)

if __name__ == '__main__':
    main()
