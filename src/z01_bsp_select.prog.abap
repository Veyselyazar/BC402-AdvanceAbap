*&---------------------------------------------------------------------*
*& Report Z01_BSP_SELECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_select.

"data go_alv type REF TO cl_salv_table.
DATA gs_spfli TYPE spfli.
DATA gt_spfli TYPE TABLE OF spfli.
DATA gv_carrid TYPE spfli-carrid.
DATA gv_connid TYPE spfli-connid.
PARAMETERS pa_feld type string default 'carrid connid cityfrom cityto'.
PARAMETERS pa_where type string DEFAULT `carrid = 'AA' `.

SELECT  (pa_feld)
  FROM spfli
  "INTO (gv_carrid, gv_connid, gs_spfli-cityfrom, gs_spfli-cityto)
  INTO CORRESPONDING FIELDS OF table gt_spfli
  WHERE (pa_where) .

cl_salv_table=>factory(
  IMPORTING
    r_salv_table   = data(go_alv)
  CHANGING
    t_table        = gt_spfli
       ).

go_alv->display( ).
