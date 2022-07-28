*&---------------------------------------------------------------------*
*& Report Z01_GENERISCH_FELDSYMBOL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_generisch_feldsymbol.

FIELD-SYMBOLS <fs_c> TYPE p.
FIELD-SYMBOLS <fs_sequence> TYPE csequence.
DATA gv_string  TYPE string VALUE 'Beliebiger String-Inhalt'.
DATA gv_datum TYPE sy-datum.
DATA gv_c TYPE c LENGTH 200 VALUE 'Charcter ....'.

ASSIGN gv_string TO <fs_sequence>.

CONCATENATE ' Text' <fs_sequence> INTO <fs_sequence> SEPARATED BY space.

WRITE: / <fs_sequence>.
UNASSIGN <fs_sequence>.

WRITE: / <fs_c>.
DATA gv_p TYPE p DECIMALS 2.
ASSIGN gv_p TO <fs_c>.

"assign gv_datum to <fs_sequence>.

DATA gt_spfli TYPE SORTED TABLE OF spfli WITH NON-UNIQUE KEY cityfrom.
FIELD-SYMBOLS <fs_table> TYPE SORTED TABLE.
FIELD-SYMBOLS <fs_line> LIKE LINE OF gt_spfli.
ASSIGN gt_spfli TO <fs_table>.

LOOP AT <fs_table> ASSIGNING FIELD-SYMBOL(<fs_spfli>).

ENDLOOP.
