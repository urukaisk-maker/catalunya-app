-- =====================================================
--  02 — AMPLIACIÓ MASSIVA DE CONTINGUT
--  Injecció en calent (no requereix recrear el volum)
-- =====================================================

-- =====================================================
--  COMARQUES (41 oficials, amb capital)
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

-- =====================================================
--  MUNICIPIS (ampliació)
-- =====================================================
INSERT INTO municipis (nom, comarca_id, poblacio, latitud, longitud) VALUES
('Vilafranca del Penedès', 14, 39000, 41.345800, 1.697500),
('Igualada',               15, 40000, 41.578500, 1.617400),
('Manresa',                16, 78000, 41.724900, 1.825900),
('Vilanova i la Geltrú',   20, 67000, 41.224300, 1.725700),
('Vic',                    23, 46000, 41.930400, 2.254700),
('Terrassa',               24, 220000, 41.563500, 2.008900),
('Granollers',             25, 61000, 41.608200, 2.287800),
('Olot',                   28, 36000, 42.182200, 2.489400),
('Banyoles',               30, 20000, 42.118200, 2.766300),
('Ripoll',                 31, 10600, 42.201100, 2.190600),
('Blanes',                 32, 39000, 41.674400, 2.790600),
('Lloret de Mar',          32, 38000, 41.700600, 2.845300),
('La Seu d''Urgell',       33, 12500, 42.358900, 1.457500),
('El Pont de Suert',       34,  2400, 42.407200, 0.740700),
('Les Borges Blanques',    35,  6100, 41.521400, 0.871900),
('Balaguer',               36, 17000, 41.789900, 0.808700),
('Tremp',                  37,  6000, 42.167800, 0.894200),
('Sort',                   38,  2200, 42.410600, 1.130600),
('Mollerussa',             39, 15000, 41.631100, 0.892500),
('Cervera',                40,  9300, 41.670700, 1.271700),
('Solsona',                42,  9200, 41.994200, 1.517500),
('Tàrrega',                43, 17000, 41.646700, 1.139400),
('Valls',                  45, 24500, 41.286100, 1.250000),
('Tortosa',                47, 33500, 40.812500, 0.521400),
('El Vendrell',            48, 38000, 41.220600, 1.534700),
('Montblanc',              49,  7400, 41.376700, 1.163300),
('Móra d''Ebre',           53,  5600, 41.091100, 0.640800),
('Gandesa',                55,  3100, 41.053600, 0.438900),
('Berga',                  19, 16500, 42.100600, 1.845800),
('Santa Coloma de Farners',32, 13000, 41.862800, 2.665000),
('La Bisbal d''Empordà',   27, 10800, 41.960800, 3.039700),
('Moià',                   22,  6400, 41.811400, 2.096900)
ON CONFLICT DO NOTHING;

