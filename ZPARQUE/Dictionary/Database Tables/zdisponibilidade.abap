@EndUserText.label : 'tabela'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdisponibilidade {

  key client               : abap.clnt not null;
  key id_dispo             : abap.int4 not null;
  lugares_moto_total       : abap.int4;
  lugares_moto_ocupados    : abap.int4;
  lugares_ligeiro_total    : abap.int4;
  lugares_ligeiro_ocupados : abap.int4;
  lugares_pesado_total     : abap.int4;
  lugares_pesado_ocupados  : abap.int4;
  local_created_by         : abp_creation_user;
  local_created_at         : abp_creation_tstmpl;
  local_last_changed_by    : abp_locinst_lastchange_user;
  local_last_changed_at    : abp_locinst_lastchange_tstmpl;
  last_changed_at          : abp_locinst_lastchange_tstmpl;

}