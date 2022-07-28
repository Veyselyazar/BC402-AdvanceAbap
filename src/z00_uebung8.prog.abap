*&---------------------------------------------------------------------*
*& Report Z00_UEBUNG8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_uebung8.

PARAMETERS pa_cust TYPE scustom-id.
PARAMETERS pa_meth TYPE program DEFAULT 'CANCEL_BOOKING'.
PARAMETERS pa_fact TYPE program DEFAULT 'FACTORY'.


DATA gr_gen TYPE REF TO data.
DATA go_kind TYPE REF TO zcl_bc402_00_itab_kind.
DATA gt_parm TYPE abap_parmbind_tab.
DATA gs_parm TYPE abap_parmbind.
DATA: gv_carrid TYPE sflight-carrid VALUE 'LH',
      gv_connid TYPE sflight-connid VALUE 400,
      gv_fldate TYPE sflight-fldate VALUE '20221119'.

 data(gr_obj) = cl_abap_classdescr=>describe_by_name( 'ZCL_BC402_00_ITAB_KIND').
assign gr_gen->* to FIELD-SYMBOL(<fs_ref>).
data class type c LENGTH 40 value 'CL_SALV_TABLE'.
 create data gr_gen type REF TO (class).
 "create object gr_gen->*.
"CREATE OBJECT <fs_ref> EXPORTING iv_customer = '1'.
TRY.
    gs_parm-name = 'IV_CUSTOMER'.
    gs_parm-value = REF #( pa_cust ).
    INSERT gs_parm INTO TABLE gt_parm.

    gs_parm-name = 'RO_INSTANZ'.
    gs_parm-value = REF #( go_kind ).
    INSERT gs_parm INTO TABLE gt_parm.


    CALL METHOD zcl_bc402_00_itab_kind=>(pa_fact)
      PARAMETER-TABLE gt_parm.
*    TRY.
*        go_kind->add_new_booking(
*  EXPORTING
*    iv_carrid               = 'LH'
*    iv_connid               = '400'
*    iv_fldate               = '20221120'
*).
*
*      CATCH cx_bc402_already_booked INTO DATA(go_booked).    "
*        MESSAGE go_booked TYPE 'I'.
*    ENDTRY.
    TRY.


*        go_kind->cancel_booking(
*          EXPORTING
*            iv_carrid        =   'LH'
*            iv_connid        =   '400'
*            iv_fldate        =   '20221119'
*        ).
        CLEAR gt_parm.
        gs_parm-name = 'IV_CARRID'.
        gs_parm-value = REF #( gv_carrid ).
        INSERT gs_parm INTO TABLE gt_parm.

        gs_parm-name = 'IV_CONNID'.
        gs_parm-value = REF #( gv_connid ).
        INSERT gs_parm INTO TABLE gt_parm.
        gs_parm-name = 'IV_FLDATE'.
        gs_parm-value = REF #( gv_fldate ).
        INSERT gs_parm INTO TABLE gt_parm.

        CALL METHOD go_kind->(pa_meth)
          PARAMETER-TABLE gt_parm.

      CATCH cx_bc402_no_data INTO DATA(go_canc).    "
        MESSAGE go_canc TYPE 'I'.
    ENDTRY.

  CATCH cx_root INTO DATA(go_error).
    MESSAGE go_error TYPE 'I'.

ENDTRY.
