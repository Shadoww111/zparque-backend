projection implementation in class zbp_c_cs4_tipoveiculo unique;
strict ( 2 );
use draft;

define behavior for ZC_CS4_TipoVeiculo alias TipoVeiculo
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