-- =====================================================
--  04 — CONTINGUT FINAL MASSIU
-- =====================================================
CREATE EXTENSION IF NOT EXISTS unaccent;

-- ---------- GEOGRAFIA ----------
CREATE TABLE IF NOT EXISTS geografia (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(120) NOT NULL,
  tipus VARCHAR(50) NOT NULL,
  descripcio TEXT,
  provincia_id INTEGER REFERENCES provincies(id),
  altitud INTEGER
);

INSERT INTO geografia (nom, tipus, descripcio, provincia_id, altitud) VALUES
('Pica d''Estats',                'Muntanya', 'El cim més alt de Catalunya, al Pallars Sobirà.', 3, 3143),
('Montseny',                      'Massís',   'Reserva de la Biosfera UNESCO, a cavall de Barcelona i Girona.', 1, 1706),
('Montserrat',                    'Massís',   'Muntanya sagrada amb formes singulars, símbol espiritual de Catalunya.', 1, 1236),
('Pedraforca',                    'Muntanya', 'Muntanya amb forma de forca, emblemàtica del Berguedà.', 1, 2497),
('Riu Ebre',                      'Riu',      'El riu més cabalós de la península, travessa Catalunya pel sud.', 4, NULL),
('Riu Ter',                       'Riu',      'Neix al Ripollès i desemboca a la Costa Brava.', 2, NULL),
('Riu Llobregat',                 'Riu',      'Neix al Berguedà i passa per Barcelona.', 1, NULL),
('Riu Segre',                     'Riu',      'Afluent de l''Ebre, travessa Lleida.', 3, NULL),
('Parc Nacional d''Aigüestortes', 'Parc',     'Únic parc nacional de Catalunya, als Pirineus.', 3, NULL),
('Delta de l''Ebre',              'Parc',     'El delta més gran de Catalunya, amb arrossars i aus.', 4, NULL),
('Cap de Creus',                  'Parc',     'Primer parc marítim-terrestre de Catalunya.', 2, NULL),
('Zona Volcànica de la Garrotxa', 'Parc',     '40 cràters inactius i la Fageda d''en Jordà.', 2, NULL),
('Vall de Núria',                 'Vall',     'Vall pirinenca amb santuari i estació d''esquí.', 2, 1964),
('Vall de Boí',                   'Vall',     'Vall amb el romànic més pur de Catalunya.', 3, NULL)
ON CONFLICT DO NOTHING;

-- ---------- CULTURA GENERAL ----------
CREATE TABLE IF NOT EXISTS cultura_general (
  id SERIAL PRIMARY KEY,
  nom VARCHAR(150) NOT NULL,
  categoria VARCHAR(50),
  descripcio TEXT
);

INSERT INTO cultura_general (nom, categoria, descripcio) VALUES
('La Senyera',            'Símbol',    'Bandera de Catalunya amb quatre barres vermelles sobre fons groc.'),
('Els Segadors',          'Himne',     'Himne nacional de Catalunya, basat en els fets de 1640.'),
('Sant Jordi',            'Santedat',  'Sant patró de Catalunya, cavaller que matà el drac.'),
('La Diada Nacional',     'Festa',     'Onze de Setembre, commemoració de la caiguda de Barcelona el 1714.'),
('Els Castellers',        'Patrimoni', 'Torres humanes declarades Patrimoni de la UNESCO.'),
('La Sardana',            'Música',    'Ball tradicional català que es balla en rotllana.'),
('La Barretina',          'Símbol',    'Barret tradicional català, símbol del pagès.'),
('El Caganer',            'Tradició',  'Figura del pessebre nadalenc, símbol d''humor i ironia.'),
('El Tió de Nadal',       'Tradició',  'Tronc que "caga" regals la nit de Nadal.'),
('L''Escut de Catalunya', 'Símbol',    'Escut heràldic amb les quatre barres.'),
('El Cant de la Sibil·la','Música',    'Cant medieval de la nit de Nadal, Patrimoni UNESCO.'),
('El Ball de Bastons',    'Dansa',     'Dansa tradicional amb bastons, molt estesa arreu de Catalunya.')
ON CONFLICT DO NOTHING;

-- ---------- DITES ----------
CREATE TABLE IF NOT EXISTS dites (
  id SERIAL PRIMARY KEY,
  text VARCHAR(300) NOT NULL,
  significat TEXT,
  origen VARCHAR(150)
);

INSERT INTO dites (text, significat, origen) VALUES
('Qui no vulgui pols, que no vagi a l''era', 'Si no vols problemes, evita certs llocs.', 'Popular'),
('Tocar el voraviu',                         'Enfadar-se o irritar-se fàcilment.',       'Popular'),
('Bufar i fer ampolles',                     'Ser molt fàcil d''aconseguir.',            'Marítim'),
('Estar tocat del bolet',                    'Estar una mica boig.',                     'Bolets'),
('Tenir el cap a la lluna',                  'Estar distret.',                           'Popular'),
('Anar de bòlit',                            'Córrer sense parar.',                      'Marítim'),
('Ser més llarg que un dia sense pa',        'Ser molt llarg i pesat.',                  'Popular');

-- ---------- ESTADÍSTIQUES ----------
CREATE TABLE IF NOT EXISTS estadistiques (
  id SERIAL PRIMARY KEY,
  etiqueta VARCHAR(100) NOT NULL,
  valor VARCHAR(50) NOT NULL,
  descripcio TEXT
);

INSERT INTO estadistiques (etiqueta, valor, descripcio) VALUES
('Població',          '8.000.000',  'Habitants aproximats de Catalunya.'),
('Superfície',        '32.108 km²', 'Àrea total del territori català.'),
('Províncies',        '4',          'Barcelona, Girona, Lleida i Tarragona.'),
('Comarques',         '42',         'Divisions administratives intermunicipals.'),
('Municipis',         '947',        'Nombre total de municipis.'),
('Llengües oficials', '3',          'Català, castellà i aranès.'),
('Alçada màxima',     '3.143 m',    'Pica d''Estats, al Pallars Sobirà.'),
('Costa',             '580 km',     'Longitud de la costa catalana.'),
('Parcs naturals',    '18',         'Nombre de parcs naturals protegits.'),
('Patrimoni UNESCO',  '11',         'Béns declarats Patrimoni de la Humanitat.');
