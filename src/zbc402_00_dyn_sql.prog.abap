*&---------------------------------------------------------------------*
*& Report  BC402_DYT_DYN_CALL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc402_00_dyn_sql MESSAGE-ID bc402.



DATA: gt_cust TYPE ty_customers,
      gt_conn TYPE ty_connections.

DATA: gs_parm TYPE abap_parmbind,
      gt_parm TYPE abap_parmbind_tab.

DATA gv_methodname TYPE c LENGTH 40.
DATA gv_classname TYPE c LENGTH 40 VALUE 'CL_BC402_UTILITIES'.
DATA gv_tabname TYPE c LENGTH 40.
FIELD-SYMBOLS <fs_table> TYPE ANY TABLE.

SELECTION-SCREEN COMMENT 1(80) TEXT-sel.
PARAMETERS:
  pa_xconn TYPE xfeld RADIOBUTTON GROUP tab DEFAULT 'X',
  pa_xcust TYPE xfeld RADIOBUTTON GROUP tab.
PARAMETERS:
   pa_nol   TYPE i DEFAULT '100'.

START-OF-SELECTION.

* specific part
*----------------------------------------------------------------------*
  CASE 'X'.
    WHEN pa_xconn.
      gv_tabname = 'SPFLI'.
      gv_methodname = 'WRITE_CONNECTIONS'.
      ASSIGN gt_conn TO <fs_table>.
      gs_parm-name = 'IT_CONN'.
      gs_parm-value = REF #( <fs_table> ).
      INSERT gs_parm INTO TABLE gt_parm.

    WHEN pa_xcust.
      gv_tabname = 'SCUSTOM'.
      gv_methodname = 'WRITE_CUSTOMERS'.
      ASSIGN gt_cust TO <fs_table>.

      gs_parm-name = 'IT_CUST'.
      gs_parm-value = REF #( <fs_table> ).
      INSERT gs_parm INTO TABLE gt_parm.

  ENDCASE.

* dynamic part
*----------------------------------------------------------------------*
  TRY.
      SELECT * FROM (gv_tabname) INTO TABLE <fs_table> UP TO pa_nol ROWS.
      CALL METHOD cl_bc402_utilities=>(gv_methodname)
        PARAMETER-TABLE gt_parm.
    CATCH cx_root INTO DATA(go_error).
      MESSAGE go_error TYPE 'I'.
  ENDTRY.
