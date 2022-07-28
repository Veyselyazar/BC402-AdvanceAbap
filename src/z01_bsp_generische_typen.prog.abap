*&---------------------------------------------------------------------*
*& Report Z01_BSP_GENERISCHE_TYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_generische_typen.

data gt_string type table of string.

"PARAMETERS pa_ein TYPE i.
DATA gs_scarr type spfli.
"select single * from scarr into  gs_scarr.
DATA ref_data TYPE REF TO i.
"get REFERENCE OF pa_ein INTO ref_data.
data gv_c type  p LENGTH 14.

BREAK-POINT.
"PERFORM up USING gv_c.


FORM up USING VALUE(p_lokal) TYPE  c .
* p_lokal = p_lokal + 5.
* write p_lokal.
  BREAK-POINT.
ENDFORM.
