class ZCL_BC402_00_ITAB_KIND definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_s_booking,
        carrid   TYPE bc402_scus_book-carrid,
        connid   TYPE bc402_scus_book-connid,
        fldate   TYPE bc402_scus_book-fldate,
        bookid   TYPE bc402_scus_book-bookid,
        cityfrom TYPE bc402_scus_book-cityfrom,
        cityto   TYPE bc402_scus_book-cityto,
      END OF ty_s_booking .
  types:
    BEGIN OF ty_s_sums,
        forcuram  TYPE bc402_scus_book-forcuram,
        forcurkey TYPE bc402_scus_book-forcurkey,
      END OF ty_s_sums .
  types:
    BEGIN OF ty_s_travelags,
        agencynum TYPE bc402_scus_book-agencynum,
        name      TYPE bc402_scus_book-name,
        city      TYPE bc402_scus_book-city,
      END OF ty_s_travelags .
  types:
    ty_t_sums      TYPE hashed TABLE OF ty_s_sums
                             WITH UNIQUE key forcurkey .
  types:
    ty_t_travelags TYPE STANDARD TABLE OF ty_s_travelags
                                 WITH NON-UNIQUE KEY agencynum .
  types:
    ty_t_bookings  TYPE STANDARD TABLE OF ty_s_booking
                                    WITH NON-UNIQUE DEFAULT KEY .

  methods GET_BOOKINGS_ALL
    exporting
      !ET_BOOKINGS type TY_T_BOOKINGS .
  methods GET_BOOKINGS_BY_CARRIER
    importing
      !IV_CARRID type TY_S_BOOKING-CARRID default 'LH'
    exporting
      !ET_BOOKINGS type TY_T_BOOKINGS .
  methods GET_BOOKING_BY_KEY
    importing
      !IV_CARRID type TY_S_BOOKING-CARRID
      !IV_CONNID type TY_S_BOOKING-CONNID
      !IV_FLDATE type TY_S_BOOKING-FLDATE
    returning
      value(RS_BOOKING) type TY_S_BOOKING
    raising
      CX_BC402_NO_DATA .
  methods ADD_NEW_BOOKING
    importing
      !IV_CARRID type TY_S_BOOKING-CARRID
      !IV_CONNID type TY_S_BOOKING-CONNID
      !IV_FLDATE type TY_S_BOOKING-FLDATE
    raising
      CX_BC402_ALREADY_BOOKED .
  methods GET_BOOKING_SUMS
    exporting
      !ET_SUMS type TY_T_SUMS .
  methods GET_TRAVEL_AGENCIES
    exporting
      !ET_TRAVELAGS type TY_T_TRAVELAGS .
  methods GET_BOOKINGS_COUNT
    returning
      value(RV_BOOKINGS_COUNT) type I .
  methods GET_OLDEST_BOOKING
    returning
      value(RS_BOOKING) type TY_S_BOOKING
    raising
      CX_BC402_NO_DATA .
  methods CANCEL_BOOKING
    importing
      !IV_CARRID type TY_S_BOOKING-CARRID
      !IV_CONNID type TY_S_BOOKING-CONNID
      !IV_FLDATE type TY_S_BOOKING-FLDATE
    raising
      CX_BC402_NO_DATA .
  methods EGAL
    changing
      !CT_TAB type FLIGHTTAB .
  class-methods FACTORY
    importing
      !IV_CUSTOMER type S_CUSTOMER default 1
    returning
      value(RO_INSTANZ) type ref to ZCL_BC402_00_ITAB_KIND .
  methods CONSTRUCTOR
    importing
      !IV_CUSTOMER type S_CUSTOMER default '00000001'
    raising
      CX_BC402_NO_DATA .
private section.

  types TY_S_DATA type BC402_SCUS_BOOK .

  data MV_CUSTOMER type S_CUSTOMER .
  data:
    mt_data     TYPE SORTED TABLE OF ty_s_data
        WITH UNIQUE KEY carrid connid fldate .
  class-data GO_CUSTOMER type ref to ZCL_BC402_00_ITAB_KIND .

  methods READ_DATA
    importing
      !IV_CUSTOMER type S_CUSTOMER
    raising
      CX_BC402_NO_DATA .
ENDCLASS.



CLASS ZCL_BC402_00_ITAB_KIND IMPLEMENTATION.


  METHOD add_new_booking.


*    DATA ls_data LIKE LINE OF mt_data.
*
*    ls_data-carrid   = iv_carrid.
*    ls_data-connid   = iv_connid.
*    ls_data-fldate   = iv_fldate.
*    ls_data-customid = mv_customer.
*     ... Set the remaining fields (e.g. through a SELECT from Table SPFLI) not relevant here

* Make sure customer is not yet booked on this flight
*    READ TABLE mt_data TRANSPORTING NO FIELDS
*              WITH KEY carrid   = ls_data-carrid
*                       connid   = ls_data-connid
*                       fldate   = ls_data-fldate.

