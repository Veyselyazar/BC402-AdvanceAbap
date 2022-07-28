*&---------------------------------------------------------------------*
*& Report Z01_BSP_SELECT_ALIAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_select_alias.

DATA: BEGIN OF gs_spfli,
        carrid   TYPE spfli-carrid,
        nummer   TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
      END OF gs_spfli.
DATA gv_where TYPE string VALUE 'AA'.

DATA gs TYPE scarr.
SELECT spfli~carrid,
  CASE currcode
    WHEN 'EUR' THEN 'EURO'
    WHEN 'USD' THEN 'Dollar'
    ELSE 'egal'
  END AS waehrung,
carrname, connid, cityfrom, cityto,
  CASE fltype
   WHEN 'X' THEN 'Charter'
   WHEN ' ' THEN 'Linie'
  END AS flug_typ,
  fltype


  FROM scarr INNER JOIN spfli

   ON scarr~carrid = spfli~carrid

  "WHERE currcode = 'EUR'

INTO TABLE @DATA(gt_tabelle).

cl_salv_table=>factory(
 IMPORTING
    r_salv_table   =  DATA(go_alv)
  CHANGING
    t_table        = gt_tabelle
).
go_alv->display( ).
