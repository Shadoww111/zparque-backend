projection;
strict ( 2 );
use draft;

define behavior for ZC_CS4_Disponibilidade alias Disponibilidade
{
  use update;

  use action Activate;
  use action Discard;
  use action Edit;
  use action Resume;
  use action Prepare;
}