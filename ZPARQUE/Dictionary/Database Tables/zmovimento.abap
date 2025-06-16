@EndUserText.label : 'tabela'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zmovimento {

  key client            : abap.clnt not null;
  key id_movimento      : abap.int4 not null;
  id_veiculo            : abap.int4;
  matricula             : abap.char(20);
  id_cliente            : abap.int4;
  id_tipo_veiculo       : abap.int4 not null;
  data_entrada          : timestampl;
  data_saida            : timestampl;
  duracao_horas         : abap.dec(10,2);
  @Semantics.amount.currencyCode : 'zmovimento.moeda'
  valor_bruto           : abap.curr(10,2);
  desconto              : abap.dec(5,2);
  @Semantics.amount.currencyCode : 'zmovimento.moeda'
  valor_liquido         : abap.curr(10,2);
  moeda                 : abap.cuky;
  status                : abap.char(1);
  local_created_by      : abp_creation_user;
  local_created_at      : abp_creation_tstmpl;
  local_last_changed_by : abp_locinst_lastchange_user;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;
  last_changed_at       : abp_locinst_lastchange_tstmpl;

}