@EndUserText.label : 'tabela'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdt_veiculo {

  key client            : abap.clnt not null;
  key id_veiculo        : abap.int4 not null;
  matricula             : abap.char(20) not null;
  marca                 : abap.char(50);
  modelo                : abap.char(50);
  id_tipo_veiculo       : abap.int4 not null;
  id_cliente            : abap.int4 not null;
  eletrico              : abap.char(1);
  local_created_by      : abp_creation_user;
  local_created_at      : abp_creation_tstmpl;
  local_last_changed_by : abp_locinst_lastchange_user;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;
  last_changed_at       : abp_locinst_lastchange_tstmpl;

}