*    INSERT ls_data INTO TABLE mt_data.
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_bc402_already_booked.
*    ENDIF.
    TRY.
        mt_data = VALUE #(
                          BASE  mt_data
                          ( carrid = iv_carrid
                            connid = iv_connid
                            fldate = iv_fldate
                            customid = mv_customer
                          )
                        ).

      CATCH cx_bc402_already_booked.
        RAISE EXCEPTION TYPE cx_bc402_already_booked.
    ENDTRY.
  ENDMETHOD.


  METHOD cancel_booking.

    DATA ls_data LIKE LINE OF mt_data.
    ls_data-carrid = iv_carrid.
    ls_data-connid = iv_connid.
    ls_data-fldate = iv_fldate.
    ls_data-cancelled = 'X'.

    MODIFY TABLE mt_data FROM ls_data TRANSPORTING cancelled.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDIF.

  ENDMETHOD.


  METHOD CONSTRUCTOR.

    mv_customer = iv_customer.
    read_data( iv_customer ).

  ENDMETHOD.


  method EGAL.
    data ls_tab like line of ct_tab.
    read  TABLE ct_tab into ls_tab index 1.
  endmethod.


  method FACTORY.

    create object go_customer
      EXPORTING iv_customer = iv_customer.

  ro_instanz = go_customer.
  endmethod.


  METHOD GET_BOOKINGS_ALL.

*    DATA ls_data    LIKE LINE OF mt_data.
*    DATA ls_booking LIKE LINE OF et_bookings.
*
*    LOOP AT mt_data INTO ls_data.
*      MOVE-CORRESPONDING ls_data TO ls_booking.
*      insert ls_booking inTO table et_bookings.
*    ENDLOOP.

MOVE-CORRESPONDING mt_data to et_bookings.

  ENDMETHOD.


  METHOD get_bookings_by_carrier.


    " DATA ls_data    LIKE LINE OF mt_data.
    "DATA ls_booking LIKE LINE OF et_bookings.

*    LOOP AT mt_data INTO ls_data WHERE carrid = iv_carrid.
*      MOVE-CORRESPONDING ls_data TO ls_booking.
*      insert ls_booking inTO table et_bookings.
*    ENDLOOP.

    et_bookings = VALUE #(
                         FOR ls_data IN mt_data
                         WHERE ( carrid = iv_carrid )
                         ( carrid = ls_data-carrid
                           connid = ls_data-connid
                           fldate = ls_data-fldate
                           cityfrom = ls_data-cityfrom
                           bookid   = ls_data-bookid
                           cityto   = ls_data-cityto
                         )

                         ).

  ENDMETHOD.


  METHOD GET_BOOKINGS_COUNT.

    "DESCRIBE TABLE mt_data LINES rv_bookings_count.
    rv_bookings_count = lines( mt_data ).
  ENDMETHOD.


  METHOD get_booking_by_key.

*    DATA ls_data LIKE LINE OF mt_data.
*
*    READ TABLE mt_data INTO ls_data
*                       WITH table KEY carrid = iv_carrid
*                                connid = iv_connid
*                                fldate = iv_fldate.

*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_bc402_no_data.
*    ELSE.
*      MOVE-CORRESPONDING ls_data TO rs_booking.
*    ENDIF.
    TRY.
        MOVE-CORRESPONDING mt_data[ carrid = iv_carrid
                                    connid = iv_connid
                                    fldate = iv_fldate ]
                           TO rs_booking.
      CATCH cx_root.
        RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDTRY.

  ENDMETHOD.


  METHOD get_booking_sums.
    "DATA ls_data LIKE LINE OF mt_data.
*    DATA ls_data LIKE LINE OF mt_data.
*    DATA ls_booking type ty_s_booking.
*
*    LOOP AT mt_data into ls_data where carrid = iv_carrid.
*      MOVE-CORRESPONDING ls_data->* TO ls_booking.
*      COLLECT ls_booking INTO et_bookings.
*    ENDLOOP.


  ENDMETHOD.


  METHOD get_oldest_booking.

    DATA lt_data TYPE TABLE OF ty_s_data.
    " DATA ls_data TYPE ty_s_data.

    lt_data = mt_data.
    SORT lt_data BY fldate deptime.

*    READ TABLE lt_data INTO ls_data INDEX 1.
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_bc402_no_data.
*
*    ENDIF.
    "IF line_exists( lt_data[ 1 ].
    IF lines( lt_data ) > 0.

      MOVE-CORRESPONDING lt_data[ 1 ] TO rs_booking.
    ELSE.
      RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDIF.

  ENDMETHOD.


  METHOD GET_TRAVEL_AGENCIES.
  MOVE-CORRESPONDING mt_data to ET_TRAVELAGS.
* To be implemented in a later exercise
  sort ET_TRAVELAGS by name.
  DELETE ADJACENT DUPLICATES FROM ET_TRAVELAGS.
  ENDMETHOD.


  METHOD READ_DATA.

    DATA ls_data LIKE LINE OF mt_data.

    SELECT * FROM bc402_scus_book
             INTO ls_data
             WHERE customid = iv_customer
               AND cancelled <> 'X'.
      INSERT ls_data INTO TABLE mt_data.
     " append ls_data TO  mt_data.
    ENDSELECT.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_bc402_no_data.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
