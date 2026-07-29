CLASS lhc_zr_8386flight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Flight
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flight~CheckSemanticKey,
      ValidatePrice FOR VALIDATE ON SAVE
        IMPORTING keys FOR Flight~ValidatePrice.
ENDCLASS.

CLASS lhc_zr_8386flight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD CheckSemanticKey.

    READ ENTITIES OF zr_8386flight IN LOCAL MODE
      ENTITY Flight
      FIELDS ( CarrierID ConnectionID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(Flights).

    LOOP AT Flights REFERENCE INTO DATA(Flight).

      IF Flight->CarrierID IS INITIAL OR Flight->ConnectionID IS INITIAL.
        APPEND VALUE #( %tky = Flight->%tky ) TO failed-Flight.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidatePrice.

    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    READ ENTITIES OF zr_8386flight IN LOCAL MODE
        ENTITY Flight
        FIELDS ( Price )
        WITH CORRESPONDING #( keys )
        RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).
      IF flight-Price < 0.
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flight.

        reported_record-%tky = flight-%tky.
        reported_record-%msg = new_message( id = 'ZZKTEST' number = '001' severity = ms-error v1 = 'test' ).
        APPEND reported_record TO reported-flight.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
