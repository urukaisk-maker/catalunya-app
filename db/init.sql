-- Tabla de provincias de Catalunya
CREATE TABLE IF NOT EXISTS provincies (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    descripcio TEXT NOT NULL
);

INSERT INTO provincies (nom, descripcio) VALUES
('Barcelona', 'Capital cosmopolita de Catalunya, famosa per la Sagrada Família, el Park Güell i la seva vibrant vida cultural i gastronòmica.'),
('Girona', 'Ciutat medieval amb un barri jueu espectacular, la Catedral i els colors de l''Onyar. Porta d''entrada a la Costa Brava.'),
('Lleida', 'Terra de fruiters i muntanyes, amb la Seu Vella com a emblema. Porta dels Pirineus i de la Vall d''Aran.'),
('Tarragona', 'Herència romana declarada Patrimoni de la Humanitat, amb el seu amfiteatre, aqüeducte i platges daurades de la Costa Daurada.');
