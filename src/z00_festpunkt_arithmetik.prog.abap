*&---------------------------------------------------------------------*
*& Report Z00_FESTPUNKT_ARITHMETIK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_festpunkt_arithmetik.

*data gv_zahl type p ."DECIMALS 2.
*
*gv_zahl = 12 * '0.15'.
*write : / gv_zahl.
*
*gv_zahl = gv_zahl * 2.
*write : / gv_zahl.

PARAMETERS pa_zahl TYPE decfloat16.

DATA gv_result TYPE decfloat34.

"gv_result = pa_zahl / 11.
gv_result = round( val = ( pa_zahl / 11 ) dec = 3 ).
WRITE gv_result.

ULINE.
DATA gv_res TYPE p .
DATA gv_z1 TYPE decfloat16 VALUE 45.
DATA gv_z2 TYPE decfloat16 VALUE 7.

gv_res = gv_z1 / gv_z2.

DATA: f1 TYPE string VALUE 30,
      f2 TYPE c LENGTH 5 VALUE '12',
      f3 TYPE n LENGTH 40.

f3 = f1 * f2.

data gv_text type c LENGTH 2 value '1'.

BREAK-POINT.
