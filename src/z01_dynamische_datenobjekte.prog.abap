*&---------------------------------------------------------------------*
*& Report Z01_DYNAMISCHE_DATENOBJEKTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_dynamische_datenobjekte.

DATA gv_carrid TYPE c LENGTH 3 VALUE 'LH'.
DATA gv_name TYPE c LENGTH 40 VALUE 'GV_CARRID'.
DATA gv_nachname TYPE string VALUE 'Müller'.
FIELD-SYMBOLS <fs> TYPE any.

ASSIGN gv_name TO <fs>. WRITE: / <fs>.
ASSIGN (gv_name) TO <fs>. WRITE: / <fs>.
ULINE.
gv_name = 'GV_NACHNAM'.
ASSIGN (gv_name) TO <fs>. WRITE: / <fs>.
**********************************************************************
DATA ls_spfli TYPE spfli.
SELECT SINGLE * FROM spfli INTO ls_spfli WHERE carrid = 'SQ'.
DO.
  ASSIGN COMPONENT sy-index OF STRUCTURE ls_spfli TO <fs>.
  IF sy-subrc = 4.
    UNASSIGN <fs>.
    EXIT.
  ENDIF.
  WRITE <fs>.
ENDDO.
gv_name = 'LS_SPFLI-CITYTO'.
ASSIGN (gv_name) TO <fs>.
WRITE: / <fs>.
ULINE.
ASSIGN COMPONENT 'CITYFROM' OF STRUCTURE ls_spfli TO <fs>.
<fs> = 'Düren'.
WRITE: ls_spfli-cityfrom.



gv_name = 'ZCL_BC402=>FIRMENNAME'.
ASSIGN (gv_name) TO <fs>.
WRITE: / <fs>.

<fs> = 'Neuer Firmenname'.
WRITE: / zcl_bc402=>firmenname.
ULINE.
DATA go_bc402 TYPE REF TO zcl_bc402.
CREATE OBJECT go_bc402.
go_bc402->name_mitarbeiter = 'Müller'.
WRITE go_bc402->name_mitarbeiter..
ULINE.
gv_name = 'NAME_MITARBEITER' .
ASSIGN go_bc402->(gv_name) TO <fs>.

<fs> = 'Michaela Harding'.
WRITE go_bc402->name_mitarbeiter.
WRITE / <fs>.
