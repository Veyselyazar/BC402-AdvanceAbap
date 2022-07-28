*&---------------------------------------------------------------------*
*& Report BC402_IDT_STRING_PROC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ybc402_idt_string_proc.

CLASS lcl_string_processing DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_seltext TYPE string
        RAISING
          cx_bc402_wrong_format
          cx_bc402_no_data.

    METHODS:
      get_flights_as_string
        EXPORTING
          ev_flights_string TYPE string.

  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_s_flight,
        carrid   TYPE sflight-carrid,
        connid   TYPE sflight-connid,
        fldate   TYPE sflight-fldate,
        price    TYPE sflight-price,
        currency TYPE sflight-currency,
        seatsmax TYPE sflight-seatsmax,
        seatsocc TYPE sflight-seatsocc,
      END OF ty_s_flight.

    DATA:
      mv_seltext TYPE string.
    DATA:
      mv_carrid TYPE s_carr_id,
      mv_connid TYPE string.

    DATA:
      mt_flights  TYPE TABLE OF ty_s_flight.

    METHODS:
      set_seltext
        IMPORTING iv_seltext TYPE string.

    METHODS:
      is_seltext_consistent
        RETURNING
          VALUE(rv_consistent) TYPE abap_bool.

    METHODS:
      extract_values.

    METHODS:
      read_flights
        RAISING cx_bc402_no_data.

    CLASS-METHODS:
      convert_flight_to_string
        IMPORTING
          is_flight      TYPE ty_s_flight
        EXPORTING
          ev_flight_text TYPE string.

ENDCLASS.

CLASS lcl_string_processing IMPLEMENTATION.

  METHOD constructor.

    set_seltext( iv_seltext ).

    IF is_seltext_consistent( ) = abap_false.
      RAISE EXCEPTION TYPE cx_bc402_wrong_format.
    ENDIF.

    extract_values( ).

    read_flights( ).

  ENDMETHOD.

  METHOD get_flights_as_string.

    DATA ls_flight LIKE LINE OF mt_flights.

    CLEAR ev_flights_string.

    LOOP AT mt_flights INTO ls_flight.

      convert_flight_to_string(
        EXPORTING
          is_flight      = ls_flight
        IMPORTING
          ev_flight_text = DATA(lv_flight_text)
      ).

      IF ev_flights_string IS INITIAL.
        ev_flights_string = lv_flight_text.
      ELSE.
        CONCATENATE ev_flights_string
                    `#`
                    lv_flight_text
               INTO ev_flights_string.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD set_seltext.

* With Statements:
*-----------------*

    mv_seltext = iv_seltext.

    TRANSLATE mv_seltext TO UPPER CASE.
    CONDENSE  mv_seltext NO-GAPS.

  ENDMETHOD.

  METHOD is_seltext_consistent.

    DATA lv_seltext TYPE string.
    DATA lv_cartext TYPE string.
    DATA lv_context TYPE string.

    rv_consistent = abap_true.

    IF mv_seltext NP `CARRID=*;CONNID=*`.
      rv_consistent = abap_false.
    ELSE.

      lv_seltext = mv_seltext.

      REPLACE 'CARRID=' IN lv_seltext WITH ''.
      REPLACE 'CONNID=' IN lv_seltext WITH ''.

      SPLIT lv_seltext AT ';' INTO lv_cartext lv_context.

      IF lv_cartext CN sy-abcde OR lv_context CN '0123456789'.
        rv_consistent = abap_false.
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD extract_values.

    DATA lv_offset_begin TYPE i.
    DATA lv_offset_end   TYPE i.
    DATA lv_length       TYPE i.

* Extract CARRID
    DESCRIBE FIELD 'CARRID=' LENGTH lv_offset_begin IN CHARACTER MODE.
    FIND ';' IN mv_seltext MATCH OFFSET lv_offset_end.
    lv_length = lv_offset_end - lv_offset_begin.
    mv_carrid = mv_seltext+lv_offset_begin(lv_length).
* Extract CONNID
    FIND 'CONNID=' IN mv_seltext MATCH OFFSET lv_offset_begin
                                 MATCH LENGTH lv_length.
    lv_offset_begin = lv_offset_begin + lv_length.
    mv_connid = mv_seltext+lv_offset_begin.

  ENDMETHOD.

  METHOD read_flights.

    SELECT carrid connid fldate price currency seatsmax seatsocc
       FROM sflight INTO TABLE mt_flights
      WHERE carrid = mv_carrid
        AND connid = mv_connid.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDIF.

  ENDMETHOD.

  METHOD convert_flight_to_string.

* With Statements:
*-----------------*
    DATA lv_date_txt     TYPE c LENGTH 10.
    DATA lv_seatsmax_txt TYPE c LENGTH 10.
    DATA lv_seatsocc_txt TYPE c LENGTH 10.
    DATA lv_price_txt    TYPE c LENGTH 20.

    WRITE is_flight-fldate   TO lv_date_txt.
    WRITE is_flight-seatsocc TO lv_seatsocc_txt.
    WRITE is_flight-seatsmax TO lv_seatsmax_txt.
    WRITE is_flight-price    TO lv_price_txt CURRENCY is_flight-currency.

    CONCATENATE 'CARRID='
                is_flight-carrid
                ';'
                'CONNID='
                is_flight-connid
                ';'
                'FLDATE='
                lv_date_txt
                ';'
                'SEATSMAX='
                lv_seatsmax_txt
                ';'
                'SEATSOCC='
                lv_seatsocc_txt
                ';'
                'PRICE='
                lv_price_txt
                ';'
                'CURRENCY='
                is_flight-currency
           INTO ev_flight_text.

    CONDENSE ev_flight_text NO-GAPS.

  ENDMETHOD.

ENDCLASS.

DATA go_string_processing TYPE REF TO lcl_string_processing.
DATA gx_root TYPE REF TO cx_root.
DATA gv_flights_string TYPE string.

PARAMETERS pa_sel TYPE string  LOWER CASE DEFAULT `CARRID = LH; connid= 400`.

AT SELECTION-SCREEN.

  TRY.
      CREATE OBJECT go_string_processing
        EXPORTING
          iv_seltext = pa_sel.
    CATCH cx_root INTO gx_root.
      MESSAGE gx_root TYPE 'E'.
  ENDTRY.

START-OF-SELECTION.

  go_string_processing->get_flights_as_string(
    IMPORTING
      ev_flights_string = gv_flights_string
  ).

   data gt_datensaetze type TABLE OF string.

  split gv_flights_string at '#' into table gt_datensaetze.

  WHILE strlen( gv_flights_string ) > 200.
    WRITE / gv_flights_string(200).
    SHIFT gv_flights_string BY 200 PLACES.
  ENDWHILE.
  WRITE / gv_flights_string.
