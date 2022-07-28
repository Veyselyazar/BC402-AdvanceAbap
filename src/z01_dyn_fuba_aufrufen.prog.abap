*&---------------------------------------------------------------------*
*& Report Z01_DYN_FUBA_AUFRUFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_dyn_fuba_aufrufen.

PARAMETERS pa_fuba TYPE program DEFAULT 'EASTER_GET_DATE'.
PARAMETERS pa_jahr TYPE n LENGTH 4 DEFAULT '2023'.
DATA gv_ostersonntag TYPE sy-datum.
DATA gs_parm TYPE abap_func_parmbind.
DATA gt_parm TYPE abap_func_parmbind_tab.
TRY.
    gs_parm-name = 'YEAR'.
    gs_parm-kind = 10.
    "GET REFERENCE OF pa_jahr INTO gs_parm-value.
    gs_parm-value = REF #( pa_jahr ).
    INSERT gs_parm INTO TABLE gt_parm.
    CLEAR gs_parm.
    gs_parm-name = 'EASTERDATE'.
    gs_parm-kind = 20.
    GET REFERENCE OF gv_ostersonntag INTO gs_parm-value.
    INSERT gs_parm INTO TABLE gt_parm.


    CALL FUNCTION pa_fuba
      PARAMETER-TABLE gt_parm.


    WRITE: 'Ostersonntag ist der ', gv_ostersonntag.
  CATCH cx_root INTO DATA(go_error).
    MESSAGE go_error TYPE 'I'.
ENDTRY.
