projection;
strict ( 2 );
use draft;

define behavior for ZC_CS4_MovimentoEntrada alias MovimentoEntrada
{
  use create;
  use update;
  use delete;



  use action Activate;
  use action Discard;
  use action Edit;
  use action Resume;
  use action Prepare;
}