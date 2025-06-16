projection implementation in class zbp_c_cs4_movimentosaida unique;
strict ( 2 );
use draft;

define behavior for ZC_CS4_MovimentoSaida alias MovimentoSaida
{
  //use update;

  use action registrarSaida;
//  use action calcularValor;

  use action Activate;
  use action Discard;
  use action Edit;
  use action Resume;
  use action Prepare;
}