*&---------------------------------------------------------------------*
*& Report Z01_INTERNE_TABELLEN_DEF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_interne_tabellen_def.

DATA gs_spfli TYPE spfli.

DATA: BEGIN OF  gs_corres,
        name1  TYPE string,
        carrid TYPE c LENGTH 5,
        ort1   TYPE c LENGTH 40,
        connid TYPE n LENGTH 4,
      END OF gs_corres.

DATA gt_corres LIKE TABLE OF gs_corres.

DATA gv_index_start TYPE i VALUE 4.
DATA gt_spfli1 TYPE TABLE OF spfli . "Standard-Tabelle
DATA gt_spfli2 TYPE STANDARD TABLE OF spfli WITH NON-UNIQUE KEY carrid connid .
DATA gt_sorted TYPE SORTED   TABLE OF spfli WITH NON-UNIQUE KEY carrid connid .
DATA gt_hashed TYPE HASHED   TABLE OF spfli WITH UNIQUE KEY carrid connid .

* Standard-Tabelle
SELECT * FROM spfli INTO TABLE gt_spfli2 ORDER BY cityfrom DESCENDING.
MOVE-CORRESPONDING gt_spfli2 TO gt_corres.  " 47
SELECT * FROM spfli APPENDING TABLE gt_spfli2.


SORT gt_spfli2 BY carrid .
DELETE ADJACENT DUPLICATES FROM gt_spfli2 COMPARING ALL FIELDS.


"gt_spfli1 = gt_spfli2.
MOVE-CORRESPONDING gt_spfli2 TO gt_corres KEEPING TARGET LINES. " 47 + 94

READ TABLE gt_spfli2 INTO gs_spfli INDEX 5.
READ TABLE gt_spfli2 INTO gs_spfli WITH KEY carrid = 'AA' cityfrom = 'NEW YORK'.

LOOP AT gt_spfli2 INTO gs_spfli WHERE connid BETWEEN 100 AND 400.
  WRITE: gs_spfli-carrid, gs_spfli-connid  .
ENDLOOP.
SORT gt_spfli2 BY carrid connid.
READ TABLE gt_spfli2 INTO gs_spfli WITH  KEY carrid = 'AA' connid = 17 BINARY SEARCH.
READ TABLE gt_spfli2 INTO gs_spfli WITH  KEY carrid = 'AA' connid = 26 BINARY SEARCH.
READ TABLE gt_spfli2 INTO gs_spfli WITH  KEY carrid = 'LH' connid = 400 BINARY SEARCH.
SORT gt_spfli2 BY cityfrom.
READ TABLE gt_spfli2 INTO gs_spfli WITH KEY cityfrom = 'FRANKFURT' BINARY SEARCH.
READ TABLE gt_spfli2 INTO gs_spfli WITH KEY cityfrom = 'BERLIN' BINARY SEARCH.
READ TABLE gt_spfli2 INTO gs_spfli WITH KEY cityfrom = 'NEW York' BINARY SEARCH.

READ TABLE gt_spfli2  WITH  KEY carrid = 'AA' connid = 17 BINARY SEARCH TRANSPORTING NO FIELDS.
CLEAR gs_spfli.
gs_spfli-carrid = 'KLM'. gs_spfli-connid = 234.
INSERT gs_spfli INTO TABLE gt_spfli2. "Ans Ende

* Sorted-Tabelle
SELECT * FROM spfli INTO TABLE gt_sorted ORDER BY cityfrom DESCENDING.
"SELECT * FROM spfli APPENDING TABLE gt_sorted.
CLEAR gs_spfli.
READ TABLE gt_sorted INTO gs_spfli INDEX 5 TRANSPORTING cityfrom.

READ TABLE gt_sorted INTO gs_spfli WITH TABLE KEY  connid = '26' carrid = 'AA'.

DELETE gt_sorted INDEX 2.

LOOP AT gt_sorted INTO gs_spfli.
  IF gs_spfli-arrtime > '120000'.
    " gs_spfli-arrtime = '120000'.
    DELETE gt_sorted.
*    MODIFY gt_sorted FROM gs_spfli INDEX 5.
  ENDIF.

ENDLOOP.


INSERT gs_spfli INTO  gt_spfli2 INDEX 3.

DELETE gt_sorted  INDEX: 3, 1. " Gelöscht wird 1. und 3. datensatz
gs_spfli-carrid = 'LH'.
gs_spfli-connid = 400.
DELETE TABLE gt_sorted FROM gs_spfli.

WHILE lines( gt_sorted ) > 0.
  DELETE  gt_sorted INDEX 1.
ENDWHILE.

CLEAR gs_spfli.
gs_spfli-carrid = 'KLM'. gs_spfli-connid = 234.
INSERT gs_spfli INTO TABLE gt_sorted. "Ans Ende
"insert gs_spfli inTO gt_sorted index 10. "Ans Ende

* Hashed.
SELECT * FROM spfli INTO TABLE gt_hashed ORDER BY cityfrom DESCENDING.
"READ TABLE gt_hashed INTO gs_spfli INDEX 5.
READ TABLE gt_hashed INTO gs_spfli WITH KEY carrid = 'AA' connid = '26'. "Hash-Zugriff
READ TABLE gt_hashed INTO gs_spfli WITH KEY cityfrom = 'Frankfurt' cityto = 'Berlin'." Sequentiell

DELETE TABLE gt_hashed WITH TABLE KEY carrid = 'LH' connid = '400'.
DELETE gt_hashed WHERE carrid = 'LH' AND connid = '400'.

BREAK-POINT.
