CLASS zbp_cs4_tipo_cliente DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_cs4_tipocliente.
ENDCLASS.

CLASS zbp_cs4_tipo_cliente IMPLEMENTATION.
ENDCLASS.

CLASS lhc_TipoCliente DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
  
      METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING REQUEST requested_authorizations FOR TipoCliente RESULT result.
  
  ENDCLASS.
  
  CLASS lhc_TipoCliente IMPLEMENTATION.
  
    METHOD get_global_authorizations.
    ENDMETHOD.
  
  ENDCLASS.