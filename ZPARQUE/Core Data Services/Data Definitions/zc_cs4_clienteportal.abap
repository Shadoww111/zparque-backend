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
define root view entity ZC_CS4_ClientePortal 
  as projection on ZI_CS4_Cliente
{
  key IdCliente,
  Nome,
  Nif,
  Email,
  Telefone,
  _TipoCliente.Descricao as TipoClienteDesc,
  
  /* Associations */
  _Veiculos : redirected to composition child ZC_CS4_VeiculoPortal
}
