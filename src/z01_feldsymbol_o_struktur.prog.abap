*&---------------------------------------------------------------------*
*& Report Z01_FELDSYMBOL_O_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_feldsymbol_o_struktur.


TYPES: ty_spfli TYPE STANDARD TABLE OF spfli.
FIELD-SYMBOLS <fs_tab_spfli> TYPE ty_spfli.
DATA gt_spfli TYPE TABLE OF spfli.
FIELD-SYMBOLS <fs_spfli> TYPE any.
FIELD-SYMBOLS <fs_field> TYPE any.

ASSIGN gt_spfli TO <fs_tab_spfli>.
SELECT * FROM spfli INTO TABLE <fs_tab_spfli>.







LOOP AT <fs_tab_spfli> ASSIGNING <fs_spfli>  .
  ASSIGN COMPONENT 2 OF STRUCTURE <fs_spfli> TO <fs_field>.
  WRITE: / <fs_field>.
  ASSIGN COMPONENT 3 OF STRUCTURE <fs_spfli> TO <fs_field>.
  WRITE:  <fs_field>.
  ASSIGN COMPONENT 5 OF STRUCTURE <fs_spfli> TO <fs_field>.
  WRITE:  <fs_field>.
  ASSIGN COMPONENT 8 OF STRUCTURE <fs_spfli> TO <fs_field>.
  WRITE:  <fs_field>.

*  WRITE: / <fs_spfli>-carrid,
*           <fs_spfli>-connid,
*           <fs_spfli>-cityfrom,
*           <fs_spfli>-cityto.

ENDLOOP.
