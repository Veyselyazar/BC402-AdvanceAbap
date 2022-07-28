*&---------------------------------------------------------------------*
*& Report Z01_BSP_TYPKONVERTIERUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_typkonvertierung.

CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS do_something
      IMPORTING VALUE(cv_data) TYPE any
      RETURNING VALUE(rv_data) TYPE string .
ENDCLASS.
CLASS lcl_demo IMPLEMENTATION.
  METHOD do_something.
    "TRANSLATE cv_data TO LOWER CASE.

    rv_data = cv_data * 2.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
data gs_scarr like scarr.
tables sdyn_conn.
data gt_spfli type TABLE OF spfli with HEADER LINE.
types tv_xy type string.

types tv_datum type tv_xy.


  PARAMETERS pa_data TYPE c LENGTH 12.
  DATA go_alv TYPE REF TO cl_salv_table.
  TRY.
      pa_data = 100 / 0.
      WRITE lcl_demo=>do_something(  CONV string( pa_data ) ).
    CATCH cx_root into data(go_error).
      MESSAGE go_error->get_text( ) type 'I'.
  ENDTRY.
