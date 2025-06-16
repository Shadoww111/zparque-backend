@EndUserText.label : 'tabela'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdt_cliente {

  key client            : abap.clnt not null;
  key id_cliente        : abap.int4 not null;
  nome                  : abap.char(100);
  nif                   : abap.char(20);
  email                 : abap.char(100);
  telefone              : abap.char(20);
  id_tipo_cliente       : abap.int4 not null;
  local_created_by      : abp_creation_user;
  local_created_at      : abp_creation_tstmpl;
  local_last_changed_by : abp_locinst_lastchange_user;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;
  last_changed_at       : abp_locinst_lastchange_tstmpl;

}