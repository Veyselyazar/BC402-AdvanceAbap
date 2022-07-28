*&---------------------------------------------------------------------*
*& Report Z01_REFERENZ_UND_FELDSYMBOL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_referenz_und_feldsymbol.

DATA gr_gen TYPE REF TO data.
FIELD-SYMBOLS <fs_struct> TYPE spfli.
FIELD-SYMBOLS <fs_table> TYPE ANY TABLE.

CREATE DATA gr_gen TYPE spfli. "Struktur spfli
ASSIGN gr_gen->* TO <fs_struct>.

DATA gv_off TYPE i VALUE 6.
DATA gv_len TYPE i VALUE 4.

WRITE <fs_struct>+gv_off(gv_len).

<fs_struct>-cityfrom = 'Berlin'.

CREATE DATA gr_gen TYPE TABLE OF spfli.
ASSIGN gr_gen->* TO <fs_table>.
CLEAR gr_gen.

SELECT * FROM spfli INTO TABLE <fs_table>.

DATA gv_fl TYPE string VALUE 'Mandt carrid connid'.
DATA gv_tab TYPE string VALUE 'SPFLI'.
DATA gv_where TYPE string VALUE ` carrid = 'LH' `.
SELECT (gv_fl) FROM (gv_tab) INTO  <fs_struct>
  WHERE (gv_where)
*  group by (gv_group)
*  having (gv_having)
  .


ENDSELECT.
