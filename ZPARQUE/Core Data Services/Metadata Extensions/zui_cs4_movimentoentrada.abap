@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Entrada', 
    typeNamePlural: 'Entradas',
    title: { type: #STANDARD, value: 'Matricula' },
    description: { type: #STANDARD, value: 'IdMovimento' }
  }
}
annotate view ZC_CS4_MovimentoEntrada with {
  @UI.facet: [
    { 
      id: 'EntradaDetails', 
      purpose: #STANDARD, 
      type: #COLLECTION, 
      label: 'Entrada', 
      position: 10 
    },
    { 
      id: 'BasicData', 
      parentId: 'EntradaDetails', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      label: 'Dados da Entrada', 
      position: 10, 
      targetQualifier: 'BasicData' 
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
  IdCliente;

  @UI: {
    lineItem: [{ position: 40, importance: #MEDIUM }],
    identification: [{ position: 40 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 40 }]
  ClienteNome;

  @UI: {
    lineItem: [{ position: 50, importance: #HIGH }],
    identification: [{ position: 50 }],
    selectionField: [{ position: 20 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 50 }]
  IdTipoVeiculo;

  @UI: {
    lineItem: [{ position: 60, importance: #MEDIUM }],
    identification: [{ position: 60 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 60 }]
  TipoVeiculoDesc;


  @UI: {
    lineItem: [{ position: 80, importance: #MEDIUM }],
    identification: [{ position: 80 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 80 }]
  Status;
  
   @UI: {
    lineItem: [{ position: 70, importance: #HIGH }],
    identification: [{ position: 70 }]
  }
  @UI.fieldGroup: [{ qualifier: 'BasicData', position: 70 }]
  DataEntrada;
}