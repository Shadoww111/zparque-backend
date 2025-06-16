@EndUserText.label: 'Disponibilidade do Parque'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_CS4_Disponibilidade as projection on ZI_CS4_Disponibilidade {
    key IdDisponibilidade,
    LugaresMotoTotal,
    LugaresMotoOcupados,
    LugaresMotoLivres,
    MotoOcupadosCriticality,   
    MotoLivresCriticality,     
    LugaresLigeiroTotal,
    LugaresLigeiroOcupados,
    LugaresLigeiroLivres,
    LigeiroOcupadosCriticality,
    LigeiroLivresCriticality,   
    LugaresPesadoTotal,
    LugaresPesadoOcupados,
    LugaresPesadoLivres,
    PesadoOcupadosCriticality, 
    PesadoLivresCriticality,   
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt
}
