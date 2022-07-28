*&---------------------------------------------------------------------*
*& Report  BC402_DYT_DYN_CALL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zbc402_00_dyn_call MESSAGE-ID bc402.



DATA: gt_cust TYPE ty_customers,
      gt_conn TYPE ty_connections.

DATA: gs_parm TYPE abap_parmbind,
      gt_parm TYPE abap_parmbind_tab.

DATA gv_methodname TYPE c LENGTH 40.
DATA gv_classname TYPE c LENGTH 40 VALUE 'ZCL_BC402_UTILITES'.

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
      gv_methodname = 'WRITE_CONNECTIONS'.
      gs_parm-name = 'IT_CONN'.
      gs_parm-value = REF #( gt_conn ).
      INSERT gs_parm INTO TABLE gt_parm.

      SELECT * FROM spfli INTO TABLE gt_conn
               UP TO pa_nol ROWS.

    WHEN pa_xcust.
      gv_methodname = 'WRITE_CUSTOMERS'.
      gs_parm-name = 'IT_CUST'.
      gs_parm-value = REF #( gt_cust ).
      INSERT gs_parm INTO TABLE gt_parm.

      SELECT * FROM scustom INTO TABLE gt_cust
               UP TO pa_nol ROWS.
  ENDCASE.

* dynamic part
*----------------------------------------------------------------------*
  CALL METHOD (gv_classname)=>(gv_methodname)
    PARAMETER-TABLE gt_parm.
