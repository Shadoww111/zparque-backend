@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Disponibilidade',
    typeNamePlural: 'Disponibilidade do Parque',
    title: { type: #STANDARD, label: 'CS4 PARK'},
    description: { type: #STANDARD, value: 'IdDisponibilidade' }
  },
  presentationVariant: [{
    sortOrder: [{ by: 'LastChangedAt', direction: #DESC }],
    visualizations: [{ type: #AS_LINEITEM }]
  }]
}
annotate view ZC_CS4_Disponibilidade with {
 
  @UI.facet: [
   
    /* Grupo Principal */
    {
      id:       'DisponibilidadeDetails',
      purpose:  #STANDARD,
      type:     #COLLECTION,
      label:    'Disponibilidade',
      position: 10
    },
    /* ID Disponibilidade - Info Básica */
    {
      id:       'BasicInfo',  
      purpose:  #STANDARD,
      type:     #FIELDGROUP_REFERENCE,
      label:    'Informações Básicas',
      position: 5,
      targetQualifier: 'BasicData'
    },
    /* Subgrupos por Tipo de Veículo */
    {
      id:              'MotoData',
      parentId:        'DisponibilidadeDetails',
      purpose:         #STANDARD,
      type:            #FIELDGROUP_REFERENCE,
      label:           'Motociclos',
      position:        10,
      targetQualifier: 'MotoData'
    },
    {
      id:              'LigeiroData',
      parentId:        'DisponibilidadeDetails',
      purpose:         #STANDARD,
      type:            #FIELDGROUP_REFERENCE,
      label:           'Ligeiros',
      position:        20,
      targetQualifier: 'LigeiroData'
    },
    {
      id:              'PesadoData',
      parentId:        'DisponibilidadeDetails',
      purpose:         #STANDARD,
      type:            #FIELDGROUP_REFERENCE,
      label:           'Pesados',
      position:        30,
      targetQualifier: 'PesadoData'
    },
    /* Informações de Alteração */
    {
      id:              'AdminData',
      purpose:         #STANDARD,
      type:            #FIELDGROUP_REFERENCE,
      label:           'Informação Administrativa',
      position:        40,
      targetQualifier: 'AdminData'
    }
  ]
  
  @UI: {
    lineItem:       [{ position: 10, importance: #HIGH }],
    identification: [{ position: 10 }],
    fieldGroup:     [{ qualifier: 'BasicData', position: 10 }]
  }
  IdDisponibilidade;
 
  @UI: {
    lineItem:       [{ position: 20, importance: #HIGH, label: 'Motos - Total' }],
    identification: [{ position: 20 }],
    fieldGroup:     [{ qualifier: 'MotoData', position: 10 }],
    dataPoint:      { title: 'Total de Lugares p/ Motos' }
  }
  LugaresMotoTotal;
  @UI: {
    lineItem:       [{ position: 30, importance: #HIGH, label: 'Motos - Ocupados', 
                       criticality: 'MotoOcupadosCriticality' }],
    identification: [{ position: 30 }],
    fieldGroup:     [{ qualifier: 'MotoData', position: 20 }],
    dataPoint:      { title: 'Lugares Ocupados', criticality: 'MotoOcupadosCriticality' }
  }
  LugaresMotoOcupados;
  @UI: {
    lineItem:       [{ position: 40, importance: #MEDIUM, label: 'Motos - Livres', 
                       criticality: 'MotoLivresCriticality' }],
    identification: [{ position: 40 }],
    fieldGroup:     [{ qualifier: 'MotoData', position: 30 }],
    dataPoint:      { title: 'Lugares Disponíveis', criticality: 'MotoLivresCriticality' }
  }
  LugaresMotoLivres;
  @UI.hidden: true
  MotoOcupadosCriticality;
  @UI.hidden: true
  MotoLivresCriticality;
  
  @UI: {
    lineItem:       [{ position: 50, importance: #HIGH, label: 'Ligeiros - Total' }],
    identification: [{ position: 50 }],
    fieldGroup:     [{ qualifier: 'LigeiroData', position: 10 }],
    dataPoint:      { title: 'Total de Lugares p/ Ligeiros' }
  }
  LugaresLigeiroTotal;
  @UI: {
    lineItem:       [{ position: 60, importance: #HIGH, label: 'Ligeiros - Ocupados', 
                       criticality: 'LigeiroOcupadosCriticality' }],
    identification: [{ position: 60 }],
    fieldGroup:     [{ qualifier: 'LigeiroData', position: 20 }],
    dataPoint:      { title: 'Lugares Ocupados', criticality: 'LigeiroOcupadosCriticality' }
  }
  LugaresLigeiroOcupados;
  @UI: {
    lineItem:       [{ position: 70, importance: #MEDIUM, label: 'Ligeiros - Livres', 
                       criticality: 'LigeiroLivresCriticality' }],
    identification: [{ position: 70 }],
    fieldGroup:     [{ qualifier: 'LigeiroData', position: 30 }],
    dataPoint:      { title: 'Lugares Disponíveis', criticality: 'LigeiroLivresCriticality' }
  }
  LugaresLigeiroLivres;
  @UI.hidden: true
  LigeiroOcupadosCriticality;
  @UI.hidden: true
  LigeiroLivresCriticality;
  
  @UI: {
    lineItem:       [{ position: 80, importance: #HIGH, label: 'Pesados - Total' }],
    identification: [{ position: 80 }],
    fieldGroup:     [{ qualifier: 'PesadoData', position: 10 }],
    dataPoint:      { title: 'Total de Lugares p/ Pesados' }
  }
  LugaresPesadoTotal;
  @UI: {
    lineItem:       [{ position: 90, importance: #HIGH, label: 'Pesados - Ocupados', 
                       criticality: 'PesadoOcupadosCriticality' }],
    identification: [{ position: 90 }],
    fieldGroup:     [{ qualifier: 'PesadoData', position: 20 }],
    dataPoint:      { title: 'Lugares Ocupados', criticality: 'PesadoOcupadosCriticality' }
  }
  LugaresPesadoOcupados;
  @UI: {
    lineItem:       [{ position: 100, importance: #MEDIUM, label: 'Pesados - Livres', 
                       criticality: 'PesadoLivresCriticality' }],
    identification: [{ position: 100 }],
    fieldGroup:     [{ qualifier: 'PesadoData', position: 30 }],
    dataPoint:      { title: 'Lugares Disponíveis', criticality: 'PesadoLivresCriticality' },
    dataPoint:      { qualifier: 'StatusInfo' }
  }
  LugaresPesadoLivres;
  @UI.hidden: true
  PesadoOcupadosCriticality;
  @UI.hidden: true
  PesadoLivresCriticality;
 
  @UI: {
    fieldGroup:     [{ qualifier: 'AdminData', position: 10 }],
    identification: [{ position: 110 }]
  }
  CreatedBy;
  @UI: {
    fieldGroup:     [{ qualifier: 'AdminData', position: 20 }],
    identification: [{ position: 120 }]
  }
  CreatedAt;
  @UI: {
    fieldGroup:     [{ qualifier: 'AdminData', position: 30 }],
    identification: [{ position: 130 }]
  }
  LastChangedBy;
  @UI: {
    fieldGroup:     [{ qualifier: 'AdminData', position: 40 }],
    identification: [{ position: 140 }]
  }
  LastChangedAt;
}