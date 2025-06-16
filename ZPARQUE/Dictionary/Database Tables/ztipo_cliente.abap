@EndUserText.label : 'tabela'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table ztipo_cliente {

  key client            : abap.clnt not null;
  key id_tipo           : abap.int4 not null;
  descricao             : abap.char(50);
  desconto_ligeiro      : abap.dec(5,2);
  desconto_moto         : abap.dec(5,2);
  desconto_pesado       : abap.dec(5,2);
  local_created_by      : abp_creation_user;
  local_created_at      : abp_creation_tstmpl;
  local_last_changed_by : abp_locinst_lastchange_user;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;
  last_changed_at       : abp_locinst_lastchange_tstmpl;

}