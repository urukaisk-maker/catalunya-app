-- =====================================================
--  02 — COMARQUES (41 oficials, amb capital i descripció)
-- =====================================================
--  NOTA: Els municipis i monuments s'insereixen al fitxer 03,
--  que fa servir subconsultes per nom per evitar problemes
--  amb els IDs del SERIAL.
-- =====================================================

INSERT INTO comarques (nom, provincia_id, capital, descripcio) VALUES
-- Barcelona (1)
('Alt Penedès',      1, 'Vilafranca del Penedès', 'Terra de vins escumosos. Capital del cava, amb cellers centenaris a Sant Sadurní d''Anoia.'),
('Anoia',            1, 'Igualada',               'Comarca central coneguda pel seu patrimoni industrial lligat al tèxtil i l''adoberia.'),
('Bages',            1, 'Manresa',                'Cor de Catalunya. Manresa, ciutat ignasiana, i el massís de Montserrat als seus límits.'),
('Baix Llobregat',   1, 'Sant Feliu de Llobregat', 'Delta del Llobregat, platges i polígons industrials. Porta sud de Barcelona.'),
('Barcelonès',       1, 'Barcelona',              'La comarca més poblada: Barcelona, l''Hospitalet, Badalona, Santa Coloma i Sant Adrià.'),
('Berguedà',         1, 'Berga',                  'Prepirineu amb el Pedraforca, les mines de carbó de Cercs i la Patum de Berga.'),
('Garraf',           1, 'Vilanova i la Geltrú',    'Costa del Garraf, el massís calcari i els cellers del Penedès marítim.'),
('Maresme',          1, 'Mataró',                 'Costa entre Barcelona i la Selva. Tradició de flors i horta, amb platges urbanes.'),
('Moianès',          1, 'Moià',                   'Comarca jove (2015). Altiplà central amb paisatges agraris i ermites romàniques.'),
('Osona',            1, 'Vic',                    'Capital del porc i dels embotits. Plaça major porxada, boira matinal i bisbat mil·lenari.'),
('Vallès Occidental',1, 'Sabadell / Terrassa',    'Comarca dual: dues capitals, tradició tèxtil i seu de la UPC i l''ESEIAAT.'),
('Vallès Oriental',  1, 'Granollers',             'Porta del Montseny. Corredor industrial i residencial entre Barcelona i Girona.'),
-- Girona (2)
('Alt Empordà',      2, 'Figueres',               'Terra de la Tramuntana i bressol del surrealisme de Dalí. Costa Brava i Aiguamolls.'),
('Baix Empordà',     2, 'La Bisbal d''Empordà',   'Costa Brava autèntica: cales, pobles medievals com Pals i Peratallada, ceràmica de La Bisbal.'),
('Garrotxa',         2, 'Olot',                   'Parc Natural de la Zona Volcànica: 40 cràters inactius i la Fageda d''en Jordà.'),
('Gironès',          2, 'Girona',                 'Comarca de Girona, el barri jueu, les catedrals i el riu Onyar.'),
('Pla de l''Estany', 2, 'Banyoles',               'L''estany de Banyoles, el més gran de Catalunya, d''origen càrstic.'),
('Ripollès',         2, 'Ripoll',                 'Alt Pirineu. Monestir de Santa Maria de Ripoll, bressol del romànic català.'),
('Selva',            2, 'Santa Coloma de Farners', 'Entre la costa i el Montseny. Lloret, Blanes i la desembocadura del Tordera.'),
-- Lleida (3)
('Alt Urgell',       3, 'La Seu d''Urgell',       'Pirineu lleidatà. La Seu d''Urgell, seu del bisbat i del Parc Olímpic del Segre.'),
('Alta Ribagorça',   3, 'El Pont de Suert',       'Vall de Boí amb el seu romànic UNESCO i el parc nacional d''Aigüestortes.'),
('Garrigues',        3, 'Les Borges Blanques',    'Terra d''oliveres, oli d''oliva verge extra amb DO pròpia.'),
('Noguera',          3, 'Balaguer',               'Riu Segre i el Montsec. Balaguer i la seva història andalusina.'),
('Pallars Jussà',    3, 'Tremp',                  'Prepirineu amb el congost de Mont-rebei i el Montsec.'),
('Pallars Sobirà',   3, 'Sort',                   'Pirineu pur. Parc Nacional d''Aigüestortes, ports de la Bonaigua i muntanyes de 3000m.'),
('Pla d''Urgell',    3, 'Mollerussa',             'Comarca agrícola amb regadiu del canal d''Urgell. Terra de fruita dolça.'),
('Segarra',          3, 'Cervera',                'Altiplà cerealista. Cervera, ciutat universitària històrica.'),
('Segrià',           3, 'Lleida',                 'Comarca de Lleida. Horta, fruiters i la Seu Vella dominant la ciutat.'),
('Solsonès',         3, 'Solsona',                'Prepirineu central. Bisbat històric i paisatges de rouredes.'),
('Urgell',           3, 'Tàrrega',                'Pla d''Urgell, Tàrrega i el seu teatre al carrer FiraTàrrega.'),
('Val d''Aran',      3, 'Vielha e Mijaran',       'Vall pirinenca amb llengua i cultura pròpies (aranès). Baqueira-Beret.'),
-- Tarragona (4)
('Alt Camp',         4, 'Valls',                  'Bressol dels calçots i dels Castellers de Valls. Terra de pagesos i tradicions.'),
('Baix Camp',        4, 'Reus',                   'Reus, bressol de Gaudí, terra de vermuts i avellanes. Port de Salou.'),
('Baix Ebre',        4, 'Tortosa',                'Delta de l''Ebre, arrossars i el Parc Natural. Tortosa i el seu castell templer.'),
('Baix Penedès',     4, 'El Vendrell',            'Costa del Garraf i el Penedès marítim. El Vendrell, bressol de Pau Casals.'),
('Conca de Barberà', 4, 'Montblanc',              'Pobles medievals emmurallats, monestir de Poblet (UNESCO) i vins de guarda.'),
('Montsià',          4, 'Amposta',                'Delta de l''Ebre sud. Arrossars, musclos i el Parc Natural.'),
('Priorat',          4, 'Falset',                 'Vinyes en terrasses de pissarra (llicorella). Vins negres de qualitat excepcional.'),
('Ribera d''Ebre',   4, 'Móra d''Ebre',           'Riu Ebre entre Mequinensa i Miravet. Paisatges fluvials únics.'),
('Tarragonès',       4, 'Tarragona',              'Comarca de Tarragona romana. Amfiteatre, aqüeducte i Patrimoni de la UNESCO.'),
('Terra Alta',       4, 'Gandesa',                'Terra de vins, oli i presseguers. Paisatge abrupte entre Ebre i Ports.')
ON CONFLICT (nom) DO NOTHING;
