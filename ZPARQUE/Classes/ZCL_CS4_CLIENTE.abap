
CLASS zcl_cs4_cliente DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES:
      tt_cliente TYPE TABLE OF zdt_cliente WITH DEFAULT KEY,
      tt_veiculo TYPE TABLE OF zdt_veiculo WITH DEFAULT KEY.

    CLASS-METHODS:
      get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_cs4_cliente.

    METHODS:
      set_create_cliente IMPORTING is_cliente TYPE zdt_cliente,
      get_created_cliente RETURNING VALUE(rt_cliente) TYPE tt_cliente,

      set_update_cliente IMPORTING is_cliente TYPE zdt_cliente,
      get_update_cliente RETURNING VALUE(rt_cliente) TYPE tt_cliente,
      get_cliente_record IMPORTING iv_id_cliente TYPE zdt_cliente-id_cliente
                         RETURNING VALUE(rs_cliente) TYPE zdt_cliente,

      set_delete_cliente IMPORTING is_cliente TYPE zdt_cliente,
      get_delete_cliente RETURNING VALUE(rt_cliente) TYPE tt_cliente,

      set_create_veiculo IMPORTING is_veiculo TYPE zdt_veiculo,
      get_created_veiculo RETURNING VALUE(rt_veiculo) TYPE tt_veiculo,

      set_update_veiculo IMPORTING is_veiculo TYPE zdt_veiculo,
      get_update_veiculo RETURNING VALUE(rt_veiculo) TYPE tt_veiculo,
      get_veiculo_record IMPORTING iv_id_veiculo TYPE zdt_veiculo-id_veiculo
                         RETURNING VALUE(rs_veiculo) TYPE zdt_veiculo,

      set_delete_veiculo IMPORTING is_veiculo TYPE zdt_veiculo,
      get_delete_veiculo RETURNING VALUE(rt_veiculo) TYPE tt_veiculo,

      clear.

  PRIVATE SECTION.
    CLASS-DATA:
      go_instance TYPE REF TO zcl_cs4_cliente.

    DATA:
      mt_cliente_buffer TYPE tt_cliente,
      mt_cliente_update TYPE tt_cliente,
      mt_cliente_delete TYPE tt_cliente,
      mt_veiculo_buffer TYPE tt_veiculo,
      mt_veiculo_update TYPE tt_veiculo,
      mt_veiculo_delete TYPE tt_veiculo.

ENDCLASS.

CLASS zcl_cs4_cliente IMPLEMENTATION.

  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW #( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD set_create_cliente.
    APPEND is_cliente TO mt_cliente_buffer.
  ENDMETHOD.

  METHOD get_created_cliente.
    rt_cliente = mt_cliente_buffer.
  ENDMETHOD.

  METHOD set_update_cliente.
    APPEND is_cliente TO mt_cliente_update.
  ENDMETHOD.

  METHOD get_update_cliente.
    rt_cliente = mt_cliente_update.
  ENDMETHOD.

  METHOD get_cliente_record.
    " Primeiro, verificar se o cliente está no buffer de criação
    READ TABLE mt_cliente_buffer INTO rs_cliente
        WITH KEY id_cliente = iv_id_cliente.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    " Em seguida, verificar se o cliente está no buffer de atualização
    READ TABLE mt_cliente_update INTO rs_cliente
        WITH KEY id_cliente = iv_id_cliente.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    " Se não estiver em nenhum buffer, buscar no banco de dados
    SELECT SINGLE * FROM zdt_cliente
        WHERE id_cliente = @iv_id_cliente
        INTO @rs_cliente.
  ENDMETHOD.

  METHOD set_delete_cliente.
    APPEND is_cliente TO mt_cliente_delete.
  ENDMETHOD.

  METHOD get_delete_cliente.
    rt_cliente = mt_cliente_delete.
  ENDMETHOD.

  METHOD set_create_veiculo.
    APPEND is_veiculo TO mt_veiculo_buffer.
  ENDMETHOD.

  METHOD get_created_veiculo.
    rt_veiculo = mt_veiculo_buffer.
  ENDMETHOD.

  METHOD set_update_veiculo.
    APPEND is_veiculo TO mt_veiculo_update.
  ENDMETHOD.

  METHOD get_update_veiculo.
    rt_veiculo = mt_veiculo_update.
  ENDMETHOD.

  METHOD get_veiculo_record.
    " Primeiro, verificar se o veículo está no buffer de criação
    READ TABLE mt_veiculo_buffer INTO rs_veiculo
        WITH KEY id_veiculo = iv_id_veiculo.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    " Em seguida, verificar se o veículo está no buffer de atualização
    READ TABLE mt_veiculo_update INTO rs_veiculo
        WITH KEY id_veiculo = iv_id_veiculo.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    " Se não estiver em nenhum buffer, buscar no banco de dados
    SELECT SINGLE * FROM zdt_veiculo
        WHERE id_veiculo = @iv_id_veiculo
        INTO @rs_veiculo.
  ENDMETHOD.

  METHOD set_delete_veiculo.
    APPEND is_veiculo TO mt_veiculo_delete.
  ENDMETHOD.

  METHOD get_delete_veiculo.
    rt_veiculo = mt_veiculo_delete.
  ENDMETHOD.

  METHOD clear.
    CLEAR: mt_cliente_buffer,
           mt_cliente_update,
           mt_cliente_delete,
           mt_veiculo_buffer,
           mt_veiculo_update,
           mt_veiculo_delete.
  ENDMETHOD.

ENDCLASS.