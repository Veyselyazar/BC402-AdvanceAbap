*&---------------------------------------------------------------------*
*& Report Z01_BSP_SWITCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bsp_switch.

PARAMETERS pa_class TYPE sbook-class.
"DATA gv_text TYPE string.
TRY.
    WRITE  SWITCH #( pa_class
              WHEN 'Y' THEN 'Economy'
              WHEN 'C' THEN 'Business'
              WHEN 'F' THEN 'First'
              WHEN 'S' THEN THROW
                zcx_bc401( textid = zcx_bc401=>class_not_found klasse = 'S' )
              ELSE 'Nicht definiert' ).

  CATCH zcx_bc401 INTO DATA(go_error).
    MESSAGE go_error->get_text( ) TYPE 'I'.
ENDTRY.
