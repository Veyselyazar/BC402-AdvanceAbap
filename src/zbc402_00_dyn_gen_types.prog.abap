*&---------------------------------------------------------------------*
*& Report  BC402_DYT_DYN_CALL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc402_00_dyn_gen_types MESSAGE-ID bc402.



DATA: gt_cust   TYPE ty_customers,
      gt_conn   TYPE ty_connections,
      gt_flight TYPE sorted table of sflight with non-unique default key."ty_flights.

DATA gv_tabname TYPE c LENGTH 40.
FIELD-SYMBOLS <fs_table> TYPE ANY TABLE.

SELECTION-SCREEN COMMENT 1(80) TEXT-sel.
PARAMETERS:
  pa_xconn TYPE xfeld RADIOBUTTON GROUP tab DEFAULT 'X',
  pa_xcust TYPE xfeld RADIOBUTTON GROUP tab,
  pa_xflt  TYPE xfeld RADIOBUTTON GROUP tab.
PARAMETERS:
   pa_nol   TYPE i DEFAULT '100'.
 PARAMETERS pa_alv AS CHECKBOX.

START-OF-SELECTION.

* specific part
*----------------------------------------------------------------------*
  CASE 'X'.
    WHEN pa_xconn.
      gv_tabname = 'SPFLI'.
      ASSIGN gt_conn TO <fs_table>.
    WHEN pa_xcust.
      gv_tabname = 'SCUSTOM'.
      ASSIGN gt_cust TO <fs_table>.
    WHEN pa_xflt.
      gv_tabname = 'SFLIGHT'.
      ASSIGN gt_flight TO <fs_table>.
  ENDCASE.

* dynamic part
*----------------------------------------------------------------------*
  TRY.
      SELECT * FROM (gv_tabname) INTO TABLE <fs_table> UP TO pa_nol ROWS.
     " call method zcl...=>write_headers export iv-tabname = gv_tabname
      CALL METHOD zcl_bc402_00_gen_types=>write_any_table
        EXPORTING
          it_table = <fs_table>
          iv_alv = pa_alv.   " IT_TABLE

    CATCH cx_root INTO DATA(go_error).
      MESSAGE go_error TYPE 'I'.
  ENDTRY.
