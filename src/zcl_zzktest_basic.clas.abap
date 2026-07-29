CLASS zcl_zzktest_basic DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zzktest_basic IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA update_tab TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.
    update_tab = VALUE #( ( AgencyID = '070009' Name = 'ZZK GOOD' ) ).

    MODIFY ENTITIES OF /DMO/I_AgencyTP
    ENTITY /DMO/Agency
    UPDATE FIELDS ( Name )
    WITH update_tab.

    COMMIT ENTITIES.

    out->write( 'Done' ).
  ENDMETHOD.
ENDCLASS.
