-- =====================================================
--  EXPLORADOR DE CATALUNYA — Esquema complet
-- =====================================================

-- ---------- PROVÍNCIES ----------
CREATE EXTENSION IF NOT EXISTS unaccent;
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
    capital VARCHAR(100),
    descripcio TEXT
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
-- =====================================================
--  AMPLIACIÓ FASE 3A — Contingut cultural i gastronòmic
-- =====================================================

-- ---------- PLATS TRADICIONALS ----------
CREATE TABLE IF NOT EXISTS plats_tradicionals (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(120) NOT NULL UNIQUE,
    descripcio TEXT NOT NULL,
    origen VARCHAR(120),
    provincia_id INTEGER REFERENCES provincies(id),
    temporada VARCHAR(50)
);

INSERT INTO plats_tradicionals (nom, descripcio, origen, provincia_id, temporada) VALUES
('Calçotada',
 'Tradició hivernal originària de Valls. Consisteix a rostir calçots (ceba tendra) a la flama de sarments i menjar-los sucats en salsa romesco, amb un pitet gegant.',
 'Valls (Alt Camp)', 4, 'Hivern'),
('Pa amb tomàquet',
 'La base de la gastronomia catalana: llesques de pa de pagès torrat, fregat amb tomàquet cru, amanit amb oli d''oliva verge extra i una mica de sal.',
 'Tota Catalunya', 1, 'Tot l''any'),
('Trinxat de la Cerdanya',
 'Plat contundent dels Pirineus fet a base de col d''hivern i patata, bullides i triturades, fregit com una truita amb trossos de cansalada (rostit).',
 'La Cerdanya', 3, 'Hivern'),
('Crema Catalana',
 'El postres per excel·lència. Crema pastissera suau a base de rovell d''ou, coberta per una fina capa de sucre cremat amb bufador o pala de ferro per crear un caramel cruixent.',
 'Tota Catalunya', 1, 'Tot l''any'),
('Escudella i carn d''olla',
 'Sopa tradicional catalana amb pilota, verdures i carns. El plat més emblemàtic del Nadal català.',
 'Tota Catalunya', 1, 'Hivern'),
('Suquet de peix',
 'Guisat mariner de la costa catalana amb patates, peix de roca i sofregit de tomàquet, all i ametlles.',
 'Costa Brava', 2, 'Tot l''any');

-- ---------- FESTES I TRADICIONS ----------
CREATE TABLE IF NOT EXISTS festes_tradicions (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(150) NOT NULL UNIQUE,
    descripcio TEXT NOT NULL,
    lloc VARCHAR(150),
    provincia_id INTEGER REFERENCES provincies(id),
    epoca VARCHAR(50),
    patrimoni_unesco BOOLEAN DEFAULT FALSE
);

INSERT INTO festes_tradicions (nom, descripcio, lloc, provincia_id, epoca, patrimoni_unesco) VALUES
('Els Castellers',
 'Impresionants torres humanes que poden arribar fins a deu pisos d''alçada. Representen els valors de força, equilibri, valor i seny.',
 'Tota Catalunya', NULL, 'Tot l''any', TRUE),
('Diada de Sant Jordi',
 'La festa més romàntica i cultural. Els carrers s''omplen de parades de llibres i roses, celebrant el dia del llibre i de l''amor.',
 'Tota Catalunya', NULL, '23 d''abril', FALSE),
('Correfocs',
 'Festes on grups de diables disfressats recorren els carrers ballant sota una pluja de guspires de foc i petards al ritme incessant dels tambors.',
 'Tota Catalunya', NULL, 'Estiu', FALSE),
('La Patum de Berga',
 'Festa tradicional del Corpus Christi, declarada Obra Mestra del Patrimoni Oral i Immaterial de la Humanitat. Plena de foc, pirotècnia i bestiari místic.',
 'Berga', 1, 'Corpus Christi', TRUE);

-- ---------- AMPLIACIÓ DE COMARQUES (detalls) ----------
-- Afegim un camp de descripcio a comarques (opcional per a les noves)
ALTER TABLE comarques ADD COLUMN IF NOT EXISTS descripcio TEXT;

UPDATE comarques SET descripcio = 'Terra de vents (la Tramuntana) i bressol del surrealisme de Salvador Dalí. Paisatges que combinen cales escarpades de la Costa Brava amb planures agrícoles.'
  WHERE nom = 'Alt Empordà';

UPDATE comarques SET descripcio = 'Famosa pel seu Parc Natural de la Zona Volcànica, amb més de 40 cràters inactius coberts de boscos espessos de fagedes (com la Fageda d''en Jordà).'
  WHERE nom = 'Garrotxa';

UPDATE comarques SET descripcio = 'Regió muntanyosa d''interior reconeguda mundialment pels seus vinyers conreats en terrasses escarpades de pissarra (llicorella), produint vins negres d''una qualitat excepcional.'
  WHERE nom = 'Priorat';

UPDATE comarques SET descripcio = 'Vall pirinenca singular amb cultura i llengua pròpies (l''aranès). Paradís per als esports d''hivern i el senderisme d''alta muntanya.'
  WHERE nom = 'Vall d''Aran';

UPDATE comarques SET descripcio = 'Coneguda per la seva capital, Vic, famosa per la seva plaça major porxada, la boira matinal i la seva excel·lent tradició en embotits com el fuet.'
  WHERE nom = 'Osona';

-- ---------- NOVES COMARQUES ----------
INSERT INTO comarques (nom, provincia_id, capital, descripcio) VALUES
('Alt Empordà', 2, 'Figueres', NULL),
('Garrotxa',    2, 'Olot',     NULL),
('Priorat',     4, 'Falset',   NULL),
('Osona',       1, 'Vic',      NULL)
ON CONFLICT (nom) DO NOTHING;

-- ---------- NOU MONUMENT ----------
INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio) VALUES
('Romànic de la Vall de Boí', 7, 'Religiós',
 'Conjunt de nou esglésies romàniques als Pirineus, famoses pels seus campanars de torre i els frescos murals (originals al MNAC). Patrimoni de la UNESCO.',
 42.504300, 0.803200, 1100)
ON CONFLICT DO NOTHING;
INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio) VALUES
('Sagrada Família',      1, 'Religiós',  'Obra mestra d''Antoni Gaudí, Patrimoni de la UNESCO.',        41.403600, 2.174400, 1882),
('Park Güell',           1, 'Parc',      'Parc públic dissenyat per Gaudí amb mosaics modernistes.',    41.414500, 2.152700, 1914),
('Catedral de Girona',   4, 'Religiós',  'Catedral gòtica amb la nau més ampla del món.',               41.987500, 2.825600, 1038),
('Teatre-Museu Dalí',    5, 'Museu',     'Museu surrealista al Teatre Municipal de Figueres.',          42.267000, 2.960000, 1974),
('Seu Vella',            6, 'Religiós',  'Antiga catedral romànica al turó de Lleida.',                 41.619400, 0.626900, 1203),
('Amfiteatre de Tarraco',8, 'Romà',      'Amfiteatre romà del segle II, Patrimoni de la UNESCO.',       41.114500, 1.258800, 200),
('Castell de Miravet',  10, 'Castell',   'Castell templer sobre el riu Ebre.',                          41.036900, 0.597500, 1153);
