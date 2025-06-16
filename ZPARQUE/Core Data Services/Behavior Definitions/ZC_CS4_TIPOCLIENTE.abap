projection implementation in class zbp_cs4_tipo_cliente unique;
strict ( 2 );
use draft;

define behavior for ZC_CS4_TipoCliente alias TipoCliente
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