*&---------------------------------------------------------------------*
*& Report Z01_SUBROUTINE_DYNAMISCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_subroutine_dynamisch.

DATA gt_tab TYPE TABLE OF string.
DATA gv_prg TYPE program.
DATA gv_zahl TYPE i VALUE 45.
gv_prg = 'ZXY1234'.

APPEND 'Report zxy. ' TO gt_tab.
APPEND 'form addiere .' TO gt_tab.
APPEND 'Statics lv_summe type i.' TO gt_tab.
APPEND 'write: / ''Generiertes unterprogramm''. ' TO gt_tab.
APPEND 'Endform.' TO gt_tab.


GENERATE SUBROUTINE POOL gt_tab
   NAME gv_prg.

PERFORM addiere  IN PROGRAM (gv_prg) IF FOUND.

WRITE: / 'Progende'.
