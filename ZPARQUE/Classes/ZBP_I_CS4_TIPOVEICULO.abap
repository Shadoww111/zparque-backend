CLASS zbp_i_cs4_tipoveiculo DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_cs4_tipoveiculo.
ENDCLASS.

CLASS zbp_i_cs4_tipoveiculo IMPLEMENTATION.
ENDCLASS.

CLASS lhc_TipoVeiculo DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
  
      METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING REQUEST requested_authorizations FOR TipoVeiculo RESULT result.
  
  
  ENDCLASS.
  
  CLASS lhc_TipoVeiculo IMPLEMENTATION.
  
  
    METHOD get_global_authorizations.
    ENDMETHOD.
  
  
  ENDCLASS.