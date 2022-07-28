class ZCL_BC402_00_GEN_TYPES definition
  public
  create public .

public section.

  class-methods WRITE_ANY_STRUCT
    importing
      !IS_STRUCT type ANY .
  class-methods WRITE_ANY_TABLE
    importing
      value(IT_TABLE) type ANY TABLE
      !IV_ALV type WDY_BOOLEAN optional .
protected section.
*"* protected components of class CL_BC402_DYS_GENERIC_WRITE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_BC402_DYS_GENERIC_WRITE
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_BC402_00_GEN_TYPES IMPLEMENTATION.


METHOD write_any_struct.
  FIELD-SYMBOLS <fs_comp> TYPE simple.
  DATA lo_type TYPE REF TO cl_abap_typedescr.
  DATA lo_struct TYPE REF TO cl_abap_structdescr.

  lo_struct ?= cl_abap_structdescr=>describe_by_data( is_struct ).
  lo_type = lo_struct.  "upcasting
  CASE lo_type->kind.
    WHEN lo_type->kind_struct.
      lo_struct ?= lo_type.
*      loop at lo_struct->components into data(gs_comp).
*        write: / gs_comp-name,
*                 gs_comp-type_kind,
*                 gs_comp-length,
*                 gs_comp-decimals.
*      ENDLOOP.
      DATA(gt_feldliste) = lo_struct->get_ddic_field_list( ).
      LOOP AT gt_feldliste assigning field-symbol(<gs_feldliste>).
        WRITE: <gs_feldliste>-reptext(<gs_feldliste>-outputlen).
      ENDLOOP.
      ULINE.
    WHEN others. "lo_type->kind_elem. " Objekt eines Datenelements
      MESSAGE 'Es wurde keine Struktur übergeben' TYPE 'I'.
      RETURN.
  ENDCASE.

  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE is_struct TO <fs_comp>.
    CASE sy-subrc.
      WHEN 0.
        WRITE <fs_comp>.
      WHEN 4.
        UNASSIGN <fs_comp>.
        NEW-LINE.
        exit.
    ENDCASE.

  ENDDO.
ENDMETHOD.


METHOD write_any_table.
  FIELD-SYMBOLS <fs_line> TYPE any.
  DATA: lo_type   TYPE REF TO cl_abap_typedescr,
        lo_table  TYPE REF TO cl_abap_tabledescr,
        lo_struct TYPE REF TO cl_abap_structdescr.

  DATA feld TYPE string VALUE 'MANDT'.
  IF iv_alv IS INITIAL.
    lo_type = cl_abap_typedescr=>describe_by_data( it_table ).
    CASE lo_type->kind.
      WHEN 'T'.
        IF lo_type->kind_table <> 'O'.
          SORT it_table BY (feld) DESCENDING.
        ELSE.
          MESSAGE 'Eine sortierte Tabelle kann nicht sortiert werden' type 'I'.
        ENDIF.
        lo_table ?= lo_type.
        DATA(lo_line_type) = lo_table->get_table_line_type( ).
        CASE lo_line_type->kind.
          WHEN 'S'.
            lo_struct ?= lo_line_type.
            DATA(lt_fields) = lo_struct->get_ddic_field_list( ).
            LOOP AT lt_fields INTO DATA(ls_fields).
              WRITE: ls_fields-reptext(ls_fields-outputlen).
            ENDLOOP.
            ULINE.
        ENDCASE.
      WHEN OTHERS.
        MESSAGE 'Keine Tabelle' TYPE 'I'.
    ENDCASE.

    LOOP AT it_table ASSIGNING <fs_line>.
*  call method zcl_bc402_00_gen_types=>write_any_struct EXPORTING is_struct = <fs_line>.
*  call method write_any_struct EXPORTING is_struct = <fs_line>.
*  write_any_struct( EXPORTING is_struct = <fs_line> ).
*  write_any_struct(  is_struct = <fs_line> ).
      write_any_struct( <fs_line> ).

    ENDLOOP.

  ELSE.
    cl_salv_table=>factory(
      IMPORTING
        r_salv_table   = DATA(lo_alv)
      CHANGING
        t_table        = it_table
           ).
    lo_alv->display( ).

  ENDIF.

ENDMETHOD.
ENDCLASS.
