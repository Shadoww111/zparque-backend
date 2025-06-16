@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_CS4_Movimento
  as select from zmovimento as Movimento
  association [0..1] to ZI_CS4_Cliente as _Cliente on $projection.IdCliente = _Cliente.IdCliente
  association [0..1] to ZI_CS4_Veiculo as _Veiculo on $projection.IdVeiculo = _Veiculo.IdVeiculo
  association [1..1] to ZI_CS4_TipoVeiculo as _TipoVeiculo on $projection.IdTipoVeiculo = _TipoVeiculo.IdTipo
{
  key Movimento.id_movimento as IdMovimento,
  Movimento.id_veiculo as IdVeiculo,
  Movimento.matricula as Matricula,
  Movimento.id_cliente as IdCliente,
  Movimento.id_tipo_veiculo as IdTipoVeiculo,
  Movimento.data_entrada as DataEntrada,
  Movimento.data_saida as DataSaida,
  Movimento.duracao_horas as DuracaoHoras,
  @Semantics.amount.currencyCode: 'Moeda'
  Movimento.valor_bruto as ValorBruto,
  Movimento.desconto as Desconto,
  @Semantics.amount.currencyCode: 'Moeda'
  Movimento.valor_liquido as ValorLiquido,
  Movimento.moeda as Moeda,
  Movimento.status as Status,
  @Semantics.user.createdBy: true
  Movimento.local_created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  Movimento.local_created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  Movimento.local_last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  Movimento.last_changed_at as LastChangedAt,
  
  _Cliente,
  _Veiculo,
  _TipoVeiculo
}
