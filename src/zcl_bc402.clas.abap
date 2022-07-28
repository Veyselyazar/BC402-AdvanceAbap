class ZCL_BC402 definition
  public
  final
  create public .

public section.

  class-data FIRMENNAME type STRING value 'Lug & Trug GmbH' ##NO_TEXT.
  data NAME_MITARBEITER type STRING .

  class-methods EGAL
    importing
      !IV_EGAL type DECFLOAT
      value(IT_EGAL) type FLIGHTTAB
      !IV_REFERENZ type ref to DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BC402 IMPLEMENTATION.


  method EGAL.

    loop at it_egal into data(ls_egal).


    endloop.

    append ls_egal to it_egal. " Verzögerte Kopie der tabelle aus Hauptprogramm
  endmethod.
ENDCLASS.
