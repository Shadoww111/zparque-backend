@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Movimento', 
    typeNamePlural: 'Histórico de Estacionamento',
    title: { type: #STANDARD, value: 'Matricula' },
    description: { type: #STANDARD, value: 'IdMovimento' }
  }
}
annotate view ZC_CS4_MovimentoCliente with {
  @UI.facet: [
    { 
      id: 'MovimentoDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Movimento', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'MovimentoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados Básicos', 
      position: 10, 
      targetQualifier: 'BasicData' 
    },
    { 
      id: 'ValorData', 
      parentId: 'MovimentoDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Valor', 
      position: 20, 
      targetQualifier: 'ValorData' 
    }
  ]

  @UI: {
    lineItem: [{ position: 10, importance: #HIGH }],
    identification: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 10 }]
  IdMovimento;

  @UI: {
    lineItem: [{ position: 20, importance: #HIGH }],
    identification: [{ position: 20 }],
    selectionField: [{ position: 10 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 20 }]
  Matricula;

  @UI: {
    lineItem: [{ position: 30, importance: #MEDIUM }],
    identification: [{ position: 30 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 30 }]
  Marca;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM }],
    identification: [{ position: 40 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40 }]
  Modelo;

  @UI: {
    lineItem: [{ position: 50, importance: #HIGH }],
    identification: [{ position: 50 }],
    selectionField: [{ position: 20 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 50 }]
  DataEntrada;

  @UI: {
    lineItem: [{ position: 60, importance: #HIGH }],
    identification: [{ position: 60 }],
    selectionField: [{ position: 30 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 60 }]
  DataSaida;

  @UI: {
    lineItem: [{ position: 70, importance: #MEDIUM }],
    identification: [{ position: 70 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 70 }]
  DuracaoHoras;

  @UI: {
    lineItem: [{ position: 80, importance: #MEDIUM }],
    identification: [{ position: 80 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 10 }]
  ValorBruto;

  @UI: {
    lineItem: [{ position: 90, importance: #MEDIUM }],
    identification: [{ position: 90 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 20 }]
  Desconto;

  @UI: {
    lineItem: [{ position: 100, importance: #HIGH }],
    identification: [{ position: 100 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 30 }]
  ValorLiquido;

  @UI: {
    lineItem: [{ position: 110, importance: #MEDIUM }],
    identification: [{ position: 110 }]
  }
  @UI.fieldGroup: [{ qualifier: 'ValorData', position: 40 }]
  Moeda;

  @UI: {
    lineItem: [{ position: 120, importance: #MEDIUM }],
    identification: [{ position: 120 }],
    selectionField: [{ position: 40 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 80 }]
  Status;
}