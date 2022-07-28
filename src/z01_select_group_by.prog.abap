*&---------------------------------------------------------------------*
*& Report Z01_SELECT_GROUP_BY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_select_group_by.



" Aggregatsfunktionen: Count, SUM, AVG, MIN, MAX

TYPES: BEGIN OF tv_collect,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         anzahl    TYPE i,
         summe_occ TYPE i,
         avg_occ   TYPE p DECIMALS 2,
         summe_max TYPE i,
       END OF tv_collect.

DATA gt_collect TYPE STANDARD TABLE OF tv_collect
                     WITH NON-UNIQUE  KEY carrid connid.
DATA gv_occ TYPE i.
SELECT-OPTIONS so_occ FOR gv_occ.

SELECT carrid connid COUNT(*) SUM( seatsocc ) AVG( seatsocc ) SUM( seatsmax )
       FROM sflight
       INTO TABLE gt_collect
       GROUP BY carrid connid
       HAVING AVG( seatsocc ) IN so_occ.

cl_salv_table=>factory(
  IMPORTING
    r_salv_table   =     DATA(go_alv)
  CHANGING
    t_table        = gt_collect
).

go_alv->display( ).
