*&---------------------------------------------------------------------*
*& Report Z01_DATENTYPEN_LITERALE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_datentypen_literale.
DATA gv_string TYPE string VALUE `Otto'  `.
DATA gv_zahl TYPE c LENGTH 10 VALUE -125.

data gt_spfli type table of spfli.
"data gs_spfli like line of gt_spfli.

loop at gt_spfli into data(gs_spfli).

endloop.



DATA lv_zahl TYPE decfloat16 VALUE 1234.
gv_zahl = gv_zahl + 5.
gv_string = 'abc'.
"DATA go_error TYPE REF TO cx_root.

data(gv_summe) = 45 ** 5.

TRY.
    WRITE gv_zahl.
    WRITE: / gv_string.
    ULINE.
   " gv_zahl = 45 / 0.
    PERFORM up.
    PERFORM up.

    PERFORM up2.

*  CATCH cx_sy_arithmetic_overflow INTO DATA(go_error).
*    MESSAGE go_error TYPE 'I'.

  CATCH cx_root  INTO data(go_error).
    MESSAGE go_error TYPE 'I'.
ENDTRY.



**********************************************************************
FORM up.
  TABLES scarr.
  scarr-carrid = 'LH'.
  STATICS lv_zahl TYPE i . "Im Unterprogramm, im Funktionsbaustein, in der statischen Methode
  lv_zahl = lv_zahl + 5.
  WRITE: / lv_zahl.
ENDFORM.
FORM up2.
  WRITE: / scarr.

ENDFORM.

MODULE abc OUTPUT.

ENDMODULE.
