*&---------------------------------------------------------------------*
*& Report Z01_PARAMETER_OFFSET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_parameter_offset.

PARAMETERS pa_name TYPE string DEFAULT 'Werner Müller'.
PARAMETERS gv_off TYPE i DEFAULT 7.
PARAMETERS gv_len TYPE i DEFAULT 6.

WRITE: / pa_name.
IF ( gv_off + gv_len ) <= strlen( pa_name ).
  WRITE: / pa_name+gv_off(gv_len).
ELSE.
  WRITE ' Offset und Länge sind zu groß'.
ENDIF.
