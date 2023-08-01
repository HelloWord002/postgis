\set VERBOSITY terse
set client_min_messages to NOTICE;
SELECT 't0', ST_Normalize(ST_OffsetCurve('POINT(0 0)', 10));
SELECT 't0', ST_AsEWKT(ST_Normalize(ST_OffsetCurve('SRID=42;LINESTRING(0 0, 10 0)', 0)));
SELECT 't1', ST_AsEWKT(ST_Normalize(ST_OffsetCurve('SRID=42;LINESTRING(0 0, 10 0)', 10)));
SELECT 't2', ST_AsEWKT(ST_Normalize(ST_OffsetCurve('SRID=42;LINESTRING(0 0, 10 0)', -10)));
SELECT 't3', ST_AsEWKT(ST_Normalize(ST_OffsetCurve('SRID=42;LINESTRING(10 0, 0 0)', 10)));
SELECT 't4', ST_AsEWKT(ST_Normalize(ST_OffsetCurve('SRID=42;LINESTRING(10 0, 0 0)', -10)));
SELECT 't5', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 10 10)', -10),
1)));
SELECT 't5b', ST_AsEWKT(ST_Normalize(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 10 10)', 10)));
SELECT 't6', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 10 10)', -10,
 'quad_segs=2'),1)));
SELECT 't7', ST_AsEWKT(ST_Normalize(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 10 10)', -10,
 'join=bevel'))
);
SELECT 't8', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 10 10)', -10,
 'quad_segs=2 join=mitre'),
1)));
-- SELECT 't9', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
--  'SRID=42;LINESTRING(0 0, 10 0, 5 10)', -10,
--  'quad_segs=2 join=mitre mitre_limit=1'),1)));
SELECT 't10', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 5 10)', 2,
 'quad_segs=2 join=mitre mitre_limit=1'),
1)));
SELECT 't10b', ST_AsEWKT(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'SRID=42;LINESTRING(0 0, 10 0, 5 10)', 2,
 'quad_segs=2 join=miter miter_limit=1'),
1)));
SELECT 't11', ST_AsText(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'LINESTRING(36 38,38 35,41 34,42 33,45 32,47 28,50 28,52 32,57 33)', 2,
 'join=mitre'),
0.2)), 1);
SELECT 't12', ST_AsText(ST_Normalize(ST_SnapToGrid(ST_OffsetCurve(
 'LINESTRING(36 38,38 35,41 34,42 33,45 32,47 28,50 28,52 32,57 33)', -2,
 'join=mitre'),
0.2)), 1);
SELECT 't13', ST_AsEWKT(ST_Normalize(ST_Simplify(ST_OffsetCurve(
 'LINESTRING(0 0,0 20, 10 20, 10 10, 0 10)', 2,
 'join=mitre'
), 0)));
-- SELECT 't14', ST_AsEWKT(ST_Normalize(ST_OffsetCurve(
--  'LINESTRING(0 0,0 20, 10 20, 10 10, 0 10)', -2,
--  ''
-- )));
-- SELECT 't15', ST_AsEWKT(ST_Normalize(ST_OffsetCurve(
--  'GEOMETRYCOLLECTION(LINESTRING(0 0,0 20, 10 20, 10 10, 0 10),MULTILINESTRING((2 0,2 20, 12 20, 12 10, 2 10),(3 0,3 20, 13 20, 13 10, 3 10)))', -2,
--  ''
-- )));
select '#2508', ST_IsValid(ST_OffsetCurve(
	'0102000020BB0B000010000000FBB019D1AD1537414A733C4E5333534167CE8F06B815374151F4926C4D335341C4899405B61537413DB009254A335341513EE234AD1537413689A27947335341E38CCA31AB1537415D00E28E44335341951F7F0BB315374104E4CA2441335341A581F041BF153741D46F9F8A3F33534100C27968CD153741C6CAAFE83F335341493DB10CDA1537418919897142335341FCA312FCE01537415D1A1F8045335341C62D3822DD153741554B118E483353411B98FE61D1153741FC35CEE14A33534106DCFDA5C5153741573BD3584B33534167CE8F06B815374151F4926C4D335341FBB019D1AD1537414A733C4E533353414AEB33644E153741595A854786335341',
	10
));
