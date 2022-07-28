*&---------------------------------------------------------------------*
*& Report Z01_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_feldsymbole.

FIELD-SYMBOLS <fs>.
DATA gv_int TYPE i VALUE 34.
DATA gv_string TYPE string VALUE 'Berlin'.
ASSIGN gv_int TO <fs>.

<fs> = 567.

WRITE: gv_int, <fs>.

ASSIGN gv_string TO <fs>.
write: / <fs>.

data gv_name type c LENGTH 20 value 'Werner Müller'.
assign gv_name to FIELD-SYMBOL(<fs_name>).
write <fs_name>.
