*&---------------------------------------------------------------------*
*& Report Z01_TIEFE_OBJEKTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_tiefe_objekte.

DATA: BEGIN OF gs_struct,
        vorname  TYPE c LENGTH 15 VALUE 'Werner',
        nachname TYPE c LENGTH 20 VALUE 'Müller',
        alter    TYPE i VALUE 38,
        ort      TYPE string VALUE 'Hamburg',
      END OF gs_struct.

"gs_struct+35 = 'Berlin'.
WRITE: gs_struct-vorname.

DATA gt_monate like TABLE OF gs_struct INITIAL SIZE 10.


BREAK-POINT.
