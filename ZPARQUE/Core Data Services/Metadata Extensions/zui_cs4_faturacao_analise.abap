@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Análise de Faturação', 
    typeNamePlural: 'Análise de Faturação',
    title: { type: #STANDARD, value: 'IdMovimento' },
    description: { type: #STANDARD, value: 'ClienteNome' }
  },
  presentationVariant: [{
    sortOrder: [{ by: 'DataEntrada', direction: #DESC }],
    visualizations: [{ type: #AS_LINEITEM }]
  }]
}
annotate view ZC_CS4_FaturacaoAnalise with {
  @UI.facet: [
    { 
      id: 'HeaderFacet', 
      purpose: #HEADER, 
      type: #DATAPOINT_REFERENCE, 
      targetQualifier: 'ValorTotal', 
      position: 5 
    },
    { 
      id: 'FaturacaoDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Análise de Faturação', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'FaturacaoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados do Movimento', 
      position: 10, 
      targetQualifier: 'BasicData' 
    },
    { 
      id: 'PeriodoData', 
      parentId: 'FaturacaoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Informações de Período', 
      position: 20, 
      targetQualifier: 'PeriodoData' 
    },
    { 
      id: 'ValorData', 
      parentId: 'FaturacaoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Valores Financeiros', 
      position: 30, 
      targetQualifier: 'ValorData' 
    }
  ]

  @UI: {
    lineItem: [{ position: 10, importance: #HIGH, label: 'ID do Movimento' }],
    identification: [{ position: 10, label: 'ID do Movimento' }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 10, label: 'ID do Movimento' }]
  IdMovimento;

  @UI: {
    lineItem: [{ position: 20, importance: #HIGH, label: 'Matrícula', semanticObjectAction: 'display' }],
    identification: [{ position: 20, label: 'Matrícula' }],
    selectionField: [{ position: 20 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 20, label: 'Matrícula' }]
  Matricula;

  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM, label: 'Nome do Cliente' }],
    identification: [{ position: 30, label: 'Nome do Cliente' }],
    selectionField: [{ position: 30 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 30, label: 'Nome do Cliente' }]
  ClienteNome;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM, label: 'Tipo de Veículo' }],
    identification: [{ position: 40, label: 'Tipo de Veículo' }],
    selectionField: [{ position: 40 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40, label: 'Tipo de Veículo' }]
  TipoVeiculoDesc;

  @UI: {
    lineItem: [{ position: 50, importance: #HIGH, label: 'Data de Entrada' }],
    identification: [{ position: 50, label: 'Data de Entrada' }],
    selectionField: [{ position: 50 }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 10, label: 'Data de Entrada' }]
  DataEntrada;

  @UI: {
    lineItem: [{ position: 60, importance: #HIGH, label: 'Data de Saída' }],
    identification: [{ position: 60, label: 'Data de Saída' }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 20, label: 'Data de Saída' }]
  DataSaida;

  @UI: {
    lineItem: [{ position: 70, importance: #MEDIUM, label: 'Duração (horas)' }],
    identification: [{ position: 70, label: 'Duração (horas)' }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 30, label: 'Duração (horas)' }]
  DuracaoHoras;

  @UI: {
    lineItem: [{ position: 80, importance: #MEDIUM, label: 'Mês/Ano' }],
    identification: [{ position: 80, label: 'Mês/Ano' }],
    selectionField: [{ position: 60}]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 40, label: 'Mês/Ano' }]
  MesAno;

  @UI: {
    selectionField: [{ position: 70 }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 50, label: 'Ano' }]
  Ano;

  @UI: {
    selectionField: [{ position: 80 }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 60, label: 'Mês' }]
  Mes;

  @UI: {
    selectionField: [{ position: 90 }]
  }
  @UI.fieldGroup: [{ qualifier: 'PeriodoData', position: 70, label: 'Trimestre' }]
  Trimestre;

  @UI: {
    lineItem: [{ position: 90, importance: #MEDIUM, label: 'Valor Bruto (€)' }],
    identification: [{ position: 90, label: 'Valor Bruto (€)' }]
  }
  @UI.dataPoint: { title: 'Valor Bruto', targetValueElement: 'ValorBruto' }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 10, label: 'Valor Bruto (€)' }]
  ValorBruto;

  @UI: {
    lineItem: [{ position: 100, importance: #MEDIUM, label: 'Desconto (%)', criticality: 'DescontoCriticality' }],
    identification: [{ position: 100, label: 'Desconto (%)' }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 20, label: 'Desconto (%)' }]
  Desconto;

  @UI: {
    lineItem: [{ position: 110, importance: #HIGH, label: 'Valor Líquido (€)', criticality: 'ValorCriticality' }],
    identification: [{ position: 110, label: 'Valor Líquido (€)' }]
  }
  @UI.dataPoint: { title: 'Valor Líquido', qualifier: 'ValorTotal', criticality: 'ValorCriticality' }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 30, label: 'Valor Líquido (€)' }]
  ValorLiquido;

  @UI: {
    lineItem: [{ position: 120, importance: #MEDIUM, label: 'Moeda' }],
    identification: [{ position: 120, label: 'Moeda' }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 40, label: 'Moeda' }]
  Moeda;
  
  
  
  @UI.hidden: true
  ValorCriticality;
  
  @UI.hidden: true
  DescontoCriticality;
}