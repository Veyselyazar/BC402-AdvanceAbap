*&---------------------------------------------------------------------*
*& Report Z01_DATENREFERENZ_GENERISCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_datenreferenz_generisch.

DATA gr_gen TYPE REF TO data.  "Generisch, kann nicht dereferenziert werden, aber
" einem Feldsymbol zugeordnet werden
FIELD-SYMBOLS <fs_table> TYPE ANY TABLE.
PARAMETERS pa_tab TYPE dd02l-tabname DEFAULT 'SPFLI'.
PARAMETERS pa_sort TYPE c LENGTH 40 DEFAULT 'CITYFROM'.
DATA go_struct TYPE REF TO cl_abap_structdescr.
DATA gs_components TYPE abap_compdescr.
TRY.

    CREATE DATA gr_gen TYPE STANDARD TABLE OF (pa_tab) WITH NON-UNIQUE DEFAULT KEY.

    ASSIGN gr_gen->* TO <fs_table>.

    SELECT * FROM  (pa_tab) INTO TABLE <fs_table>.
    "WHERE carrid = 'AA'.
    go_struct ?= cl_abap_typedescr=>describe_by_name( pa_tab  ).
    READ TABLE go_struct->components INTO gs_components
       WITH KEY name = pa_sort.
    IF sy-subrc = 0.
      SORT <fs_table> BY (pa_sort)  ASCENDING.

    ELSE.
      MESSAGE 'Deises sortierfeld existiert nicht in der Struktur' TYPE 'I'.
      RETURN.
    ENDIF.

    cl_salv_table=>factory(
      IMPORTING
       r_salv_table   =   DATA(go_alv)  " Basisklasse einfache ALV Tabellen
      CHANGING
        t_table        = <fs_table>
    ).
    go_alv->display( ).
  CATCH cx_root INTO DATA(go_error).
    MESSAGE go_error TYPE 'I'.
ENDTRY.
