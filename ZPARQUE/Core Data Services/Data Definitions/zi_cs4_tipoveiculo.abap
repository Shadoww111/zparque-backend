@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_CS4_TipoVeiculo
  as select from ztipo_veiculo
{
   @EndUserText.label: 'ID Tipo Veículo'
  key id_tipo as IdTipo,
  
  @EndUserText.label: 'Descrição'
  descricao as Descricao,
  
  @EndUserText.label: 'Preço por Hora'
    @Semantics.amount.currencyCode: 'Moeda'
  
  preco_hora as PrecoHora,
  
  @EndUserText.label: 'Moeda'
  moeda as Moeda,
  
  @Semantics.user.createdBy: true
  @EndUserText.label: 'Criado Por'
  local_created_by as CreatedBy,
  
  @Semantics.systemDateTime.createdAt: true
  @EndUserText.label: 'Criado Em'
  local_created_at as CreatedAt,
  
  @Semantics.user.lastChangedBy: true
  @EndUserText.label: 'Alterado Por'
  local_last_changed_by as LastChangedBy,
  
  @Semantics.systemDateTime.lastChangedAt: true
  @EndUserText.label: 'Alterado Em'
  last_changed_at as LastChangedAt
}
