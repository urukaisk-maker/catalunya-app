-- =====================================================
--  EXPLORADOR DE CATALUNYA — Esquema complet
-- =====================================================

-- ---------- PROVÍNCIES ----------
CREATE TABLE IF NOT EXISTS provincies (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    descripcio TEXT NOT NULL
);

INSERT INTO provincies (nom, descripcio) VALUES
('Barcelona', 'Capital cosmopolita de Catalunya, famosa per la Sagrada Família, el Park Güell i la seva vibrant vida cultural i gastronòmica.'),
('Girona', 'Ciutat medieval amb un barri jueu espectacular, la Catedral i els colors de l''Onyar. Porta d''entrada a la Costa Brava.'),
('Lleida', 'Terra de fruiters i muntanyes, amb la Seu Vella com a emblema. Porta dels Pirineus i de la Vall d''Aran.'),
('Tarragona', 'Herència romana declarada Patrimoni de la Humanitat, amb el seu amfiteatre, aqüeducte i platges daurades de la Costa Daurada.');

-- ---------- COMARQUES ----------
CREATE TABLE IF NOT EXISTS comarques (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    provincia_id INTEGER NOT NULL REFERENCES provincies(id) ON DELETE CASCADE,
    capital VARCHAR(100)
);

INSERT INTO comarques (nom, provincia_id, capital) VALUES
('Barcelonès',      1, 'Barcelona'),
('Vallès Occidental',1, 'Sabadell'),
('Maresme',         1, 'Mataró'),
('Baix Llobregat',  1, 'Sant Feliu de Llobregat'),
('Selva',           2, 'Santa Coloma de Farners'),
('Baix Empordà',    2, 'La Bisbal d''Empordà'),
('Gironès',         2, 'Girona'),
('Segrià',          3, 'Lleida'),
('Vall d''Aran',    3, 'Vielha e Mijaran'),
('Urgell',          3, 'Tàrrega'),
('Tarragonès',      4, 'Tarragona'),
('Baix Camp',       4, 'Reus'),
('Montsià',         4, 'Amposta');

-- ---------- MUNICIPIS ----------
CREATE TABLE IF NOT EXISTS municipis (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    comarca_id INTEGER NOT NULL REFERENCES comarques(id) ON DELETE CASCADE,
    poblacio INTEGER,
    latitud NUMERIC(9,6),
    longitud NUMERIC(9,6)
);

INSERT INTO municipis (nom, comarca_id, poblacio, latitud, longitud) VALUES
('Barcelona',       1, 1620000, 41.387400, 2.168600),
('Sabadell',        2,  216000, 41.548300, 2.107300),
('Mataró',          3,  128000, 41.538100, 2.444900),
('Girona',          7,  101000, 41.979400, 2.821400),
('Figueres',        6,   47000, 42.266500, 2.960200),
('Lleida',          8,  138000, 41.620100, 0.626900),
('Vielha',          9,    5400, 42.701300, 0.795000),
('Tarragona',      11,  132000, 41.118800, 1.244500),
('Reus',           12,  105000, 41.154200, 1.108800),
('Amposta',        13,   21000, 40.709200, 0.580700);

-- ---------- MONUMENTS / POIs ----------
CREATE TABLE IF NOT EXISTS monuments (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    municipi_id INTEGER NOT NULL REFERENCES municipis(id) ON DELETE CASCADE,
    tipus VARCHAR(50),
    descripcio TEXT,
    latitud NUMERIC(9,6),
    longitud NUMERIC(9,6),
    any_construccio INTEGER
);

INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio) VALUES
('Sagrada Família',      1, 'Religiós',  'Obra mestra d''Antoni Gaudí, Patrimoni de la UNESCO.',        41.403600, 2.174400, 1882),
('Park Güell',           1, 'Parc',      'Parc públic dissenyat per Gaudí amb mosaics modernistes.',    41.414500, 2.152700, 1914),
('Catedral de Girona',   4, 'Religiós',  'Catedral gòtica amb la nau més ampla del món.',               41.987500, 2.825600, 1038),
('Teatre-Museu Dalí',    5, 'Museu',     'Museu surrealista al Teatre Municipal de Figueres.',          42.267000, 2.960000, 1974),
('Seu Vella',            6, 'Religiós',  'Antiga catedral romànica al turó de Lleida.',                 41.619400, 0.626900, 1203),
('Amfiteatre de Tarraco',8, 'Romà',      'Amfiteatre romà del segle II, Patrimoni de la UNESCO.',       41.114500, 1.258800, 200),
('Castell de Miravet',  10, 'Castell',   'Castell templer sobre el riu Ebre.',                          41.036900, 0.597500, 1153);
