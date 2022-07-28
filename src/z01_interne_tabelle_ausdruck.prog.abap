*&---------------------------------------------------------------------*
*& Report Z01_INTERNE_TABELLE_AUSDRUCK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_interne_tabelle_ausdruck.

DATA gt_spfli TYPE STANDARD TABLE OF spfli WITH NON-UNIQUE KEY cityfrom cityto
              WITH NON-UNIQUE SORTED KEY conn COMPONENTS carrid connid.


DATA gs_spfli TYPE spfli.
SELECT * FROM spfli INTO TABLE gt_spfli.
FIELD-SYMBOLS <fs_line> TYPE spfli.

*READ TABLE gt_spfli INTO gs_spfli INDEX 2.
*gs_spfli = gt_spfli[ 1 ].

ASSIGN gt_spfli[ KEY conn COMPONENTS carrid = 'AA' connid = 64 ] TO <fs_line>.

WRITE: / <fs_line>-carrid,
         <fs_line>-connid,
         <fs_line>-cityfrom,
         <fs_line>-cityto.

DATA(gv_index) = line_index( gt_spfli[ carrid = 'LH' connid = 400 ] ).

IF line_exists( gt_spfli[ carrid = 'LH' connid = 400 ] ).
  MESSAGE 'Datensatz existiert' TYPE 'I'.

ELSE.


ENDIF.

DATA gt_scarr TYPE TABLE OF scarr.
DATA gv_carrid TYPE c LENGTH 3 VALUE 'AA'.
DATA gt_range TYPE RANGE OF s_carr_id.

gt_scarr = VALUE #( BASE  gt_scarr
                    ( carrid = gv_carrid
                      carrname = 'American airlines'
                      currcode =  'EUR' )
                   ).

gt_scarr = VALUE #(  BASE  gt_scarr

                    ( carrid = 'LH'
                      carrname = 'Lufthansa'
                      currcode = 'EUR' )

                   ).

gt_range = VALUE #( FOR line IN gt_scarr
                    WHERE ( currcode = 'EUR' )

                          ( sign = ''
                            option = 'EQ'
                            low = line-carrid )


                  ).


BREAK-POINT.
