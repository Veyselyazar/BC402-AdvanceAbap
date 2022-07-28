*&---------------------------------------------------------------------*
*& Report Z012_BSP_TRACING_MIT_ST05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z012_bsp_tracing_mit_st05.

DATA gs_sflight TYPE sflight.

SELECT * FROM sflight INTO gs_sflight
  WHERE carrid = 'LH'.

ENDSELECT.
