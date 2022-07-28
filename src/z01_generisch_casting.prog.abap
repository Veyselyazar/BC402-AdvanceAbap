*&---------------------------------------------------------------------*
*& Report Z01_GENERISCH_CASTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_generisch_casting.


DATA gr_gen TYPE REF TO data. "Auf alle Datentypen - Derefernzierung nur auf <FS>
DATA gr_int1 TYPE REF TO i.   " Nur auf Integer
DATA gr_int2 TYPE REF TO i.   " Nur auf Integer
DATA gr_datum TYPE REF TO d.  " Nur auf Datum

CREATE DATA gr_int2. gr_int2->* = 200.
gr_gen = gr_int2. "Upcasting
CREATE DATA gr_gen TYPE i.


gr_int1 ?= gr_gen. " Downcastin Mehrere mögliche Datentypen in gr_gen
gr_int1->* = 455.
*TRY.
    gr_datum ?= gr_gen.
*  CATCH cx_root INTO DATA(go_error).
*    MESSAGE go_error TYPE 'I'.
*ENDTRY.

gr_int2 = gr_int1.
WRITE gr_int2->*.
