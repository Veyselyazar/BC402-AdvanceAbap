*&---------------------------------------------------------------------*
*& Report Z01_LOOP_REFERENZEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_loop_referenzen.

DATA gt_spfli TYPE TABLE OF spfli.
SELECT * FROM spfli INTO TABLE gt_spfli.

DATA gr_spfli TYPE REF TO spfli.

LOOP AT gt_spfli REFERENCE INTO gr_spfli.
  WRITE: / gr_spfli->cityfrom,
           gr_spfli->*-cityto.
ENDLOOP.
ULINE.
READ TABLE gt_spfli REFERENCE INTO gr_spfli WITH KEY carrid = 'AA' connid = '17'.
WRITE: / gr_spfli->cityfrom,
         gr_spfli->*-cityto.
**********************************************************************
FIELD-SYMBOLS <fs_line> TYPE spfli.

LOOP AT gt_spfli ASSIGNING <fs_line>.
  WRITE: / <fs_line>-carrid,
           <fs_line>-connid,
           <fs_line>-cityfrom.

ENDLOOP.

READ TABLE gt_spfli ASSIGNING <fs_line> WITH KEY carrid = 'AA' connid = 64.
