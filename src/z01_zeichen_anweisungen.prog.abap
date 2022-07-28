*&---------------------------------------------------------------------*
*& Report Z01_ZEICHEN_ANWEISUNGEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_zeichen_anweisungen.

DATA: f1 TYPE c LENGTH 10 VALUE '       Herbert',
      f2 TYPE string VALUE '      Müller',
      f3 TYPE c LENGTH 50,
      f4 TYPE i VALUE 12.

"CONCATENATE f1 f2 'Zusatztext' f4 into f3 SEPARATED BY space.
f3 = f1 &&  ` ` && f2 && `         Zusatztext ` && f4 .

WRITE f3.
DATA gv_erg TYPE i.
FIND FIRST OCCURRENCE OF 'l' IN f3 MATCH OFFSET gv_erg.
WRITE: / 'Offset vor gefundener Position', gv_erg.

REPLACE ALL OCCURRENCES OF 'l' IN f3 WITH 'k'.
WRITE: / f3.

"shift f3 by 8 PLACES . "CIRCULAR.
SHIFT f3 LEFT DELETING LEADING '#'.
WRITE: / f3.

DATA: vorname  TYPE string,
      nachname TYPE string,
      text     TYPE string,
      zahl     TYPE string.

SPLIT f3 AT space INTO vorname nachname text zahl.
ULINE.
WRITE: / vorname, / nachname, / text, / zahl.

DATA gt_string TYPE TABLE OF string.
SPLIT f3 AT space INTO TABLE gt_string.
ULINE.
LOOP AT gt_string INTO DATA(gv_string).
  WRITE: /20 gv_string.
ENDLOOP.

CONDENSE f3 ."NO-GAPS.
WRITE: / f3.
ULINE.

DATA gv_datum TYPE sy-datum.
DATA gv_text_datum TYPE c LENGTH 10.
gv_datum = sy-datum.

WRITE  gv_datum to gv_text_datum.

BREAK-POINT.
