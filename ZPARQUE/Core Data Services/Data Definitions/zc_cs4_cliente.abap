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
define root view entity ZC_CS4_Cliente 
  as projection on ZI_CS4_Cliente
{
 @Search.defaultSearchElement: true
  key IdCliente,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  Nome,
  
  @Search.defaultSearchElement: true
  Nif,
  
  Email,
  
  Telefone,
  
  @ObjectModel.text.element: ['TipoClienteDescricao']
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_CS4_TipoCliente', element: 'IdTipo' },
    additionalBinding: [{ localElement: 'TipoClienteDescricao', element: 'Descricao' }]
  }]
  @UI.textArrangement: #TEXT_FIRST
  IdTipoCliente,
  
  TipoClienteDescricao,
  
  
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  
  /* Associations */
  _TipoCliente,
  _Veiculos : redirected to composition child ZC_CS4_Veiculo
}
