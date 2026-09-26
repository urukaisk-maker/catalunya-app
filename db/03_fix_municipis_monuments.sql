-- =====================================================
--  03 — REPARACIÓ: municipis i monuments amb subconsultes
--  (evita col·lisions d'IDs)
-- =====================================================

-- ---------- MUNICIPIS ----------
INSERT INTO municipis (nom, comarca_id, poblacio, latitud, longitud)
SELECT v.nom, c.id, v.poblacio, v.latitud, v.longitud
FROM (VALUES
  ('Vilafranca del Penedès', 'Alt Penedès',       39000, 41.345800::numeric, 1.697500::numeric),
  ('Igualada',               'Anoia',             40000, 41.578500, 1.617400),
  ('Manresa',                'Bages',             78000, 41.724900, 1.825900),
  ('Vilanova i la Geltrú',   'Garraf',            67000, 41.224300, 1.725700),
  ('Vic',                    'Osona',             46000, 41.930400, 2.254700),
  ('Terrassa',               'Vallès Occidental', 220000, 41.563500, 2.008900),
  ('Granollers',             'Vallès Oriental',   61000, 41.608200, 2.287800),
  ('Olot',                   'Garrotxa',          36000, 42.182200, 2.489400),
  ('Banyoles',               'Pla de l''Estany',  20000, 42.118200, 2.766300),
  ('Ripoll',                 'Ripollès',          10600, 42.201100, 2.190600),
  ('Blanes',                 'Selva',             39000, 41.674400, 2.790600),
  ('Lloret de Mar',          'Selva',             38000, 41.700600, 2.845300),
  ('La Seu d''Urgell',       'Alt Urgell',        12500, 42.358900, 1.457500),
  ('El Pont de Suert',       'Alta Ribagorça',     2400, 42.407200, 0.740700),
  ('Les Borges Blanques',    'Garrigues',          6100, 41.521400, 0.871900),
  ('Balaguer',               'Noguera',           17000, 41.789900, 0.808700),
  ('Tremp',                  'Pallars Jussà',      6000, 42.167800, 0.894200),
  ('Sort',                   'Pallars Sobirà',     2200, 42.410600, 1.130600),
  ('Mollerussa',             'Pla d''Urgell',     15000, 41.631100, 0.892500),
  ('Cervera',                'Segarra',            9300, 41.670700, 1.271700),
  ('Solsona',                'Solsonès',           9200, 41.994200, 1.517500),
  ('Tàrrega',                'Urgell',            17000, 41.646700, 1.139400),
  ('Valls',                  'Alt Camp',          24500, 41.286100, 1.250000),
  ('Tortosa',                'Baix Ebre',         33500, 40.812500, 0.521400),
  ('El Vendrell',            'Baix Penedès',      38000, 41.220600, 1.534700),
  ('Montblanc',              'Conca de Barberà',   7400, 41.376700, 1.163300),
  ('Móra d''Ebre',           'Ribera d''Ebre',     5600, 41.091100, 0.640800),
  ('Gandesa',                'Terra Alta',         3100, 41.053600, 0.438900),
  ('Berga',                  'Berguedà',          16500, 42.100600, 1.845800),
  ('Santa Coloma de Farners','Selva',             13000, 41.862800, 2.665000),
  ('La Bisbal d''Empordà',   'Baix Empordà',      10800, 41.960800, 3.039700),
  ('Moià',                   'Moianès',            6400, 41.811400, 2.096900)
) AS v(nom, comarca, poblacio, latitud, longitud)
JOIN comarques c ON c.nom = v.comarca
WHERE NOT EXISTS (SELECT 1 FROM municipis m WHERE m.nom = v.nom);

-- ---------- MONUMENTS ----------
INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio)
SELECT v.nom, m.id, v.tipus, v.descripcio, v.latitud, v.longitud, v.any_construccio
FROM (VALUES
  ('Monestir de Montserrat',           'Manresa',          'Religiós',   'Abadia benedictina al massís de Montserrat, símbol espiritual de Catalunya.',  41.593300, 1.838100, 1025),
  ('Cripta de la Colònia Güell',       'Barcelona',        'Modernista', 'Obra inacabada de Gaudí, precursora de la Sagrada Família.',                   41.363900, 2.028000, 1917),
  ('Monestir de Poblet',               'Montblanc',        'Religiós',   'Monestir cistercenc, Patrimoni UNESCO, panteó reial de la Corona d''Aragó.',  41.380800, 1.082200, 1151),
  ('Monestir de Santes Creus',         'Montblanc',        'Religiós',   'Monestir cistercenc del segle XII, mostra del romànic i gòtic català.',        41.393900, 1.361900, 1160),
  ('Castell de Cardona',               'Manresa',          'Castell',    'Fortalesa medieval sobre el Cardener, hostatgeria i parador nacional.',        41.913900, 1.681100,  886),
  ('Catedral de Tarragona',            'Tarragona',        'Religiós',   'Catedral gòtica amb claustre romànic, al cor de la Tarraco romana.',           41.119200, 1.258300, 1170),
  ('Aqüeducte de les Ferreres',        'Tarragona',        'Romà',       'Aqüeducte romà conegut com el Pont del Diable.',                                41.147500, 1.248700,  100),
  ('Catedral de la Seu d''Urgell',     'La Seu d''Urgell', 'Religiós',   'Única catedral romànica completa de Catalunya, amb claustre i museu.',         42.358300, 1.457500, 1116),
  ('Església de Sant Climent de Taüll','El Pont de Suert', 'Romànic',    'Església romànica UNESCO amb campanar de torre i frescos famosos.',            42.518300, 0.848100, 1123),
  ('Monestir de Ripoll',               'Ripoll',           'Religiós',   'Bressol del romànic català, amb la famosa portalada del segle XII.',           42.201100, 2.190600,  888),
  ('Castell de Peralada',              'Figueres',         'Castell',    'Castell-museu amb biblioteca històrica i casino, a l''Alt Empordà.',           42.308900, 3.009400, 1300),
  ('Catedral de Girona',               'Girona',           'Religiós',   'Catedral gòtica amb la nau més ampla del món, al costat del barri jueu.',      41.987500, 2.825600, 1038),
  ('Banys Àrabs de Girona',            'Girona',           'Història',   'Banys àrabs del segle XII, testimonis de la Girona medieval.',                 41.986900, 2.825300, 1194),
  ('Castell de Sant Ferran',           'Figueres',         'Castell',    'Fortalesa militar del segle XVIII, la més gran d''Europa.',                    42.267500, 2.953600, 1753),
  ('Catedral de Lleida (Seu Nova)',    'Lleida',           'Religiós',   'Catedral barroca de Lleida, seu del bisbat des del segle XVIII.',              41.614700, 0.626100, 1781),
  ('La Paeria',                        'Lleida',           'Història',   'Palau municipal de Lleida, exemple d''arquitectura civil gòtica.',             41.615800, 0.625600, 1383),
  ('Castell de Lleida (La Suda)',      'Lleida',           'Castell',    'Fortalesa andalusina sobre el turó.',                                           41.618300, 0.625300,  900),
  ('Catedral de Tortosa',              'Tortosa',          'Religiós',   'Catedral gòtica de Tortosa, al costat del castell templer.',                   40.812500, 0.521400, 1347),
  ('Castell de Tortosa',               'Tortosa',          'Castell',    'Castell-catedral templer sobre el riu Ebre.',                                  40.812800, 0.521900, 1150),
  ('Monestir de Sant Cugat',           'Barcelona',        'Romànic',    'Monestir benedictí amb claustre romànic famós pels seus capitells.',           41.472800, 2.085000,  950),
  ('Palau de la Música Catalana',      'Barcelona',        'Modernista', 'Sala de concerts modernista de Domènech i Montaner, Patrimoni UNESCO.',        41.387600, 2.175300, 1908),
  ('Hospital de Sant Pau',             'Barcelona',        'Modernista', 'Recinte hospitalari modernista, Patrimoni de la UNESCO.',                      41.413300, 2.174200, 1930),
  ('Casa Batlló',                      'Barcelona',        'Modernista', 'Casa modernista de Gaudí al Passeig de Gràcia.',                               41.391700, 2.164900, 1906),
  ('La Pedrera (Casa Milà)',           'Barcelona',        'Modernista', 'Últim edifici civil de Gaudí, amb la famosa façana ondulada.',                 41.395200, 2.161900, 1912)
) AS v(nom, municipi, tipus, descripcio, latitud, longitud, any_construccio)
JOIN municipis m ON m.nom = v.municipi
WHERE NOT EXISTS (SELECT 1 FROM monuments mo WHERE mo.nom = v.nom);
