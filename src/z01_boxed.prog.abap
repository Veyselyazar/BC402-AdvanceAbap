*&---------------------------------------------------------------------*
*& Report Z01_BOXED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_boxed.

TYPES: BEGIN OF ty_box,
         text TYPE c LENGTH 200000,
       END OF ty_box.

TYPES: BEGIN OF tgs_spfli,
         carrid       TYPE scarr-carrid,
         beschreibung TYPE ty_box boxed,
       END OF tgs_spfli.

DATA gs_spfli TYPE tgs_spfli.
DATA gt_spfli TYPE TABLE OF tgs_spfli.
