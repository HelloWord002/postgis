set client_min_messages to WARNING;

\i :top_builddir/topology/test/load_topology-4326.sql
\i ../load_features.sql
\i ../more_features.sql
\i ../hierarchy.sql

SELECT topology.CopyTopology('city_data', 'CITY_data_UP_down') > 0;

SELECT srid,precision FROM topology.topology WHERE name = 'CITY_data_UP_down';

SELECT 'nodes', count(node_id) FROM "CITY_data_UP_down".node;
SELECT * FROM "CITY_data_UP_down".node EXCEPT
SELECT * FROM "city_data".node;

SELECT 'edges', count(edge_id) FROM "CITY_data_UP_down".edge_data;
SELECT * FROM "CITY_data_UP_down".edge EXCEPT
SELECT * FROM "city_data".edge;

SELECT 'faces', count(face_id) FROM "CITY_data_UP_down".face;
SELECT * FROM "CITY_data_UP_down".face EXCEPT
SELECT * FROM "city_data".face;

SELECT 'relations', count(*) FROM "CITY_data_UP_down".relation;
SELECT * FROM "CITY_data_UP_down".relation EXCEPT
SELECT * FROM "city_data".relation;

SELECT 'layers', count(l.*) FROM topology.layer l, topology.topology t
WHERE l.topology_id = t.id and t.name = 'CITY_data_UP_down';
SELECT l.layer_id, l.feature_type, l.level FROM topology.layer l,
topology.topology t where l.topology_id = t.id and t.name = 'CITY_data_UP_down'
EXCEPT
SELECT l.layer_id, l.feature_type, l.level FROM topology.layer l,
topology.topology t where l.topology_id = t.id and t.name = 'city_data';

SELECT l.layer_id, l.schema_name, l.table_name, l.feature_column
FROM topology.layer l, topology.topology t
WHERE l.topology_id = t.id and t.name = 'CITY_data_UP_down'
ORDER BY l.layer_id;

-- Check sequences
SELECT tableoid::regclass AS sequence_name, last_value,  is_called from "CITY_data_UP_down".node_node_id_seq;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called from "CITY_data_UP_down".edge_data_edge_id_seq;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called from "CITY_data_UP_down".face_face_id_seq;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called from "CITY_data_UP_down".layer_id_seq;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called  from "CITY_data_UP_down".topogeo_s_1;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called  from "CITY_data_UP_down".topogeo_s_2;
SELECT tableoid::regclass AS sequence_name, last_value,  is_called  from "CITY_data_UP_down".topogeo_s_3;

-- See https://trac.osgeo.org/postgis/ticket/5298
BEGIN;
UPDATE city_data.relation SEt layer_id = 1 WHERE layer_id = 1;
SELECT '#5298', topology.CopyTopology('city_data', 'city_data_t5298') > 0;
ROLLBACK;

-- See http://trac.osgeo.org/postgis/ticket/2184
select '#2184.1', topology.createTopology('t3d', 0, 0, true) > 0;
select '#2184.2', st_addisonode('t3d', NULL, 'POINT(1 2 3)');
select '#2184.3', topology.copyTopology('t3d', 't3d-bis') > 0;
select '#2184.4', length(topology.dropTopology('t3d')) > 0, length(topology.dropTopology('t3d-bis')) > 0;

-- Cleanup

SELECT topology.DropTopology('CITY_data_UP_down');
SELECT topology.DropTopology('city_data');
DROP SCHEMA features CASCADE;
