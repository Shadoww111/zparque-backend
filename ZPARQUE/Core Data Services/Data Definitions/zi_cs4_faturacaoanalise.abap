@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Análise de Faturação'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CS4_FaturacaoAnalise
  as select from zmovimento as Movimento
  association [0..1] to ZI_CS4_Cliente as _Cliente on $projection.IdCliente = _Cliente.IdCliente
  association [0..1] to ZI_CS4_TipoVeiculo as _TipoVeiculo on $projection.IdTipoVeiculo = _TipoVeiculo.IdTipo
{
  key id_movimento as IdMovimento,
  id_cliente as IdCliente,
  _Cliente.Nome as ClienteNome,
  id_tipo_veiculo as IdTipoVeiculo,
  _TipoVeiculo.Descricao as TipoVeiculoDesc,
  matricula as Matricula,
  status as Status,
  
  // Dados de data e hora
  data_entrada as DataEntrada,
  data_saida as DataSaida,
  duracao_horas as DuracaoHoras,
  
  // Extração de componentes de data para agrupamento
  left(cast(data_entrada as abap.char(30)), 4) as Ano,
  substring(cast(data_entrada as abap.char(30)), 5, 2) as Mes,
  substring(cast(data_entrada as abap.char(30)), 7, 2) as Dia,
  
  // Mês e ano para agrupamento (formato YYYY-MM)
  concat(left(cast(data_entrada as abap.char(30)), 4),
         concat('-', substring(cast(data_entrada as abap.char(30)), 5, 2))) as MesAno,
  
  // Semana do ano
  case
    when cast(substring(cast(data_entrada as abap.char(30)), 7, 2) as abap.int4) <= 7 then 1
    when cast(substring(cast(data_entrada as abap.char(30)), 7, 2) as abap.int4) <= 14 then 2
    when cast(substring(cast(data_entrada as abap.char(30)), 7, 2) as abap.int4) <= 21 then 3
    else 4
  end as SemanaDoMes,
  
  // Trimestre
  case
    when substring(cast(data_entrada as abap.char(30)), 5, 2) <= '03' then '1'
    when substring(cast(data_entrada as abap.char(30)), 5, 2) <= '06' then '2'
    when substring(cast(data_entrada as abap.char(30)), 5, 2) <= '09' then '3'
    else '4'
  end as Trimestre,
  
  // Dados financeiros
  @Semantics.amount.currencyCode: 'Moeda'
  valor_bruto as ValorBruto,
  desconto as Desconto,
  @Semantics.amount.currencyCode: 'Moeda'
  valor_liquido as ValorLiquido,
  moeda as Moeda,
  
  // Associações
  _Cliente,
  _TipoVeiculo
}
where 
  // Apenas movimentos concluídos (com status 'S' - Saída)
  status = 'S'
