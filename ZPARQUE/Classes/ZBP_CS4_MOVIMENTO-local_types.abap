CLASS lsc_zi_cs4_movimento DEFINITION INHERITING FROM cl_abap_behavior_saver.
    PROTECTED SECTION.
      METHODS:
        save REDEFINITION,
        finalize REDEFINITION,
        check_before_save REDEFINITION,
        cleanup REDEFINITION,
        cleanup_finalize REDEFINITION.
  ENDCLASS.
  
  CLASS lsc_zi_cs4_movimento IMPLEMENTATION.
  
    METHOD save.
      DATA(lo_movimento_instance) = zcl_movimento=>get_instance( ).
      DATA(lo_disponibilidade_instance) = zcl_disponibilidade=>get_instance( ).
  
      " Processar movimentos a serem criados
      DATA(lt_movimento_create) = lo_movimento_instance->get_created_movimento( ).
      IF lt_movimento_create IS NOT INITIAL.
        INSERT zmovimento FROM TABLE @lt_movimento_create.
      ENDIF.
  
      " Processar movimentos a serem atualizados
      DATA(lt_movimento_update) = lo_movimento_instance->get_update_movimento( ).
      IF lt_movimento_update IS NOT INITIAL.
        " Use uma tabela interna temporária para garantir que todos os campos sejam preenchidos
        DATA: lt_temp_update TYPE TABLE OF zmovimento.
  
        " Lê os registros atuais antes de atualizar
        SELECT * FROM zmovimento
          FOR ALL ENTRIES IN @lt_movimento_update
          WHERE id_movimento = @lt_movimento_update-id_movimento
          INTO TABLE @lt_temp_update.
  
        " Atualiza os campos específicos mantendo os valores existentes para os demais
        LOOP AT lt_movimento_update ASSIGNING FIELD-SYMBOL(<fs_update>).
          READ TABLE lt_temp_update ASSIGNING FIELD-SYMBOL(<fs_current>)
            WITH KEY id_movimento = <fs_update>-id_movimento.
          IF sy-subrc = 0.
            " Atualiza apenas os campos que foram alterados
            <fs_current>-matricula = <fs_update>-matricula.
            <fs_current>-id_veiculo = <fs_update>-id_veiculo.
            <fs_current>-id_cliente = <fs_update>-id_cliente.
            <fs_current>-id_tipo_veiculo = <fs_update>-id_tipo_veiculo.
            <fs_current>-data_entrada = <fs_update>-data_entrada.
            <fs_current>-data_saida = <fs_update>-data_saida.
            <fs_current>-duracao_horas = <fs_update>-duracao_horas.
            <fs_current>-valor_bruto = <fs_update>-valor_bruto.
            <fs_current>-desconto = <fs_update>-desconto.
            <fs_current>-valor_liquido = <fs_update>-valor_liquido.
            <fs_current>-moeda = <fs_update>-moeda.
            <fs_current>-status = <fs_update>-status.
            <fs_current>-local_last_changed_by = <fs_update>-local_last_changed_by.
            <fs_current>-last_changed_at = <fs_update>-last_changed_at.
          ELSE.
            " Se não encontrou, usa o registro de atualização diretamente
            APPEND <fs_update> TO lt_temp_update.
          ENDIF.
        ENDLOOP.
  
        " Atualiza os registros usando a tabela temporária
        MODIFY zmovimento FROM TABLE @lt_temp_update.
      ENDIF.
  
      " Processar movimentos a serem excluídos
      DATA(lt_movimento_delete) = lo_movimento_instance->get_delete_movimento( ).
      IF lt_movimento_delete IS NOT INITIAL.
        LOOP AT lt_movimento_delete ASSIGNING FIELD-SYMBOL(<fs_delete>).
          DELETE FROM zmovimento WHERE id_movimento = @<fs_delete>-id_movimento.
        ENDLOOP.
      ENDIF.
  
      " Processar disponibilidade a ser criada
      DATA(lt_disponibilidade_create) = lo_disponibilidade_instance->get_created_disponibilidade( ).
      IF lt_disponibilidade_create IS NOT INITIAL.
        INSERT zdisponibilidade FROM TABLE @lt_disponibilidade_create.
      ENDIF.
  
      " Processar disponibilidade a ser atualizada
      DATA(lt_disponibilidade_update) = lo_disponibilidade_instance->get_update_disponibilidade( ).
      IF lt_disponibilidade_update IS NOT INITIAL.
        MODIFY zdisponibilidade FROM TABLE @lt_disponibilidade_update.
      ENDIF.
  
      " Processar disponibilidade a ser excluída
      DATA(lt_disponibilidade_delete) = lo_disponibilidade_instance->get_delete_disponibilidade( ).
      IF lt_disponibilidade_delete IS NOT INITIAL.
        LOOP AT lt_disponibilidade_delete ASSIGNING FIELD-SYMBOL(<fs_dispo_delete>).
          DELETE FROM zdisponibilidade WHERE id_dispo = @<fs_dispo_delete>-id_dispo.
        ENDLOOP.
      ENDIF.
  
      " Limpar buffers
      lo_movimento_instance->clear( ).
      lo_disponibilidade_instance->clear( ).
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
  
  CLASS lhc_zi_cs4_movimento DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
      METHODS:
        create FOR MODIFY
          IMPORTING entities FOR CREATE Movimento,
  
        update FOR MODIFY
          IMPORTING entities FOR UPDATE Movimento,
  
        delete FOR MODIFY
          IMPORTING keys FOR DELETE Movimento,
  
        read FOR READ
          IMPORTING keys FOR READ Movimento RESULT result,
  
        lock FOR LOCK
          IMPORTING keys FOR LOCK Movimento,
  
        get_instance_authorizations FOR INSTANCE AUTHORIZATION
          IMPORTING keys REQUEST requested_authorizations FOR Movimento RESULT result,
  
        registrarSaida FOR MODIFY
          IMPORTING keys FOR ACTION Movimento~registrarSaida RESULT result.
  
  
  
  ENDCLASS.
  
  CLASS lhc_zi_cs4_movimento IMPLEMENTATION.
  METHOD create.
    DATA ls_movimento TYPE zmovimento.
    DATA ls_disponibilidade TYPE zdisponibilidade.
    DATA(lo_movimento_instance) = zcl_movimento=>get_instance( ).
    DATA(lo_disponibilidade_instance) = zcl_disponibilidade=>get_instance( ).
  
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
      CLEAR ls_movimento.
      ls_movimento-client = sy-mandt.
  
      " Validação básica da matrícula - apenas verifica se está preenchida
      IF <lfs_entity>-Matricula IS INITIAL.
        " Matrícula é obrigatória
        APPEND VALUE #( %cid = <lfs_entity>-%cid ) TO failed-movimento.
        APPEND VALUE #( %cid = <lfs_entity>-%cid
                       %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                          number = '108'
                                          severity = if_abap_behv_message=>severity-error )
                     ) TO reported-movimento.
        CONTINUE. " Pular para o próximo registro
      ENDIF.
  
      " Converter matrícula para maiúsculas - sem validação de formato complexa
      DATA(lv_matricula) = CONV string( <lfs_entity>-Matricula ).
      TRANSLATE lv_matricula TO UPPER CASE.
      ls_movimento-matricula = lv_matricula.
  
      " Verificar se o veículo já está no estacionamento
      SELECT COUNT(*) FROM zmovimento
        WHERE matricula = @ls_movimento-matricula
          AND status = 'E'
        INTO @DATA(lv_count).
  
      IF lv_count > 0.
        " Veículo já está no estacionamento
        APPEND VALUE #( %cid = <lfs_entity>-%cid ) TO failed-movimento.
        APPEND VALUE #( %cid = <lfs_entity>-%cid
                       %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                          number = '201'
                                          severity = if_abap_behv_message=>severity-error
                                          v1 = ls_movimento-matricula )
                     ) TO reported-movimento.
        CONTINUE.
      ENDIF.
  
      " Obter próximo ID de movimento
      SELECT MAX( id_movimento ) FROM zmovimento INTO @DATA(lv_max_id).
      IF sy-subrc <> 0.
        lv_max_id = 0.
      ENDIF.
      ls_movimento-id_movimento = lv_max_id + 1.
  
      " Verificar se a matrícula pertence a um cliente registrado
      SELECT SINGLE id_veiculo, id_cliente, id_tipo_veiculo
        FROM zdt_veiculo
        WHERE matricula = @ls_movimento-matricula
        INTO @DATA(ls_veiculo).
      IF sy-subrc = 0.
        " Cliente registrado
        ls_movimento-id_veiculo = ls_veiculo-id_veiculo.
        ls_movimento-id_cliente = ls_veiculo-id_cliente.
        ls_movimento-id_tipo_veiculo = ls_veiculo-id_tipo_veiculo.
        SELECT SINGLE id_cliente, nome, id_tipo_cliente
          FROM zdt_cliente
          WHERE id_cliente = @ls_veiculo-id_cliente
          INTO @DATA(ls_cliente).
      ELSE.
        " Cliente não registrado
        ls_movimento-id_veiculo = <lfs_entity>-IdVeiculo.
        ls_movimento-id_cliente = <lfs_entity>-IdCliente.
        ls_movimento-id_tipo_veiculo = <lfs_entity>-IdTipoVeiculo.
  
        " Validar tipo de veículo
        IF ls_movimento-id_tipo_veiculo IS INITIAL.
          APPEND VALUE #( %cid = <lfs_entity>-%cid ) TO failed-movimento.
          APPEND VALUE #( %cid = <lfs_entity>-%cid
                         %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                            number = '202'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_movimento-matricula )
                       ) TO reported-movimento.
          CONTINUE.
        ENDIF.
  
        " Verificar se o tipo de veículo existe
        SELECT SINGLE @abap_true
          FROM ztipo_veiculo
          WHERE id_tipo = @ls_movimento-id_tipo_veiculo
          INTO @DATA(lv_exists).
  
        IF lv_exists IS INITIAL.
          " Tipo de veículo inválido
          APPEND VALUE #( %cid = <lfs_entity>-%cid ) TO failed-movimento.
          APPEND VALUE #( %cid = <lfs_entity>-%cid
                         %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                            number = '203'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_movimento-id_tipo_veiculo )
                       ) TO reported-movimento.
          CONTINUE.
        ENDIF.
      ENDIF.
  
      " Verificar disponibilidade para o tipo de veículo
      DATA: lv_vagas_disponiveis TYPE int4.
  
      SELECT SINGLE * FROM zdisponibilidade INTO @ls_disponibilidade.
  
      IF sy-subrc <> 0.
        ls_disponibilidade-id_dispo = 1.
        ls_disponibilidade-lugares_moto_total = 20.
        ls_disponibilidade-lugares_ligeiro_total = 65.
        ls_disponibilidade-lugares_pesado_total = 15.
        ls_disponibilidade-lugares_moto_ocupados = 0.
        ls_disponibilidade-lugares_ligeiro_ocupados = 0.
        ls_disponibilidade-lugares_pesado_ocupados = 0.
        lo_disponibilidade_instance->set_create_disponibilidade( ls_disponibilidade ).
      ENDIF.
  
      " Calcular vagas disponíveis
      CASE ls_movimento-id_tipo_veiculo.
        WHEN 1. " Ligeiro
          lv_vagas_disponiveis = ls_disponibilidade-lugares_ligeiro_total - ls_disponibilidade-lugares_ligeiro_ocupados.
        WHEN 2. " Motociclo
          lv_vagas_disponiveis = ls_disponibilidade-lugares_moto_total - ls_disponibilidade-lugares_moto_ocupados.
        WHEN 3. " Pesado
          lv_vagas_disponiveis = ls_disponibilidade-lugares_pesado_total - ls_disponibilidade-lugares_pesado_ocupados.
        WHEN OTHERS.
          lv_vagas_disponiveis = 0.
      ENDCASE.
  
      " Se não houver vagas, não permitir entrada
      IF lv_vagas_disponiveis <= 0.
        APPEND VALUE #( %cid = <lfs_entity>-%cid ) TO failed-movimento.
        APPEND VALUE #( %cid = <lfs_entity>-%cid
                       %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                          number = '200'
                                          severity = if_abap_behv_message=>severity-error
                                          v1 = ls_movimento-id_tipo_veiculo )
                     ) TO reported-movimento.
        CONTINUE.
      ENDIF.
  
      " Registrar entrada automaticamente
      GET TIME STAMP FIELD ls_movimento-data_entrada.
      ls_movimento-status = 'E'. " E = Entrada registrada
  
      " Inicializar campos para evitar shortdump
      CLEAR: ls_movimento-data_saida,
             ls_movimento-duracao_horas,
             ls_movimento-valor_bruto,
             ls_movimento-desconto,
             ls_movimento-valor_liquido.
  
      " Definir moeda padrão
      IF ls_movimento-moeda IS INITIAL.
        ls_movimento-moeda = 'EUR'.
      ENDIF.
  
      " Campos de auditoria
      ls_movimento-local_created_by = sy-uname.
      GET TIME STAMP FIELD ls_movimento-local_created_at.
      ls_movimento-local_last_changed_by = ls_movimento-local_created_by.
      ls_movimento-last_changed_at = ls_movimento-local_created_at.
  
      lo_movimento_instance->set_create_movimento( ls_movimento ).
  
      " Mapear resultado - simplificado ao máximo
      APPEND VALUE #( %cid = <lfs_entity>-%cid
                     IdMovimento = ls_movimento-id_movimento ) TO mapped-movimento.
  
      " Atualizar ocupação após registrar entrada
      CASE ls_movimento-id_tipo_veiculo.
        WHEN 1. " Ligeiro
          ls_disponibilidade-lugares_ligeiro_ocupados = ls_disponibilidade-lugares_ligeiro_ocupados + 1.
        WHEN 2. " Motociclo
          ls_disponibilidade-lugares_moto_ocupados = ls_disponibilidade-lugares_moto_ocupados + 1.
        WHEN 3. " Pesado
          ls_disponibilidade-lugares_pesado_ocupados = ls_disponibilidade-lugares_pesado_ocupados + 1.
      ENDCASE.
  
      lo_disponibilidade_instance->set_update_disponibilidade( ls_disponibilidade ).
  
      " Mensagens informativas - simplificadas
      IF ls_cliente IS NOT INITIAL.
        APPEND VALUE #( %cid = <lfs_entity>-%cid
                        %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                           number = '100'
                                           severity = if_abap_behv_message=>severity-success
                                           v1 = ls_cliente-nome
                                           v2 = ls_cliente-id_cliente )
                      ) TO reported-movimento.
      ELSE.
        APPEND VALUE #( %cid = <lfs_entity>-%cid
                        %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                           number = '101'
                                           severity = if_abap_behv_message=>severity-information
                                           v1 = ls_movimento-matricula )
                      ) TO reported-movimento.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  
  METHOD update.
    DATA(lo_instance) = zcl_movimento=>get_instance( ).
    DATA(lo_disponibilidade_instance) = zcl_disponibilidade=>get_instance( ).
  
    " Lê os dados existentes para todas as entidades que serão atualizadas
    READ ENTITIES OF zi_cs4_movimento IN LOCAL MODE
      ENTITY Movimento
        FIELDS ( IdMovimento )
        WITH CORRESPONDING #( entities )
      RESULT DATA(lt_current_movimento)
      FAILED DATA(lt_failed_read)
      REPORTED DATA(lt_reported_read).
  
    " Processa apenas as entidades que foram lidas com sucesso
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
  
      " Localiza os dados existentes para esta entidade usando o IdMovimento como chave
      READ TABLE lt_current_movimento WITH KEY IdMovimento = <lfs_entity>-IdMovimento
        ASSIGNING FIELD-SYMBOL(<lfs_current>).
  
      IF sy-subrc = 0.
        " Obtém o registro da entidade usando a instância
        DATA(ls_movimento) = lo_instance->get_movimento_record( <lfs_current>-IdMovimento ).
  
        IF ls_movimento IS NOT INITIAL.
          DATA(ls_control) = <lfs_entity>-%control.
  
          " Converter matrícula para maiúsculas se foi modificada
          IF ls_control-Matricula IS NOT INITIAL.
            DATA(lv_matricula) = CONV string( <lfs_entity>-Matricula ).
            TRANSLATE lv_matricula TO UPPER CASE.
  
            " Verificar se o veículo já está no estacionamento com outra entrada
            IF lv_matricula <> ls_movimento-matricula AND ls_movimento-status = 'E'.
              SELECT COUNT(*) FROM zmovimento
                WHERE matricula = @lv_matricula
                  AND status = 'E'
                  AND id_movimento <> @ls_movimento-id_movimento
                INTO @DATA(lv_count).
  
              IF lv_count > 0.
                " Veículo já está no estacionamento, não permitir alterar matrícula
                APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento
                               %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                                  number = '201'
                                                  severity = if_abap_behv_message=>severity-error
                                                  v1 = lv_matricula )
                             ) TO reported-movimento.
                APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento ) TO failed-movimento.
                CONTINUE. " Pular para o próximo registro
              ENDIF.
  
              " Verificar se a matrícula pertence a um cliente registrado
              SELECT SINGLE id_veiculo, id_cliente, id_tipo_veiculo
                FROM zdt_veiculo
                WHERE matricula = @lv_matricula
                INTO @DATA(ls_veiculo).
  
              IF sy-subrc = 0.
                " Se encontrou o veículo, é um cliente registrado - atualizar os dados
                ls_movimento-id_veiculo = ls_veiculo-id_veiculo.
                ls_movimento-id_cliente = ls_veiculo-id_cliente.
                ls_movimento-id_tipo_veiculo = ls_veiculo-id_tipo_veiculo.
  
                " Buscar nome do cliente para mensagem
                SELECT SINGLE nome
                  FROM zdt_cliente
                  WHERE id_cliente = @ls_veiculo-id_cliente
                  INTO @DATA(lv_nome_cliente).
  
                " Adicionar mensagem informativa
                APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento
                               %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                                  number = '107'  " Criar esta mensagem
                                                  severity = if_abap_behv_message=>severity-information
                                                  v1 = lv_nome_cliente
                                                  v2 = ls_veiculo-id_cliente )
                             ) TO reported-movimento.
              ELSE.
                " Se não encontrou, cliente não registrado - limpar dados do cliente
                " Manter o id_tipo_veiculo se foi definido no update
                IF ls_control-IdTipoVeiculo IS INITIAL.
                  " Se tipo de veículo não foi atualizado no request, limpar
                  ls_movimento-id_veiculo = 0.
                  ls_movimento-id_cliente = 0.
                  " Não limpar o tipo de veículo para manter o cálculo correto
                ENDIF.
  
                " Adicionar mensagem informativa
                APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento
                               %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                                  number = '101'
                                                  severity = if_abap_behv_message=>severity-information
                                                  v1 = lv_matricula )
                             ) TO reported-movimento.
              ENDIF.
            ENDIF.
  
            " Atribuir a matrícula convertida para maiúsculas
            ls_movimento-matricula = lv_matricula.
          ENDIF.
  
          " Atualizar outros campos apenas se foram modificados
          IF ls_control-IdVeiculo IS NOT INITIAL.
            ls_movimento-id_veiculo = <lfs_entity>-IdVeiculo.
          ENDIF.
  
          IF ls_control-IdCliente IS NOT INITIAL.
            ls_movimento-id_cliente = <lfs_entity>-IdCliente.
          ENDIF.
  
          IF ls_control-IdTipoVeiculo IS NOT INITIAL.
            " Validar tipo de veículo
            SELECT SINGLE @abap_true
              FROM ztipo_veiculo
              WHERE id_tipo = @<lfs_entity>-IdTipoVeiculo
              INTO @DATA(lv_exists).
  
            IF lv_exists IS INITIAL.
              " Tipo de veículo inválido
              APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento
                             %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                                number = '203'
                                                severity = if_abap_behv_message=>severity-error
                                                v1 = <lfs_entity>-IdTipoVeiculo )
                           ) TO reported-movimento.
              APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento ) TO failed-movimento.
              CONTINUE.
            ENDIF.
  
            " Se o tipo de veículo mudou e o veículo está no estacionamento, verificar disponibilidade
            IF <lfs_entity>-IdTipoVeiculo <> ls_movimento-id_tipo_veiculo AND ls_movimento-status = 'E'.
              DATA(lv_old_tipo) = ls_movimento-id_tipo_veiculo.
              DATA(lv_new_tipo) = <lfs_entity>-IdTipoVeiculo.
  
              " Verificar disponibilidade para o novo tipo
              DATA: ls_disponibilidade TYPE zdisponibilidade,
                    lv_vagas_disponiveis TYPE int4.
  
              SELECT SINGLE * FROM zdisponibilidade INTO @ls_disponibilidade.
              IF sy-subrc = 0.
                " Ajustar ocupação atual
                CASE lv_old_tipo.
                  WHEN 1. " Ligeiro
                    ls_disponibilidade-lugares_ligeiro_ocupados = ls_disponibilidade-lugares_ligeiro_ocupados - 1.
                  WHEN 2. " Motociclo
                    ls_disponibilidade-lugares_moto_ocupados = ls_disponibilidade-lugares_moto_ocupados - 1.
                  WHEN 3. " Pesado
                    ls_disponibilidade-lugares_pesado_ocupados = ls_disponibilidade-lugares_pesado_ocupados - 1.
                ENDCASE.
  
                " Verificar disponibilidade para o novo tipo
                CASE lv_new_tipo.
                  WHEN 1. " Ligeiro
                    lv_vagas_disponiveis = ls_disponibilidade-lugares_ligeiro_total - ls_disponibilidade-lugares_ligeiro_ocupados.
                  WHEN 2. " Motociclo
                    lv_vagas_disponiveis = ls_disponibilidade-lugares_moto_total - ls_disponibilidade-lugares_moto_ocupados.
                  WHEN 3. " Pesado
                    lv_vagas_disponiveis = ls_disponibilidade-lugares_pesado_total - ls_disponibilidade-lugares_pesado_ocupados.
                  WHEN OTHERS.
                    " Tipo inválido - já validado acima
                    lv_vagas_disponiveis = 0.
                ENDCASE.
  
                " Se não houver vagas para o novo tipo, não permitir alteração
                IF lv_vagas_disponiveis <= 0.
                  APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento
                                 %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                                    number = '200'
                                                    severity = if_abap_behv_message=>severity-error
                                                    v1 = lv_new_tipo )
                               ) TO reported-movimento.
                  APPEND VALUE #( IdMovimento = <lfs_entity>-IdMovimento ) TO failed-movimento.
                  CONTINUE.
                ENDIF.
  
                " Atualizar ocupação
                CASE lv_new_tipo.
                  WHEN 1. " Ligeiro
                    ls_disponibilidade-lugares_ligeiro_ocupados = ls_disponibilidade-lugares_ligeiro_ocupados + 1.
                  WHEN 2. " Motociclo
                    ls_disponibilidade-lugares_moto_ocupados = ls_disponibilidade-lugares_moto_ocupados + 1.
                  WHEN 3. " Pesado
                    ls_disponibilidade-lugares_pesado_ocupados = ls_disponibilidade-lugares_pesado_ocupados + 1.
                ENDCASE.
  
                " Atualizar disponibilidade
                lo_disponibilidade_instance->set_update_disponibilidade( ls_disponibilidade ).
              ENDIF.
            ENDIF.
  
            ls_movimento-id_tipo_veiculo = <lfs_entity>-IdTipoVeiculo.
          ENDIF.
  
          IF ls_control-DataEntrada IS NOT INITIAL.
            ls_movimento-data_entrada = <lfs_entity>-DataEntrada.
          ENDIF.
  
          IF ls_control-DataSaida IS NOT INITIAL.
            ls_movimento-data_saida = <lfs_entity>-DataSaida.
          ENDIF.
  
          IF ls_control-DuracaoHoras IS NOT INITIAL.
            ls_movimento-duracao_horas = <lfs_entity>-DuracaoHoras.
          ENDIF.
  
          IF ls_control-ValorBruto IS NOT INITIAL.
            ls_movimento-valor_bruto = <lfs_entity>-ValorBruto.
          ENDIF.
  
          IF ls_control-Desconto IS NOT INITIAL.
            ls_movimento-desconto = <lfs_entity>-Desconto.
          ENDIF.
  
          IF ls_control-ValorLiquido IS NOT INITIAL.
            ls_movimento-valor_liquido = <lfs_entity>-ValorLiquido.
          ENDIF.
  
          IF ls_control-Moeda IS NOT INITIAL.
            ls_movimento-moeda = <lfs_entity>-Moeda.
          ENDIF.
  
          IF ls_control-Status IS NOT INITIAL.
            ls_movimento-status = <lfs_entity>-Status.
          ENDIF.
  
          " Garantir que a moeda esteja definida para evitar problemas
          IF ls_movimento-moeda IS INITIAL.
            ls_movimento-moeda = 'EUR'. " ou a moeda padrão do seu sistema
          ENDIF.
  
          " Atualizar campos de auditoria
          ls_movimento-local_last_changed_by = sy-uname.
          GET TIME STAMP FIELD ls_movimento-last_changed_at.
  
          " Adicionar ao buffer de atualização
          lo_instance->set_update_movimento( ls_movimento ).
        ENDIF.
      ENDIF.
    ENDLOOP.
  
  ENDMETHOD.
  
    METHOD delete.
      " Implementação mantida igual
      DATA(lo_disponibilidade_instance) = zcl_disponibilidade=>get_instance( ).
      DATA(lo_instance) = zcl_movimento=>get_instance( ).
      DATA ls_movimento TYPE zmovimento.
      READ ENTITIES OF zi_cs4_movimento IN LOCAL MODE
        ENTITY Movimento
          ALL FIELDS
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_movimentos).
      IF lt_movimentos IS INITIAL.
        RETURN.
      ENDIF.
      LOOP AT lt_movimentos ASSIGNING FIELD-SYMBOL(<lfs_movimento>).
        CLEAR ls_movimento.
        ls_movimento-client = sy-mandt.
        ls_movimento-id_movimento = <lfs_movimento>-IdMovimento.
        " Verificar se está com status 'E' (entrada) e atualizar disponibilidade
        IF <lfs_movimento>-Status = 'E'.
          " Atualizar disponibilidade, decrementando ocupação
          DATA: ls_disponibilidade TYPE zdisponibilidade.
          SELECT SINGLE * FROM zdisponibilidade INTO @ls_disponibilidade.
          IF sy-subrc = 0.
            " Decrementar ocupação conforme tipo de veículo
            CASE <lfs_movimento>-IdTipoVeiculo.
              WHEN 1. " Ligeiro
                ls_disponibilidade-lugares_ligeiro_ocupados = ls_disponibilidade-lugares_ligeiro_ocupados - 1.
              WHEN 2. " Motociclo
                ls_disponibilidade-lugares_moto_ocupados = ls_disponibilidade-lugares_moto_ocupados - 1.
              WHEN 3. " Pesado
                ls_disponibilidade-lugares_pesado_ocupados = ls_disponibilidade-lugares_pesado_ocupados - 1.
            ENDCASE.
            " Atualizar ocupação
            lo_disponibilidade_instance->set_update_disponibilidade( ls_disponibilidade ).
          ENDIF.
        ENDIF.
        " Adicionar ao buffer de exclusão
        lo_instance->set_delete_movimento( ls_movimento ).
      ENDLOOP.
  
      " Não popule o parâmetro mapped - mesmo princípio do update
    ENDMETHOD.
  
    METHOD read.
      " Ler diretamente da tabela
      SELECT * FROM zmovimento
        FOR ALL ENTRIES IN @keys
        WHERE id_movimento = @keys-IdMovimento
        INTO TABLE @DATA(lt_movimentos).
  
      " Mapear resultados para a entidade
      result = CORRESPONDING #( lt_movimentos MAPPING
                               IdMovimento     = id_movimento
                               IdVeiculo       = id_veiculo
                               Matricula       = matricula
                               IdCliente       = id_cliente
                               IdTipoVeiculo   = id_tipo_veiculo
                               DataEntrada     = data_entrada
                               DataSaida       = data_saida
                               DuracaoHoras    = duracao_horas
                               ValorBruto      = valor_bruto
                               Desconto        = desconto
                               ValorLiquido    = valor_liquido
                               Moeda           = moeda
                               Status          = status
                               CreatedBy       = local_created_by
                               CreatedAt       = local_created_at
                               LastChangedBy   = local_last_changed_by
                               LastChangedAt   = last_changed_at ).
    ENDMETHOD.
  
    METHOD lock.
    ENDMETHOD.
  
    METHOD registrarSaida.
      " Implementação mantida igual ao original
      DATA ls_movimento TYPE zmovimento.
      DATA ls_disponibilidade TYPE zdisponibilidade.
      DATA(lo_movimento_instance) = zcl_movimento=>get_instance( ).
      DATA(lo_disponibilidade_instance) = zcl_disponibilidade=>get_instance( ).
      LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
        " Obter registro atual
        SELECT SINGLE * FROM zmovimento
          WHERE id_movimento = @<key>-IdMovimento
          INTO @ls_movimento.
        IF sy-subrc = 0 AND ls_movimento-status <> 'S'.
          " Verificar se a data de entrada existe
          IF ls_movimento-data_entrada IS INITIAL.
            " Não é possível registrar saída sem data de entrada
            APPEND VALUE #( %tky = <key>-%tky
                           %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                              number = '105'
                                              severity = if_abap_behv_message=>severity-error
                                              v1 = ls_movimento-matricula )
                         ) TO reported-movimento.
            APPEND VALUE #( %tky = <key>-%tky ) TO failed-movimento.
            CONTINUE.
          ENDIF.
  
          ls_movimento-status = 'S'.
          GET TIME STAMP FIELD ls_movimento-data_saida.
  
          DATA: lv_entrada_ts      TYPE timestampl,
                lv_saida_ts        TYPE timestampl,
                lv_diff_seconds    TYPE int8,
                lv_duracao_horas   TYPE p LENGTH 10 DECIMALS 2,
                lv_entrada_date    TYPE d,
                lv_entrada_time    TYPE t,
                lv_saida_date      TYPE d,
                lv_saida_time      TYPE t.
          " Converter timestamps para data e hora
          CONVERT TIME STAMP ls_movimento-data_entrada TIME ZONE sy-zonlo
            INTO DATE lv_entrada_date TIME lv_entrada_time.
          CONVERT TIME STAMP ls_movimento-data_saida TIME ZONE sy-zonlo
            INTO DATE lv_saida_date TIME lv_saida_time.
          " Calcular diferença em segundos
          DATA: lv_entrada_segundos TYPE int8,
                lv_saida_segundos   TYPE int8.
          " Converter datas para segundos (dias * 86400)
          lv_entrada_segundos = lv_entrada_date * 86400.
          lv_saida_segundos = lv_saida_date * 86400.
          " Adicionar segundos do horário (horas * 3600 + minutos * 60 + segundos)
          lv_entrada_segundos = lv_entrada_segundos +
                               ( lv_entrada_time(2) * 3600 ) +
                               ( lv_entrada_time+2(2) * 60 ) +
                               lv_entrada_time+4(2).
          lv_saida_segundos = lv_saida_segundos +
                             ( lv_saida_time(2) * 3600 ) +
                             ( lv_saida_time+2(2) * 60 ) +
                             lv_saida_time+4(2).
          " Calcular a diferença em segundos
          lv_diff_seconds = lv_saida_segundos - lv_entrada_segundos.
          " Converter segundos para horas com duas casas decimais
          lv_duracao_horas = lv_diff_seconds / 3600.
          " Para evitar valores muito pequenos, definir um mínimo
          " 8 minutos = 480 segundos = 0.13 horas
          IF lv_diff_seconds < 480 AND lv_diff_seconds > 0.
            " Cobrar no mínimo por 15 minutos (0.25 horas)
            lv_duracao_horas = '0.25'.
          ENDIF.
          ls_movimento-duracao_horas = lv_duracao_horas.
          " Buscar preço por hora para o tipo de veículo
          SELECT SINGLE preco_hora, moeda
            FROM ztipo_veiculo
            WHERE id_tipo = @ls_movimento-id_tipo_veiculo
            INTO (@DATA(lv_preco_hora), @DATA(lv_moeda)).
          IF sy-subrc = 0.
            " Calcular valor bruto
            ls_movimento-valor_bruto = ls_movimento-duracao_horas * lv_preco_hora.
            ls_movimento-moeda = lv_moeda.
            " Verificar se é cliente e aplicar desconto conforme tipo
            IF ls_movimento-id_cliente IS NOT INITIAL.
              SELECT SINGLE c~id_tipo_cliente, t~desconto_ligeiro, t~desconto_moto, t~desconto_pesado
                FROM zdt_cliente AS c
                INNER JOIN ztipo_cliente AS t
                ON c~id_tipo_cliente = t~id_tipo
                WHERE c~id_cliente = @ls_movimento-id_cliente
                INTO (@DATA(lv_tipo_cliente), @DATA(lv_desconto_ligeiro),
                      @DATA(lv_desconto_moto), @DATA(lv_desconto_pesado)).
              IF sy-subrc = 0.
                " Aplicar desconto conforme tipo de veículo
                CASE ls_movimento-id_tipo_veiculo.
                  WHEN 1. " Ligeiro
                    ls_movimento-desconto = lv_desconto_ligeiro.
                  WHEN 2. " Motociclo
                    ls_movimento-desconto = lv_desconto_moto.
                  WHEN 3. " Pesado
                    ls_movimento-desconto = lv_desconto_pesado.
                ENDCASE.
                " Calcular valor líquido aplicando desconto
                ls_movimento-valor_liquido = ls_movimento-valor_bruto -
                                            ( ls_movimento-valor_bruto * ls_movimento-desconto / 100 ).
              ELSE.
                " Sem desconto
                ls_movimento-desconto = 0.
                ls_movimento-valor_liquido = ls_movimento-valor_bruto.
              ENDIF.
            ELSE.
              " Não é cliente, não tem desconto
              ls_movimento-desconto = 0.
              ls_movimento-valor_liquido = ls_movimento-valor_bruto.
            ENDIF.
            " Atualizar disponibilidade ao sair
            SELECT SINGLE * FROM zdisponibilidade INTO @ls_disponibilidade.
            IF sy-subrc = 0.
              " Decrementar ocupação
              CASE ls_movimento-id_tipo_veiculo.
                WHEN 1. " Ligeiro
                  ls_disponibilidade-lugares_ligeiro_ocupados = ls_disponibilidade-lugares_ligeiro_ocupados - 1.
                WHEN 2. " Motociclo
                  ls_disponibilidade-lugares_moto_ocupados = ls_disponibilidade-lugares_moto_ocupados - 1.
                WHEN 3. " Pesado
                  ls_disponibilidade-lugares_pesado_ocupados = ls_disponibilidade-lugares_pesado_ocupados - 1.
              ENDCASE.
              " Atualizar disponibilidade usando o buffer
              lo_disponibilidade_instance->set_update_disponibilidade( ls_disponibilidade ).
            ENDIF.
          ENDIF.
          " Atualizar campos de auditoria
          ls_movimento-local_last_changed_by = sy-uname.
          GET TIME STAMP FIELD ls_movimento-last_changed_at.
          " Adicionar ao buffer de atualização
          lo_movimento_instance->set_update_movimento( ls_movimento ).
  
          " Mensagem de sucesso
          APPEND VALUE #( %tky = <key>-%tky
                          %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                             number = '102'
                                             severity = if_abap_behv_message=>severity-success
                                             v1 = ls_movimento-matricula
                                             v2 = ls_movimento-valor_liquido
                                             v3 = ls_movimento-moeda )
                        ) TO reported-movimento.
        ELSEIF ls_movimento-status = 'S'.
          " Já está com status de saída
          APPEND VALUE #( %tky = <key>-%tky
                         %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                            number = '103'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = ls_movimento-matricula )
                       ) TO reported-movimento.
          APPEND VALUE #( %tky = <key>-%tky ) TO failed-movimento.
        ELSE.
          " Movimento não encontrado
          APPEND VALUE #( %tky = <key>-%tky
                         %msg = new_message( id = 'ZCS4_MOVIMENTO'
                                            number = '104'
                                            severity = if_abap_behv_message=>severity-error
                                            v1 = <key>-IdMovimento )
                       ) TO reported-movimento.
          APPEND VALUE #( %tky = <key>-%tky ) TO failed-movimento.
        ENDIF.
      ENDLOOP.
  
      " Ler os registros atualizados para o resultado
      READ ENTITIES OF ZI_CS4_Movimento IN LOCAL MODE
        ENTITY Movimento
          ALL FIELDS
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_movimentos).
  
      " Cuidado especial com o result para evitar shortdump
      " Apenas incluir no result chaves que foram enviadas no request original
      LOOP AT lt_movimentos ASSIGNING FIELD-SYMBOL(<ls_movimento_result>).
        READ TABLE keys WITH KEY IdMovimento = <ls_movimento_result>-IdMovimento
          ASSIGNING FIELD-SYMBOL(<ls_key>).
        IF sy-subrc = 0.
          APPEND VALUE #( %tky = <ls_key>-%tky
                         %param = <ls_movimento_result> ) TO result.
        ENDIF.
      ENDLOOP.
    ENDMETHOD.
  
    METHOD get_instance_authorizations.
    ENDMETHOD.
  ENDCLASS.