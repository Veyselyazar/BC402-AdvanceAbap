*&---------------------------------------------------------------------*
*& Report Z00_DATENREFERENZ_BOUND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_datenreferenz_bound.

DATA gr_int TYPE REF TO i.

PERFORM up.

IF gr_int IS INITIAL.
  WRITE: / 'Intial'.
ENDIF.
IF gr_int IS BOUND.
  WRITE gr_int->*.
ELSE.
  WRITE 'Referenz ist nicht derefferenzierbar'.
ENDIF.



FORM up.
  DATA lv_int TYPE i.
  lv_int = 45.
  GET REFERENCE OF lv_int INTO gr_int.


ENDFORM.
