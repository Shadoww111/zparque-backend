CLASS lsc_zi_cs4_cliente DEFINITION INHERITING FROM cl_abap_behavior_saver.
    PROTECTED SECTION.
      METHODS:
        save REDEFINITION,
        finalize REDEFINITION,
        check_before_save REDEFINITION,
        cleanup REDEFINITION,
        cleanup_finalize REDEFINITION.
  ENDCLASS.
  
  CLASS lsc_zi_cs4_cliente IMPLEMENTATION.
  
    METHOD save.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
      " Processar criação de clientes
      DATA(lt_cliente_create) = lo_instance->get_created_cliente( ).
      IF lt_cliente_create IS NOT INITIAL.
        INSERT zdt_cliente FROM TABLE @lt_cliente_create.
      ENDIF.
      " Processar atualização de clientes
      DATA(lt_cliente_update) = lo_instance->get_update_cliente( ).
      IF lt_cliente_update IS NOT INITIAL.
        UPDATE zdt_cliente FROM TABLE @lt_cliente_update.
      ENDIF.
      " Processar exclusão de clientes
      DATA(lt_cliente_delete) = lo_instance->get_delete_cliente( ).
      IF lt_cliente_delete IS NOT INITIAL.
        LOOP AT lt_cliente_delete ASSIGNING FIELD-SYMBOL(<fs_delete>).
          " Verificar se existem veículos associados
          SELECT COUNT(*) FROM zdt_veiculo
            WHERE id_cliente = @<fs_delete>-id_cliente
            INTO @DATA(lv_count).
          " Excluir o cliente apenas se não houver veículos (ou se já foram excluídos)
          IF lv_count = 0.
            DELETE FROM zdt_cliente WHERE id_cliente = @<fs_delete>-id_cliente.
          ENDIF.
        ENDLOOP.
      ENDIF.
      " Processar criação de veículos
      DATA(lt_veiculo_create) = lo_instance->get_created_veiculo( ).
      IF lt_veiculo_create IS NOT INITIAL.
        INSERT zdt_veiculo FROM TABLE @lt_veiculo_create.
      ENDIF.
      " Processar atualização de veículos
      DATA(lt_veiculo_update) = lo_instance->get_update_veiculo( ).
      IF lt_veiculo_update IS NOT INITIAL.
        UPDATE zdt_veiculo FROM TABLE @lt_veiculo_update.
      ENDIF.
      " Processar exclusão de veículos
      DATA(lt_veiculo_delete) = lo_instance->get_delete_veiculo( ).
      IF lt_veiculo_delete IS NOT INITIAL.
        LOOP AT lt_veiculo_delete ASSIGNING FIELD-SYMBOL(<fs_veiculo_delete>).
          DELETE FROM zdt_veiculo WHERE id_veiculo = @<fs_veiculo_delete>-id_veiculo.
        ENDLOOP.
      ENDIF.
      " Limpar buffers após o salvamento
      lo_instance->clear( ).
    ENDMETHOD.
  
    METHOD finalize.
  
    ENDMETHOD.
  
    METHOD check_before_save.
  
    ENDMETHOD.
  
    METHOD cleanup.
  
    ENDMETHOD.
  
    METHOD cleanup_finalize.
  
    ENDMETHOD.
  
  ENDCLASS.
  
  CLASS lhc_zi_cs4_cliente DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
      METHODS:
  
  
        create FOR MODIFY
          IMPORTING entities FOR CREATE Cliente,
  
        update FOR MODIFY
          IMPORTING entities FOR UPDATE Cliente,
  
        delete FOR MODIFY
          IMPORTING keys FOR DELETE Cliente,
  
        read FOR READ
          IMPORTING keys FOR READ Cliente RESULT result,
  
        lock FOR LOCK
          IMPORTING keys FOR LOCK Cliente,
  
        rba_Veiculos FOR READ
          IMPORTING keys_rba FOR READ Cliente\_Veiculos FULL result_requested RESULT result LINK association_links,
  
        cba_Veiculos FOR MODIFY
          IMPORTING entities_cba FOR CREATE Cliente\_Veiculos.
  
  ENDCLASS.
  
  CLASS lhc_zi_cs4_cliente IMPLEMENTATION.
  
  
  
    METHOD create.
      DATA ls_cliente TYPE zdt_cliente.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
  
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
        CLEAR ls_cliente.
        ls_cliente-client = sy-mandt.
  
        " Obter próximo ID de cliente
        SELECT MAX( id_cliente ) FROM zdt_cliente INTO @DATA(lv_max_id).
        IF sy-subrc <> 0.
          lv_max_id = 0.
        ENDIF.
        ls_cliente-id_cliente = lv_max_id + 1.
  
        " Mapear dados da entidade para a tabela
        ls_cliente-nome = <lfs_entity>-Nome.
        ls_cliente-nif = <lfs_entity>-Nif.
        ls_cliente-email = <lfs_entity>-Email.
        ls_cliente-telefone = <lfs_entity>-Telefone.
        ls_cliente-id_tipo_cliente = <lfs_entity>-IdTipoCliente.
  
        " Preencher campos de auditoria
        ls_cliente-local_created_by = sy-uname.
        GET TIME STAMP FIELD ls_cliente-local_created_at.
        ls_cliente-local_last_changed_by = ls_cliente-local_created_by.
        ls_cliente-last_changed_at = ls_cliente-local_created_at.
  
        " Adicionar ao buffer de criação
        lo_instance->set_create_cliente( ls_cliente ).
  
        " Mapear resultado para o framework
        APPEND VALUE #(
          %cid = <lfs_entity>-%cid
          IdCliente = ls_cliente-id_cliente
        ) TO mapped-cliente.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD update.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
  
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
        " Obter registro atual
        DATA(ls_cliente) = lo_instance->get_cliente_record( <lfs_entity>-IdCliente ).
  
        IF ls_cliente IS NOT INITIAL.
          " Atualizar apenas os campos modificados
          DATA(ls_control) = <lfs_entity>-%control.
  
          IF ls_control-Nome IS NOT INITIAL.
            ls_cliente-nome = <lfs_entity>-Nome.
          ENDIF.
  
          IF ls_control-Nif IS NOT INITIAL.
            ls_cliente-nif = <lfs_entity>-Nif.
          ENDIF.
  
          IF ls_control-Email IS NOT INITIAL.
            ls_cliente-email = <lfs_entity>-Email.
          ENDIF.
  
          IF ls_control-Telefone IS NOT INITIAL.
            ls_cliente-telefone = <lfs_entity>-Telefone.
          ENDIF.
  
          IF ls_control-IdTipoCliente IS NOT INITIAL.
            ls_cliente-id_tipo_cliente = <lfs_entity>-IdTipoCliente.
          ENDIF.
  
  
  
          " Atualizar campos de auditoria
          ls_cliente-local_last_changed_by = sy-uname.
          GET TIME STAMP FIELD ls_cliente-last_changed_at.
  
          " Adicionar ao buffer de atualização
          lo_instance->set_update_cliente( ls_cliente ).
  
          
        ENDIF.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD delete.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
      DATA ls_cliente TYPE zdt_cliente.
  
      READ ENTITIES OF zi_cs4_cliente IN LOCAL MODE
        ENTITY Cliente
          ALL FIELDS
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_clientes).
  
      IF lt_clientes IS INITIAL.
        RETURN.
      ENDIF.
  
      LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<lfs_cliente>).
        CLEAR ls_cliente.
        ls_cliente-client = sy-mandt.
        ls_cliente-id_cliente = <lfs_cliente>-IdCliente.
  
        " Adicionar ao buffer de exclusão
        lo_instance->set_delete_cliente( ls_cliente ).
  
        " Mapear resultado para o framework
        APPEND VALUE #( %tky = <lfs_cliente>-%tky ) TO mapped-cliente.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD read.
      " Ler diretamente da tabela
      SELECT * FROM zdt_cliente
        FOR ALL ENTRIES IN @keys
        WHERE id_cliente = @keys-IdCliente
        INTO TABLE @DATA(lt_clientes).
  
      " Mapear resultados para a entidade
      result = CORRESPONDING #( lt_clientes MAPPING
                               IdCliente      = id_cliente
                               Nome           = nome
                               Nif            = nif
                               Email          = email
                               Telefone       = telefone
                               IdTipoCliente  = id_tipo_cliente
                               CreatedBy      = local_created_by
                               CreatedAt      = local_created_at
                               LastChangedBy  = local_last_changed_by
                               LastChangedAt  = last_changed_at ).
    ENDMETHOD.
  
    METHOD lock.
  
    ENDMETHOD.
  METHOD rba_Veiculos.
    " Ler veículos associados aos clientes
    READ ENTITIES OF zi_cs4_cliente IN LOCAL MODE
      ENTITY Cliente
        FIELDS ( IdCliente )
        WITH CORRESPONDING #( keys_rba )
      RESULT DATA(lt_clientes).
  
    " Verificar se há clientes para buscar veículos
    IF lt_clientes IS NOT INITIAL.
      " Construir condição WHERE para a consulta SQL
      SELECT * FROM zdt_veiculo
        FOR ALL ENTRIES IN @lt_clientes
        WHERE id_cliente = @lt_clientes-IdCliente
        INTO TABLE @DATA(lt_veiculos).
  
      " Processar resultados somente se tiver veículos
      IF lt_veiculos IS NOT INITIAL.
        " Criar links de associação e resultados
        LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<fs_cliente>).
          " Para cada cliente, procurar todos seus veículos
          LOOP AT lt_veiculos ASSIGNING FIELD-SYMBOL(<fs_veiculo>)
              WHERE id_cliente = <fs_cliente>-IdCliente.
            " Criar link de associação entre cliente e veículo
            INSERT VALUE #(
              source-%tky = <fs_cliente>-%tky
              target-%tky = VALUE #( IdVeiculo = <fs_veiculo>-id_veiculo )
            ) INTO TABLE association_links.
  
            " Adicionar ao resultado se solicitado
            IF result_requested = abap_true.
              INSERT CORRESPONDING #( <fs_veiculo> MAPPING
                                     IdVeiculo      = id_veiculo
                                     Matricula      = matricula
                                     Marca          = marca
                                     Modelo         = modelo
                                     IdTipoVeiculo  = id_tipo_veiculo
                                     IdCliente      = id_cliente
                                     Eletrico       = eletrico
                                     CreatedBy      = local_created_by
                                     CreatedAt      = local_created_at
                                     LastChangedBy  = local_last_changed_by
                                     LastChangedAt  = last_changed_at )
              INTO TABLE result.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDMETHOD.
    METHOD cba_Veiculos.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
      DATA ls_veiculo TYPE zdt_veiculo.
  
      LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<lfs_cba>).
        DATA(lv_id_cliente) = <lfs_cba>-IdCliente.
  
        LOOP AT <lfs_cba>-%target ASSIGNING FIELD-SYMBOL(<lfs_veiculo>).
          CLEAR ls_veiculo.
          ls_veiculo-client = sy-mandt.
  
          " Obter próximo ID de veículo
          SELECT MAX( id_veiculo ) FROM zdt_veiculo INTO @DATA(lv_max_id).
          IF sy-subrc <> 0.
            lv_max_id = 0.
          ENDIF.
          ls_veiculo-id_veiculo = lv_max_id + 1.
  
          " Mapear dados da entidade para a tabela
          ls_veiculo-matricula = <lfs_veiculo>-Matricula.
          ls_veiculo-marca = <lfs_veiculo>-Marca.
          ls_veiculo-modelo = <lfs_veiculo>-Modelo.
          ls_veiculo-id_tipo_veiculo = <lfs_veiculo>-IdTipoVeiculo.
          ls_veiculo-id_cliente = lv_id_cliente.
          ls_veiculo-eletrico = <lfs_veiculo>-Eletrico.
  
          " Preencher campos de auditoria
          ls_veiculo-local_created_by = sy-uname.
          GET TIME STAMP FIELD ls_veiculo-local_created_at.
          ls_veiculo-local_last_changed_by = ls_veiculo-local_created_by.
          ls_veiculo-last_changed_at = ls_veiculo-local_created_at.
  
          " Adicionar ao buffer de criação
          lo_instance->set_create_veiculo( ls_veiculo ).
  
          " Mapear resultado para o framework
          APPEND VALUE #(
            %cid = <lfs_veiculo>-%cid
            %tky = VALUE #( IdVeiculo = ls_veiculo-id_veiculo )
          ) TO mapped-veiculo.
        ENDLOOP.
      ENDLOOP.
    ENDMETHOD.
  
  ENDCLASS.
  
  CLASS lhc_zi_cs4_veiculo DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
      METHODS:
        update FOR MODIFY
          IMPORTING entities FOR UPDATE Veiculo,
  
        delete FOR MODIFY
          IMPORTING keys FOR DELETE Veiculo,
  
        read FOR READ
          IMPORTING keys FOR READ Veiculo RESULT result,
  
        rba_Cliente FOR READ
          IMPORTING keys_rba FOR READ Veiculo\_Cliente FULL result_requested RESULT result LINK association_links.
  
  ENDCLASS.
  
  CLASS lhc_zi_cs4_veiculo IMPLEMENTATION.
  
    METHOD update.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
  
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
        " Obter registro atual
        DATA(ls_veiculo) = lo_instance->get_veiculo_record( <lfs_entity>-IdVeiculo ).
  
        IF ls_veiculo IS NOT INITIAL.
          " Atualizar apenas os campos modificados
          DATA(ls_control) = <lfs_entity>-%control.
  
          IF ls_control-Matricula IS NOT INITIAL.
            ls_veiculo-matricula = <lfs_entity>-Matricula.
          ENDIF.
  
          IF ls_control-Marca IS NOT INITIAL.
            ls_veiculo-marca = <lfs_entity>-Marca.
          ENDIF.
  
          IF ls_control-Modelo IS NOT INITIAL.
            ls_veiculo-modelo = <lfs_entity>-Modelo.
          ENDIF.
  
          IF ls_control-IdTipoVeiculo IS NOT INITIAL.
            ls_veiculo-id_tipo_veiculo = <lfs_entity>-IdTipoVeiculo.
          ENDIF.
  
          IF ls_control-Eletrico IS NOT INITIAL.
            ls_veiculo-eletrico = <lfs_entity>-Eletrico.
          ENDIF.
  
          " Atualizar campos de auditoria
          ls_veiculo-local_last_changed_by = sy-uname.
          GET TIME STAMP FIELD ls_veiculo-last_changed_at.
  
          " Adicionar ao buffer de atualização
          lo_instance->set_update_veiculo( ls_veiculo ).
  
          " Mapear resultado para o framework
          APPEND VALUE #( %tky = <lfs_entity>-%tky ) TO mapped-veiculo.
        ENDIF.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD delete.
      DATA(lo_instance) = zcl_cs4_cliente=>get_instance( ).
      DATA ls_veiculo TYPE zdt_veiculo.
  
      READ ENTITIES OF zi_cs4_cliente IN LOCAL MODE
        ENTITY Veiculo
          ALL FIELDS
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_veiculos).
  
      IF lt_veiculos IS INITIAL.
        RETURN.
      ENDIF.
  
      LOOP AT lt_veiculos ASSIGNING FIELD-SYMBOL(<lfs_veiculo>).
        CLEAR ls_veiculo.
        ls_veiculo-client = sy-mandt.
        ls_veiculo-id_veiculo = <lfs_veiculo>-IdVeiculo.
  
        " Adicionar ao buffer de exclusão
        lo_instance->set_delete_veiculo( ls_veiculo ).
  
        " Mapear resultado para o framework
        APPEND VALUE #( %tky = <lfs_veiculo>-%tky ) TO mapped-veiculo.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD read.
      " Ler diretamente da tabela
      SELECT * FROM zdt_veiculo
        FOR ALL ENTRIES IN @keys
        WHERE id_veiculo = @keys-IdVeiculo
        INTO TABLE @DATA(lt_veiculos).
  
      " Mapear resultados para a entidade
      result = CORRESPONDING #( lt_veiculos MAPPING
                               IdVeiculo      = id_veiculo
                               Matricula      = matricula
                               Marca          = marca
                               Modelo         = modelo
                               IdTipoVeiculo  = id_tipo_veiculo
                               IdCliente      = id_cliente
                               Eletrico       = eletrico
                               CreatedBy      = local_created_by
                               CreatedAt      = local_created_at
                               LastChangedBy  = local_last_changed_by
                               LastChangedAt  = last_changed_at ).
    ENDMETHOD.
  
   METHOD rba_Cliente.
    " Ler veículos para os quais queremos obter os clientes associados
    READ ENTITIES OF zi_cs4_cliente IN LOCAL MODE
      ENTITY Veiculo
        FIELDS ( IdCliente )
        WITH CORRESPONDING #( keys_rba )
      RESULT DATA(lt_veiculos).
  
    " Verificar se há veículos para buscar clientes
    IF lt_veiculos IS NOT INITIAL.
      " Buscar todos os clientes relacionados aos veículos
      SELECT * FROM zdt_cliente
        FOR ALL ENTRIES IN @lt_veiculos
        WHERE id_cliente = @lt_veiculos-IdCliente
        INTO TABLE @DATA(lt_clientes).
  
      " Processar resultados
      LOOP AT lt_veiculos ASSIGNING FIELD-SYMBOL(<fs_veiculo>).
        READ TABLE lt_clientes ASSIGNING FIELD-SYMBOL(<fs_cliente>)
          WITH KEY id_cliente = <fs_veiculo>-IdCliente.
        IF sy-subrc = 0.
          " Criar link de associação entre veículo e cliente
          INSERT VALUE #(
            source-%tky = <fs_veiculo>-%tky
            target-%tky = VALUE #( IdCliente = <fs_cliente>-id_cliente )
          ) INTO TABLE association_links.
  
          " Adicionar ao resultado se solicitado
          IF result_requested = abap_true.
            INSERT CORRESPONDING #( <fs_cliente> MAPPING
                                 IdCliente      = id_cliente
                                 Nome           = nome
                                 Nif            = nif
                                 Email          = email
                                 Telefone       = telefone
                                 IdTipoCliente  = id_tipo_cliente
                                 CreatedBy      = local_created_by
                                 CreatedAt      = local_created_at
                                 LastChangedBy  = local_last_changed_by
                                 LastChangedAt  = last_changed_at )
            INTO TABLE result.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.
  
  ENDCLASS.