-- =====================================================
--  MONUMENTS / POIs (30+)
-- =====================================================
INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio) VALUES
('Monestir de Montserrat',      16, 'Religiós',     'Abadia benedictina al massís de Montserrat, símbol espiritual de Catalunya.', 41.593300, 1.838100, 1025),
('Cripta de la Colònia Güell',   1, 'Modernista',   'Obra inacabada de Gaudí, precursora de la Sagrada Família.',                   41.363900, 2.028000, 1917),
('Monestir de Poblet',          49, 'Religiós',     'Monestir cistercenc, Patrimoni de la UNESCO, panteó reial de la Corona d''Aragó.', 41.380800, 1.082200, 1151),
('Monestir de Santes Creus',    49, 'Religiós',     'Monestir cistercenc del segle XII, mostra del romànic i gòtic català.',       41.393900, 1.361900, 1160),
('Castell de Cardona',          16, 'Castell',      'Fortalesa medieval sobre el Cardener, hostatgeria i parador nacional.',        41.913900, 1.681100, 886),
('Catedral de Tarragona',       11, 'Religiós',     'Catedral gòtica amb claustre romànic, al cor de la Tarraco romana.',           41.119200, 1.258300, 1170),
('Muralla de Tarragona',        11, 'Romà',         'Recinte emmurallat romà, restes visibles del segle III aC.',                   41.119400, 1.259400, -217),
('Aqüeducte de les Ferreres',   11, 'Romà',         'Aqüeducte romà conegut com el Pont del Diable, als afores de Tarragona.',      41.147500, 1.248700, 100),
('Castell de Miravet',          53, 'Castell',      'Castell templer sobre el riu Ebre, exemple únic de fortalesa templera.',       41.036900, 0.597500, 1153),
('Catedral de la Seu d''Urgell',33, 'Religiós',     'Única catedral romànica completa de Catalunya, amb claustre i museu diocesà.', 42.358300, 1.457500, 1116),
('Església de Sant Climent de Taüll', 34, 'Romànic', 'Església romànica UNESCO amb campanar de torre i frescos famosos.',            42.518300, 0.848100, 1123),
('Església de Santa Maria de Taüll', 34, 'Romànic', 'Segona església romànica de Taüll, també Patrimoni de la UNESCO.',            42.517500, 0.849700, 1123),
('Monestir de Ripoll',          31, 'Religiós',     'Bressol del romànic català, amb la famosa portalada del segle XII.',           42.201100, 2.190600, 888),
('Monestir de Sant Joan de les Abadesses', 31, 'Religiós', 'Monestir benedictí femení fundat el 887 per Guifré el Pelós.',              42.233300, 2.283900, 887),
('Castell de Peralada',         30, 'Castell',      'Castell-museu amb biblioteca històrica i casino, a l''Alt Empordà.',           42.308900, 3.009400, 1300),
('Catedral de Girona',           4, 'Religiós',     'Catedral gòtica amb la nau més ampla del món (23m), barri jueu al costat.',     41.987500, 2.825600, 1038),
('Banys Àrabs de Girona',        4, 'Història',     'Banys àrabs del segle XII, un dels testimonis de la Girona medieval.',          41.986900, 2.825300, 1194),
('Pals',                        27, 'Medieval',     'Poble medieval amb carrers empedrats i la Torre de les Hores.',                 41.971900, 3.147800, 1000),
('Peratallada',                 27, 'Medieval',     'Poble medieval excavat a la roca, un dels millors conservats de Catalunya.',    41.977500, 3.089400, 1000),
('Castell de Sant Ferran',       5, 'Castell',      'Fortalesa militar del segle XVIII, la més gran d''Europa.',                     42.267500, 2.953600, 1753),
('Casa-Museu Castell Gala-Dalí', 5, 'Museu',        'Casa de Dalí a Portlligat, amb vistes a la badia de Cadaqués.',                 42.289200, 3.286400, 1930),
('Teatre-Museu Dalí',            5, 'Museu',        'Museu surrealista al Teatre Municipal de Figueres, amb cúpula i ous gegants.', 42.267000, 2.960000, 1974),
('Catedral de Lleida (Seu Nova)',6, 'Religiós',     'Catedral barroca de Lleida, seu del bisbat des del segle XVIII.',               41.614700, 0.626100, 1781),
('La Paeria',                    6, 'Història',     'Palau municipal de Lleida, exemple d''arquitectura civil gòtica civil.',       41.615800, 0.625600, 1383),
('Castell de Lleida (La Suda)',  6, 'Castell',      'Fortalesa andalusina sobre el turó, avui seu del Parlament històric.',          41.618300, 0.625300, 900),
('Catedral de Tortosa',         47, 'Religiós',     'Catedral gòtica de Tortosa, al costat del castell templer.',                    40.812500, 0.521400, 1347),
('Castell de Tortosa',          47, 'Castell',      'Castell-catedral templer sobre el riu Ebre, símbol de la ciutat.',             40.812800, 0.521900, 1150),
('Monestir de Sant Cugat',       2, 'Romànic',      'Monestir benedictí amb claustre romànic famós pels seus capitells.',           41.472800, 2.085000, 950),
('Catedral de la Seu d''Urgell (claustre)', 33, 'Romànic', 'Claustre romànic de la catedral d''Urgell.',                          42.358300, 1.457500, 1180),
('Torre de la Creu',             1, 'Modernista',   'Torre modernista obra de Puig i Cadafalch, a Sant Joan Despí.',                 41.367200, 2.057500, 1900),
('Palau de la Música Catalana',  1, 'Modernista',   'Sala de concerts modernista de Domènech i Montaner, Patrimoni de la UNESCO.',   41.387600, 2.175300, 1908),
('Hospital de Sant Pau',         1, 'Modernista',   'Recinte hospitalari modernista de Domènech i Montaner, Patrimoni de la UNESCO.',41.413300, 2.174200, 1930),
('Casa Batlló',                  1, 'Modernista',   'Casa modernista de Gaudí al Passeig de Gràcia, símbol del modernisme.',        41.391700, 2.164900, 1906),
('La Pedrera (Casa Milà)',       1, 'Modernista',   'Últim edifici civil de Gaudí, amb la famosa façana ondulada.',                 41.395200, 2.161900, 1912)
ON CONFLICT DO NOTHING;

