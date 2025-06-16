@EndUserText.label: 'OData Service for CS4 Parking'
define service ZUI_CS4_PARKING {
  expose ZC_CS4_Cliente          as Cliente;
  expose ZC_CS4_Veiculo          as Veiculo;
  expose ZC_CS4_TipoVeiculo      as TipoVeiculo;
  expose ZC_CS4_TipoCliente      as TipoCliente;
  expose ZC_CS4_MovimentoEntrada as Entrada;
  expose ZC_CS4_MovimentoSaida   as Saida;
  expose ZC_CS4_Disponibilidade  as Disponibilidade;
  expose ZC_CS4_FaturacaoAnalise as FaturacaoAnalise;
  expose ZC_CS4_ClientePortal    as ClientePortal;
  expose ZC_CS4_VeiculoPortal    as VeiculoPortal;
  expose ZC_CS4_MovimentoCliente as MovimentoCliente;
}