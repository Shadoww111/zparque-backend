@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View para Tipo de Cliente'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_CS4_TipoCliente
  as select from ztipo_cliente
{
 @ObjectModel.text.element: ['Descricao']
  @Search.defaultSearchElement: true
  key id_tipo as IdTipo,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  descricao as Descricao,
  
  desconto_ligeiro as DescontoLigeiro,
  desconto_moto as DescontoMoto,
  desconto_pesado as DescontoPesado,
@Semantics.user.createdBy: true  
local_created_by as CreatedBy,  
@Semantics.systemDateTime.createdAt: true  
local_created_at as CreatedAt,  
@Semantics.user.lastChangedBy: true  
local_last_changed_by as LastChangedBy,  
@Semantics.systemDateTime.lastChangedAt: true  
last_changed_at as LastChangedAt
}