-- =====================================================
--  PLATS TRADICIONALS (15+)
-- =====================================================
INSERT INTO plats_tradicionals (nom, descripcio, origen, provincia_id, temporada) VALUES
('Fuet',                 'Embotit curat típic de Vic i Osona, fet de carn magra de porc i pebre negre.',                   'Osona',          1, 'Tot l''any'),
('Botifarra amb mongetes', 'Botifarra fresca a la brasa amb mongetes seques, platestre català per excel·lència.',        'Tota Catalunya', 1, 'Tot l''any'),
('Escalivada',            'Verdures (pebrot, albergínia, ceba) escalivades a la brasa i amanides amb oli d''oliva.',      'Tota Catalunya', 1, 'Estiu'),
('Esqueixada',            'Amanida de bacallà esqueixat, tomàquet, ceba, olives i oli d''oliva.',                        'Costa catalana', 2, 'Estiu'),
('Suquet de peix',        'Guisat mariner amb patates, peix de roca i picada d''ametlles.',                              'Costa Brava',    2, 'Tot l''any'),
('Zarzuela',              'Guisat de peix i marisc amb sofregit de tomàquet, ceba i vi blanc.',                         'Costa catalana', 4, 'Tot l''any'),
('Arròs del Delta',       'Arròs amb peix i marisc del Delta de l''Ebre, amb musclos i gambes.',                        'Delta de l''Ebre', 4, 'Tot l''any'),
('Fideuà',                'Plat de fideus gruixuts amb peix i marisc, germà de la paella.',                              'Costa catalana', 4, 'Tot l''any'),
('Escudella i carn d''olla','Sopa amb pilota, verdures i carns. El plat del Nadal català.',                             'Tota Catalunya', 1, 'Nadal'),
('Capó de Nadal',         'Gall d''indi o pollastre farcit, plat central del dinar de Nadal.',                          'Tota Catalunya', 1, 'Nadal'),
('Tortell de Reis',       'Pastís de massapà, fruita confitada i pinyons, típic del dia de Reis.',                      'Tota Catalunya', 1, 'Gener'),
('Panellets',             'Dolços d''ametlla, patata i sucre, típics de Tots Sants.',                                   'Tota Catalunya', 1, 'Novembre'),
('Coca de Sant Joan',     'Coca amb fruita confitada, pinyons i crema, típica de la nit de Sant Joan.',                'Tota Catalunya', 1, 'Juny'),
('Mel i mató',            'Mató fresc amb mel, postres senzill i tradicional del Pirineu.',                            'Pirineu',        3, 'Tot l''any'),
('Oli d''oliva de les Garrigues', 'Oli verge extra amb DO pròpia, un dels millors del món.',                          'Les Garrigues',  3, 'Tot l''any'),
('Romesco',               'Salsa de tomàquet, nyores, avellanes, ametlles i all, acompanya calçots i peix.',            'Camp de Tarragona', 4, 'Tot l''any')
ON CONFLICT (nom) DO NOTHING;

-- =====================================================
--  FESTES I TRADICIONS (12+)
-- =====================================================
INSERT INTO festes_tradicions (nom, descripcio, lloc, provincia_id, epoca, patrimoni_unesco) VALUES
('La Mercè',               'Festa major de Barcelona, amb correfocs, castellers, gegants i concerts.',                'Barcelona',       1, 'Setembre',    FALSE),
('Sant Jordi',             'Dia del llibre i de la rosa, la Diada més romàntica i cultural de Catalunya.',              'Tota Catalunya',  NULL, '23 d''abril', FALSE),
('Nit de Sant Joan',       'Nit de revetlles, foguera i petards, la nit més curta de l''any.',                          'Tota Catalunya',  NULL, '23 de juny',  FALSE),
('Diada Nacional',         'Onze de Setembre, Diada Nacional de Catalunya, amb ofrenes i manifestacions.',               'Tota Catalunya',  NULL, '11 setembre', FALSE),
('Cavalcada de Reis',      'Els Reis Mags desfilen el 5 de gener i reparteixen regals als nens.',                     'Tota Catalunya',  NULL, '5 de gener',  FALSE),
('Festa Major de Gràcia',  'Festes de carrer amb decorats fets pels veïns, a Barcelona.',                              'Barcelona',       1, 'Agost',       FALSE),
('Festa Major de Sants',   'Festes de carrer amb decorats temàtics, al barri de Sants de Barcelona.',                   'Barcelona',       1, 'Agost',       FALSE),
('La Patum de Berga',      'Festa del Corpus amb foc, pirotècnia i bestiari místic.',                                   'Berga',           1, 'Corpus',      TRUE),
('Festa de Sant Medir',    'Desfilada de carrosses i dolços al barri de Gràcia, al març.',                             'Barcelona',       1, 'Març',        FALSE),
('Temps de Flors',         'Girona s''omple de flors i art als patis i carrers del barri vell.',                       'Girona',          2, 'Maig',        FALSE),
('Fira de Sant Narcís',    'Festa major de Girona, amb fires, concerts i activitats familiars.',                       'Girona',          2, 'Octubre',     FALSE),
('Festa de la Mare de Déu de Montserrat', 'Celebració al santuari de Montserrat, amb cant de la Salve.', 'Montserrat',      1, '27 d''abril', FALSE),
('Carnaval de Sitges',     'El carnaval més famós de Catalunya, amb disfresses espectaculars i rues.',                  'Sitges',          1, 'Febrer',      FALSE),
('Correfoc de la Mercè',   'Diables, bèsties i carretilles de foc pels carrers de Barcelona.',                         'Barcelona',       1, 'Setembre',    FALSE)
ON CONFLICT (nom) DO NOTHING;
