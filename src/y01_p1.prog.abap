*&---------------------------------------------------------------------*
*& Report Y01_P1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y01_p1.

DATA gs_satz TYPE spfli.
PARAMETERS pa_car TYPE scarr-carrid MEMORY ID car.
DATA: up TYPE c LENGTH 40 VALUE   'ZUP_FG'.
DATA gv_prog TYPE program VALUE 'SAPLZ00_SUBSCREENS'.

"PERFORM up_ex_2 IN PROGRAM ZEXTERNE_UPS if FOUND.
"PERFORM up_ex_1 IN PROGRAM ZEXTERNE_UPS if FOUND.
PERFORM (up) IN PROGRAM (gv_prog) IF FOUND.


SUBMIT y01_p2 "VIA SELECTION-SCREEN
  WITH p_flg = pa_car
  AND RETURN.

*call  TRANSACTION 'Z00SOLUTION' .
MESSAGE 'Zurück in P1' TYPE 'I'.

IMPORT  spfli = gs_satz
 FROM MEMORY ID 'DATEN'. "ABAP-Memory

FREE MEMORY ID 'DATEN'.

IF gs_satz IS NOT INITIAL.
  WRITE: 'Datensatz aus Programm 2 übernommen'.
ELSE.
  WRITE 'Keine Daten aus 2. Programm'.
ENDIF.
