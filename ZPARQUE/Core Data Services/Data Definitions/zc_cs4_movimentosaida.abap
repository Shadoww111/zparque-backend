@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumo para Saída de Veículos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_CS4_MovimentoSaida
  as projection on ZI_CS4_Movimento
{
  @EndUserText.label: 'ID Movimento'
  key IdMovimento,
  @EndUserText.label: 'ID Veículo'
  IdVeiculo,
  @EndUserText.label: 'Matrícula'
  @Search.defaultSearchElement: true
  Matricula,
  @EndUserText.label: 'ID Cliente'
  IdCliente,
  @EndUserText.label: 'Nome do Cliente'
  _Cliente.Nome as ClienteNome,
  @EndUserText.label: 'Tipo de Veículo'
  @ObjectModel.text.element: ['TipoVeiculoDesc']
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_CS4_TipoVeiculo', element: 'IdTipo' },
    additionalBinding: [{ localElement: 'TipoVeiculoDesc', element: 'Descricao' }]
  }]
  @UI.textArrangement: #TEXT_FIRST
  IdTipoVeiculo,
  @EndUserText.label: 'Descrição do Tipo'
  _TipoVeiculo.Descricao as TipoVeiculoDesc,
  @EndUserText.label: 'Data de Entrada'
  DataEntrada,
  @EndUserText.label: 'Data de Saída'
  DataSaida,
  @EndUserText.label: 'Duração (Horas)'
  DuracaoHoras,
  @EndUserText.label: 'Valor Bruto'
  @Semantics.amount.currencyCode: 'Moeda'
  ValorBruto,
  @EndUserText.label: 'Desconto (%)'
  Desconto,
  @EndUserText.label: 'Valor Líquido'
  @Semantics.amount.currencyCode: 'Moeda'
  ValorLiquido,
  @EndUserText.label: 'Moeda'
  Moeda,
  @EndUserText.label: 'Status'
  Status,
  @EndUserText.label: 'Criado Por'
  CreatedBy,
  @EndUserText.label: 'Criado Em'
  CreatedAt,
  @EndUserText.label: 'Alterado Por'
  LastChangedBy,
  @EndUserText.label: 'Alterado Em'
  LastChangedAt,
  /* Associations */
  _Cliente,
  _Veiculo,
  _TipoVeiculo
}
