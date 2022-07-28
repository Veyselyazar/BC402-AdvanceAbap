*&---------------------------------------------------------------------*
*& Report Z01_RTTI_STRUCT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_rtti_struct.

PARAMETERS pa_tab TYPE dd02l-tabname.
DATA gr_gen TYPE REF TO data.
FIELD-SYMBOLS <fs_tab> TYPE any.

CREATE DATA gr_gen TYPE (pa_tab).
ASSIGN gr_gen->* TO <fs_tab>.

SELECT SINGLE * FROM (pa_tab) INTO <fs_tab>.

zcl_bc402_00_gen_types=>write_any_struct( <fs_tab> ).
