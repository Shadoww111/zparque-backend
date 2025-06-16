CLASS zcl_movimento DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES:
      tt_movimento TYPE TABLE OF zmovimento WITH DEFAULT KEY.
    CLASS-METHODS:
      get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_movimento.

    METHODS:
      set_create_movimento IMPORTING is_movimento TYPE zmovimento,
      get_created_movimento RETURNING VALUE(rt_movimento) TYPE tt_movimento,

      set_update_movimento IMPORTING is_movimento TYPE zmovimento,
      get_update_movimento RETURNING VALUE(rt_movimento) TYPE tt_movimento,
      get_movimento_record IMPORTING iv_id_movimento TYPE zmovimento-id_movimento
                           RETURNING VALUE(rs_movimento) TYPE zmovimento,

      set_delete_movimento IMPORTING is_movimento TYPE zmovimento,
      get_delete_movimento RETURNING VALUE(rt_movimento) TYPE tt_movimento,

      clear.

  PRIVATE SECTION.
    CLASS-DATA:
      go_instance TYPE REF TO zcl_movimento.

    DATA:
      mt_movimento_buffer TYPE tt_movimento,
      mt_movimento_update TYPE tt_movimento,
      mt_movimento_delete TYPE tt_movimento.


ENDCLASS.

CLASS zcl_movimento IMPLEMENTATION.

  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW #( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD set_create_movimento.
    APPEND is_movimento TO mt_movimento_buffer.
  ENDMETHOD.

  METHOD get_created_movimento.
    rt_movimento = mt_movimento_buffer.
  ENDMETHOD.

  METHOD set_update_movimento.
    APPEND is_movimento TO mt_movimento_update.
  ENDMETHOD.

  METHOD get_update_movimento.
    rt_movimento = mt_movimento_update.
  ENDMETHOD.

  METHOD get_movimento_record.
    READ TABLE mt_movimento_buffer INTO rs_movimento
      WITH KEY id_movimento = iv_id_movimento.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    READ TABLE mt_movimento_update INTO rs_movimento
      WITH KEY id_movimento = iv_id_movimento.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM zmovimento
      WHERE id_movimento = @iv_id_movimento
      INTO @rs_movimento.
  ENDMETHOD.

  METHOD set_delete_movimento.
    APPEND is_movimento TO mt_movimento_delete.
  ENDMETHOD.

  METHOD get_delete_movimento.
    rt_movimento = mt_movimento_delete.
  ENDMETHOD.

  METHOD clear.
    CLEAR: mt_movimento_buffer,
           mt_movimento_update,
           mt_movimento_delete.
  ENDMETHOD.


ENDCLASS.