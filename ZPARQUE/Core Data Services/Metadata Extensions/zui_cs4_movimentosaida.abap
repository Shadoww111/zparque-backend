@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Saída',
    typeNamePlural: 'Saídas',
    title: { type: #STANDARD, value: 'Matricula' },
    description: { type: #STANDARD, value: 'IdMovimento' }
  }
}
annotate view ZC_CS4_MovimentoSaida with {
  @UI.facet: [
    {
      id: 'SaidaDetails',
      purpose: #STANDARD,
      type: #COLLECTION,
      label: 'Saída',
      position: 10
    },
    {
      id: 'EntradaData',
      parentId: 'SaidaDetails',
      purpose: #STANDARD,
      type: #FIELDGROUP_REFERENCE,
      label: 'Dados da Entrada',
      position: 10,
      targetQualifier: 'EntradaData'
    },
    {
      id: 'SaidaData',
      parentId: 'SaidaDetails',
      purpose: #STANDARD,
      type: #FIELDGROUP_REFERENCE,
      label: 'Dados da Saída',
      position: 20,
      targetQualifier: 'SaidaData'
    },
    {
      id: 'ValorData',
      parentId: 'SaidaDetails',
      purpose: #STANDARD,
      type: #FIELDGROUP_REFERENCE,
      label: 'Valor',
      position: 30,
      targetQualifier: 'ValorData'
    }
  ]
  @UI: {
    lineItem: [{ position: 10, importance: #HIGH }],
    identification: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 10 }]
  IdMovimento;
  @UI: {
    lineItem: [{ position: 20, importance: #HIGH }],
    identification: [{ position: 20 }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 20 }]
  Matricula;
  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM }],
    identification: [{ position: 30 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 30 }]
  IdCliente;
  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM }],
    identification: [{ position: 40 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 40 }]
  ClienteNome;
  @UI: {
    lineItem: [{ position: 50, importance: #MEDIUM }],
    identification: [{ position: 50 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 50 }]
  IdTipoVeiculo;
  @UI: {
    lineItem: [{ position: 60, importance: #MEDIUM }],
    identification: [{ position: 60 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 60 }]
  TipoVeiculoDesc;
  @UI: {
    lineItem: [{ position: 70, importance: #HIGH }],
    identification: [{ position: 70 }]
  }
  @UI.fieldGroup: [{ qualifier: 'EntradaData', position: 70 }]
  DataEntrada;

  @UI: {
    lineItem: [{ position: 90, importance: #MEDIUM }],
    identification: [{ position: 90 }]
  }
  @UI.fieldGroup: [{ qualifier: 'SaidaData', position: 20 }]
  DuracaoHoras;
  @UI: {
    lineItem: [{ position: 100, importance: #MEDIUM }],
    identification: [{ position: 100 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 10 }]
  ValorBruto;
  @UI: {
    lineItem: [{ position: 110, importance: #MEDIUM }],
    identification: [{ position: 110 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 20 }]
  Desconto;
  @UI: {
    lineItem: [{ position: 120, importance: #HIGH }],
    identification: [{ position: 120 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 30 }]
  ValorLiquido;
  @UI: {
    lineItem: [{ position: 130, importance: #MEDIUM }],
    identification: [{ position: 130 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 40 }]
  Moeda;

  @UI: {
    lineItem: [{ position: 80, importance: #HIGH }],
    identification: [{ position: 80 }]
  }
  @UI.fieldGroup: [{ qualifier: 'SaidaData', position: 10 }]
  DataSaida;
  // Adicionar botão de ação para Registrar Saída
  @UI: {
    lineItem: [ { type: #FOR_ACTION, dataAction: 'registrarSaida', label: 'Registrar Saída', position: 1 } ],
    identification: [ { type: #FOR_ACTION, dataAction: 'registrarSaida', label: 'Registrar Saída' } ]
  }
  @UI.fieldGroup: [{ qualifier: 'SaidaData', position: 30 }]
  Status;
}