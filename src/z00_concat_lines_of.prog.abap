*&---------------------------------------------------------------------*
*& Report Z00_CONCAT_LINES_OF
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_concat_lines_of.

DATA gt_tab TYPE TABLE OF string.
DATA gv_string TYPE string.


APPEND 'Werner' TO gt_tab.
APPEND 'Müller' TO gt_tab.

gv_string = concat_lines_of( table = gt_tab ).

WRITE gv_string.
