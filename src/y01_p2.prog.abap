*&---------------------------------------------------------------------*
*& Report Y01_P2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y01_p2.

PARAMETERS p_flg TYPE spfli-carrid.
DATA gs_spfli TYPE spfli.

SELECT SINGLE carrid, connid, cityfrom, cityto
  FROM spfli
  INTO  CORRESPONDING FIELDS OF @gs_spfli
  WHERE carrid = @p_flg.

WRITE: gs_spfli-carrid,
       gs_spfli-connid,
       gs_spfli-cityfrom,
       gs_spfli-cityto.

EXPORT spfli = gs_spfli
   TO MEMORY ID 'DATEN'. "ABAP-Memory
