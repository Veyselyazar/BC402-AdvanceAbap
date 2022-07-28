*&---------------------------------------------------------------------*
*& Report Z01_LITERAL_BEZEICHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_LITERAL_BEZEICHNER.

data gv_prog type program value 'Y01_P1'.
"call transaction gv_prog.


submit (gv_prog) and return.
