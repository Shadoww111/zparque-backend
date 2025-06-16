@EndUserText.label: 'Consumption View for Tipo Cliente'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_CS4_TipoCliente 
  as projection on ZI_CS4_TipoCliente
{
  @ObjectModel.text.element: ['Descricao']
  key IdTipo,
  @Search.defaultSearchElement: true
  Descricao,
  DescontoLigeiro,
  DescontoMoto,
  DescontoPesado,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt
}
