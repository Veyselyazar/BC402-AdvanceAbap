*&---------------------------------------------------------------------*
*& Report Z01_COLLECT_SFLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_collect_sflight.

DATA gs_sflight TYPE sflight.
TYPES: BEGIN OF ty_collect,
         carrid   TYPE scarr-carrid,
         connid   TYPE n LENGTH 4,
         seatsmax TYPE i,
         seatsocc TYPE i,
       END OF ty_collect.

DATA gs_collect TYPE ty_collect.
DATA gt_collect TYPE hashed TABLE OF ty_collect WITH UNIQUE KEY carrid connid.

SELECT * FROM sflight INTO gs_sflight.
  MOVE-CORRESPONDING gs_sflight TO gs_collect.
  COLLECT gs_collect INTO gt_collect.
ENDSELECT.

LOOP AT gt_collect INTO gs_collect.
  ON CHANGE OF gs_collect-carrid.
    ULINE.
  ENDON.
  WRITE: / gs_collect-carrid,
           gs_collect-connid,
           gs_collect-seatsmax,
           gs_collect-seatsocc.
ENDLOOP.
