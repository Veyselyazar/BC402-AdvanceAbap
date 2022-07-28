*&---------------------------------------------------------------------*
*& Report Z01_REPORT_DYNAMISCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_report_dynamisch.

DATA gt_tab TYPE TABLE OF string.
DATA gv_prg TYPE program VALUE 'Z01_DYN_PROG'.

APPEND 'Report.' TO gt_tab.
APPEND 'Parameters pa_car type s_carr_id .' TO gt_tab.
APPEND 'DATA gs_scarr type scarr.' TO gt_tab.
APPEND 'select single * from scarr into gs_scarr where carrid = pa_car. ' TO gt_tab.
APPEND 'write gs_scarr(100).' TO gt_tab.

INSERT REPORT gv_prg FROM gt_tab.

SUBMIT (gv_prg) VIA SELECTION-SCREEN AND RETURN.

MESSAGE 'Zurück im Create Report-Progamm' TYPE 'I'.
