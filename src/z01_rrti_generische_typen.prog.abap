*&---------------------------------------------------------------------*
*& Report Z01_RRTI_GENERISCHE_TYPEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_rrti_generische_typen.

"PARAMETERS pa_ein TYPE string.
DATA pa_ein TYPE spfli.

DATA: go_type   TYPE REF TO cl_abap_typedescr,
      go_elem   TYPE REF TO cl_abap_elemdescr,
      go_struct TYPE REF TO cl_abap_structdescr,
      go_ref    TYPE REF TO cl_abap_refdescr,
      gr_gen    TYPE REF TO data,
      gr_spfli  TYPE REF TO spfli,
      go_target type ref to cl_abap_typedescr.

CREATE DATA gr_spfli.
gr_gen = gr_spfli.


go_type = cl_abap_typedescr=>describe_by_data( pa_ein ) .

CASE go_type->kind.
  WHEN 'E' OR go_type->kind_elem OR cl_abap_typedescr=>kind_elem.
    go_elem ?= go_type.
    IF go_elem->is_ddic_type( ) = 'X'.
      DATA(gs_dfies) = go_elem->get_ddic_field( ).
    ENDIF.
  WHEN 'S'.
    go_struct ?= go_type.
    DATA(gt_fields) = go_struct->get_ddic_field_list( ).
    data(gt_comp) = go_struct->get_components( ).
  WHEN 'R'.
    go_ref ?= go_type.
    go_target = go_ref->get_referenced_type( ).
    case go_target->kind.
      when 'S'.
        go_struct ?= go_target.
    endcase.

ENDCASE.
