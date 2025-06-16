
CLASS zcl_disponibilidade DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES:
      tt_disponibilidade TYPE TABLE OF zdisponibilidade WITH DEFAULT KEY.
    CLASS-METHODS:
      get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_disponibilidade.

    METHODS:
      set_create_disponibilidade IMPORTING is_disponibilidade TYPE zdisponibilidade,
      get_created_disponibilidade RETURNING VALUE(rt_disponibilidade) TYPE tt_disponibilidade,

      set_update_disponibilidade IMPORTING is_disponibilidade TYPE zdisponibilidade,
      get_update_disponibilidade RETURNING VALUE(rt_disponibilidade) TYPE tt_disponibilidade,
      get_disponibilidade_record IMPORTING iv_id_disponibilidade TYPE zdisponibilidade-id_dispo
                                  RETURNING VALUE(rs_disponibilidade) TYPE zdisponibilidade,

      set_delete_disponibilidade IMPORTING is_disponibilidade TYPE zdisponibilidade,
      get_delete_disponibilidade RETURNING VALUE(rt_disponibilidade) TYPE tt_disponibilidade,

      clear.

  PRIVATE SECTION.
    CLASS-DATA:
      go_instance TYPE REF TO zcl_disponibilidade.

    DATA:
      mt_disponibilidade_buffer TYPE tt_disponibilidade,
      mt_disponibilidade_update TYPE tt_disponibilidade,
      mt_disponibilidade_delete TYPE tt_disponibilidade.

ENDCLASS.

CLASS zcl_disponibilidade IMPLEMENTATION.

  METHOD get_instance.
    IF go_instance IS INITIAL.
      go_instance = NEW #( ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD set_create_disponibilidade.
    APPEND is_disponibilidade TO mt_disponibilidade_buffer.
  ENDMETHOD.

  METHOD get_created_disponibilidade.
    rt_disponibilidade = mt_disponibilidade_buffer.
  ENDMETHOD.

  METHOD set_update_disponibilidade.
    APPEND is_disponibilidade TO mt_disponibilidade_update.
  ENDMETHOD.

  METHOD get_update_disponibilidade.
    rt_disponibilidade = mt_disponibilidade_update.
  ENDMETHOD.

  METHOD get_disponibilidade_record.
    READ TABLE mt_disponibilidade_buffer INTO rs_disponibilidade
      WITH KEY id_dispo = iv_id_disponibilidade.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    READ TABLE mt_disponibilidade_update INTO rs_disponibilidade
      WITH KEY id_dispo = iv_id_disponibilidade.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    SELECT SINGLE * FROM zdisponibilidade
      WHERE id_dispo = @iv_id_disponibilidade
      INTO @rs_disponibilidade.
  ENDMETHOD.

  METHOD set_delete_disponibilidade.
    APPEND is_disponibilidade TO mt_disponibilidade_delete.
  ENDMETHOD.

  METHOD get_delete_disponibilidade.
    rt_disponibilidade = mt_disponibilidade_delete.
  ENDMETHOD.

  METHOD clear.
    CLEAR: mt_disponibilidade_buffer,
           mt_disponibilidade_update,
           mt_disponibilidade_delete.
  ENDMETHOD.

ENDCLASS.