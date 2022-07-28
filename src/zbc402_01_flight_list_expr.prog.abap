*&---------------------------------------------------------------------*
*& Report  BC402_INS_FLIGHT_LIST_STAT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  bc402_ins_flight_list_stat MESSAGE-ID bc402.

CLASS lcl_flight_data DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_s_flight,
        carrid     TYPE sflight-carrid,
        connid     TYPE sflight-connid,
        fldate     TYPE sflight-fldate,
        planetype  TYPE sflight-planetype,
        price      TYPE sflight-price,
        currency   TYPE sflight-currency,
        seatsmax   TYPE sflight-seatsmax,
        seatsocc   TYPE sflight-seatsocc,
        percentage TYPE p LENGTH 8 DECIMALS 2,
      END OF ty_s_flight.

    TYPES:
      ty_t_flights   TYPE STANDARD TABLE OF ty_s_flight,
      ty_t_con_range TYPE RANGE OF sflight-connid.


    CLASS-METHODS
      get_instance
        IMPORTING
          iv_carrid          TYPE sflight-carrid
          it_con_range       TYPE ty_t_con_range
        RETURNING
          VALUE(ro_instance) TYPE REF TO lcl_flight_data
        RAISING
          cx_bc402_no_data.

    CLASS-METHODS
      check_existence_of_data
        IMPORTING
          iv_carrid    TYPE sflight-carrid
          it_con_range TYPE ty_t_con_range
        RAISING
          cx_bc402_no_data.

    METHODS
      display.

  PRIVATE SECTION.

    DATA:
      mt_flights TYPE ty_t_flights.

    METHODS:
      constructor
        IMPORTING
          iv_carrid    TYPE sflight-carrid
          it_con_range TYPE ty_t_con_range,

      set_percentage.

ENDCLASS.

CLASS lcl_flight_data IMPLEMENTATION.

  METHOD get_instance.

* Check existence of data

    CALL METHOD check_existence_of_data
      EXPORTING
        iv_carrid    = iv_carrid
        it_con_range = it_con_range.

* create instance

    CREATE OBJECT ro_instance
      EXPORTING
        iv_carrid    = iv_carrid
        it_con_range = it_con_range.

  ENDMETHOD.

  METHOD check_existence_of_data.

    DATA lt_carrid TYPE TABLE OF sflight-carrid.
    DATA lv_lines  TYPE i.

* Check existence of data
    SELECT carrid FROM sflight INTO TABLE lt_carrid
                  WHERE carrid = iv_carrid
                    AND connid IN it_con_range.

    DESCRIBE TABLE lt_carrid LINES lv_lines.

    IF lv_lines = 0.
      RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDIF.

  ENDMETHOD.
  METHOD constructor.

    SELECT carrid connid fldate planetype price currency seatsmax seatsocc
      FROM sflight INTO TABLE mt_flights
             WHERE carrid = iv_carrid
               AND connid IN it_con_range.

* calculate percentage and sort

    CALL METHOD set_percentage.

    SORT mt_flights BY percentage DESCENDING.

  ENDMETHOD.


  METHOD set_percentage.

    DATA ls_flight LIKE LINE OF mt_flights.

    LOOP AT mt_flights INTO ls_flight.

      COMPUTE ls_flight-percentage = ls_flight-seatsocc / ls_flight-seatsmax * 100.

      MODIFY mt_flights FROM ls_flight TRANSPORTING percentage.

    ENDLOOP.

  ENDMETHOD.
  METHOD display.

    DATA ls_flight LIKE LINE OF mt_flights.
    DATA lv_icon TYPE icon_d.

    LOOP AT mt_flights INTO ls_flight.

      IF ls_flight-percentage > 90.
        lv_icon = icon_green_light.
      ELSEIF ls_flight-percentage > 50.
        lv_icon = icon_yellow_light.
      ELSE.
        lv_icon = icon_red_light.
      ENDIF.

      WRITE:
        / lv_icon AS ICON.

      WRITE:
          ls_flight-carrid,
          ls_flight-connid,
          ls_flight-fldate,
          ls_flight-planetype,
          ls_flight-seatsmax,
          ls_flight-seatsocc,
          ls_flight-percentage,
          ls_flight-price  CURRENCY ls_flight-currency,
          ls_flight-currency.

    ENDLOOP.

  ENDMETHOD.


ENDCLASS.

DATA go_flight_data TYPE REF TO lcl_flight_data.
DATA gx_no_data     TYPE REF TO cx_bc402_no_data.

* Selection Screen
DATA gs_sflight_dummy TYPE sflight.
PARAMETERS pa_car TYPE sflight-carrid.
SELECT-OPTIONS so_con FOR gs_sflight_dummy-connid.

START-OF-SELECTION.

  TRY.
      go_flight_data = lcl_flight_data=>get_instance(
           iv_carrid    = pa_car
           it_con_range = so_con[] ).

      CALL METHOD go_flight_data->display.

    CATCH cx_bc402_no_data INTO gx_no_data.

      MESSAGE gx_no_data TYPE 'E'.

  ENDTRY.
