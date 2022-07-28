*&---------------------------------------------------------------------*
*& Report Z01_BSP_MOVE_EXACT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_move_exact.

PARAMETERS pa_name TYPE string.
DATA gv_name TYPE c LENGTH 10.

TRY.
    "MOVE pa_name TO gv_name.
    "MOVE EXACT pa_name TO gv_name.

    gv_name = EXACT #( pa_name ).

    WRITE gv_name.
  CATCH cx_sy_conversion_data_loss INTO DATA(go_error).
    MESSAGE go_error->get_text( ) TYPE 'I'.

ENDTRY.
