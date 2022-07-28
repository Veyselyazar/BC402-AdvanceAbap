*&---------------------------------------------------------------------*
*& Report Z01_BSP_DATENTYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_datentypen.
*DATA gv_datenobjekt TYPE n LENGTH 300.
*DATA gv_daten TYPE n LENGTH 40 VALUE '345678'. "Max 255
*
*DO 10 TIMES.
*  gv_datenobjekt = gv_datenobjekt && gv_daten.
*ENDDO.
*BREAK-POINT.

*PARAMETERS pa_datum TYPE sy-datum DEFAULT  738340 . "'20220715'.
*DATA gv_tage_seit_01_01_01 TYPE i. " Seit dem 01.01.01
*gv_tage_seit_01_01_01 = pa_datum.
*gv_tage_seit_01_01_01  = gv_tage_seit_01_01_01 + 7.
*pa_datum = gv_tage_seit_01_01_01.
*WRITE pa_datum DD/MM/YY.

PARAMETERS pa_zeit TYPE sy-uzeit DEFAULT 34312. "Sekunden seit 0:00 Uhr

DATA gv_c_feld(10) TYPE c.
DATA gv_feld TYPE c LENGTH 10.

pa_zeit = pa_zeit + 3600.

WRITE: pa_zeit(2) NO-GAP,
       ':' NO-GAP,
       pa_zeit+2(2) NO-GAP ,
       ':' NO-GAP,
       pa_zeit+4.

WRITE / pa_zeit.
