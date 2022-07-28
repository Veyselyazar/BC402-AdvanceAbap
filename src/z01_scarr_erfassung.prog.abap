report Z01_SCARR_ERFASSUNG
       no standard page heading line-size 255.

* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
include bdcrecx1_s.

start-of-selection.

perform open_group.

perform bdc_dynpro      using 'SAPLSD_ENTRY' '1000'.
perform bdc_field       using 'BDC_CURSOR'
                              'RSRD1-TBMA_VAL'.
perform bdc_field       using 'BDC_OKCODE'
                              '=WB_DISPLAY'.
perform bdc_field       using 'RSRD1-TBMA'
                              'X'.
perform bdc_field       using 'RSRD1-TBMA_VAL'
                              'scarr'.
perform bdc_dynpro      using 'SAPLSD41' '2200'.
perform bdc_field       using 'BDC_CURSOR'
                              'DD02D-DBTABNAME'.
perform bdc_field       using 'BDC_OKCODE'
                              '=TDED'.
perform bdc_dynpro      using '/1BCDWB/DBSCARR' '0101'.
perform bdc_field       using 'BDC_CURSOR'
                              'SCARR-URL'.
perform bdc_field       using 'BDC_OKCODE'
                              '=SAVE'.
perform bdc_field       using 'SCARR-CARRID'
                              'KL3'.
perform bdc_field       using 'SCARR-CARRNAME'
                              'KLM airline 3'.
perform bdc_field       using 'SCARR-CURRCODE'
                              'EUR'.
perform bdc_field       using 'SCARR-URL'
                              'http:/klm3.com'.
perform bdc_dynpro      using '/1BCDWB/DBSCARR' '0101'.
perform bdc_field       using 'BDC_OKCODE'
                              '/EEND'.
perform bdc_field       using 'BDC_CURSOR'
                              'SCARR-CARRID'.
perform bdc_dynpro      using 'SAPLSD41' '2200'.
perform bdc_field       using 'BDC_CURSOR'
                              'DD02D-DBTABNAME'.
perform bdc_field       using 'BDC_OKCODE'
                              '=WB_END'.
perform bdc_transaction using 'SE11'.

perform close_group.
message 'Ende' type 'I'.
