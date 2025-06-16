@EndUserText.label: 'Consumption View for Tipo Veiculo'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_CS4_TipoVeiculo 
  as projection on ZI_CS4_TipoVeiculo
{
  @ObjectModel.text.element: ['Descricao']
  @Search.defaultSearchElement: true
  key IdTipo,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  Descricao,
  
  @Semantics.amount.currencyCode: 'Moeda'
  PrecoHora,
  
  Moeda,
  
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt
}
