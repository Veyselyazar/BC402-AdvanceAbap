*&---------------------------------------------------------------------*
*& Report Z01_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_templates.
DATA gv_text TYPE string.

gv_text = 'Text'.
"WRITE: / gv_text.

gv_text = |text-\{Template|.
translate gv_text to UPPER CASE.
gv_text = to_lower( val = gv_text ).
*WRITE: / gv_text.
data gv_result type string.

write |{ reverse( val = gv_text ) }| && ` Zusatztext`.

"write gv_result.
