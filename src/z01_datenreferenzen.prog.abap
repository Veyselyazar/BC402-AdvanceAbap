*&---------------------------------------------------------------------*
*& Report Z01_DATENREFERENZEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_datenreferenzen.

DATA gv_int1 TYPE i.
DATA gr_int TYPE REF TO i.

gv_int1 = 456.

GET REFERENCE OF gv_int1 INTO gr_int.

gr_int = ref #( gv_int1 ).

gr_int->* = 444.
WRITE: / gr_int->*, gv_int1.

CREATE DATA gr_int.
gr_int->* = 233.

GET REFERENCE OF gv_int1 INTO gr_int.

DATA gs_scarr TYPE scarr.
DATA gr_scarr TYPE REF TO  scarr.
SELECT SINGLE * FROM scarr INTO gs_scarr.

GET REFERENCE OF gs_scarr INTO gr_scarr.

WRITE: / gr_scarr->carrname.
gr_scarr->carrname = 'Lufthansa'.
WRITE: / gs_scarr-carrname, gr_scarr->carrname.




BREAK-POINT.
