@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_CS4_Veiculo
  as projection on ZI_CS4_Veiculo
{
  @Search.defaultSearchElement: true
  key IdVeiculo,
  @Search.defaultSearchElement: true
  Matricula,
  @Search.defaultSearchElement: true
  Marca,
  @Search.defaultSearchElement: true
  Modelo,
  @ObjectModel.text.element: ['TipoVeiculoDescricao']
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_CS4_TipoVeiculo', element: 'IdTipo' },
    additionalBinding: [{ localElement: 'TipoVeiculoDescricao', element: 'Descricao' }]
  }]
  @UI.textArrangement: #TEXT_FIRST
  IdTipoVeiculo,
  TipoVeiculoDescricao,
  @ObjectModel.text.element: ['ClienteNome']
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_CS4_Cliente', element: 'IdCliente' },
    additionalBinding: [{ localElement: 'ClienteNome', element: 'Nome' }]
  }]
  @UI.textArrangement: #TEXT_FIRST
  IdCliente,
  _Cliente.Nome as ClienteNome,
  Eletrico,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  /* Associations */
  _Cliente : redirected to parent ZC_CS4_Cliente,
  _TipoVeiculo
}
