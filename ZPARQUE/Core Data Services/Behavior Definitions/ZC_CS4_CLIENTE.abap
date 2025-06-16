projection;
//strict ( 2 ); //Uncomment this line in order to enable strict mode 2. The strict mode has two variants (strict(1), strict(2)) and is prerequisite to be future proof regarding syntax and to be able to release your BO.
use draft;

define behavior for ZC_CS4_Cliente alias Cliente
{
  use create;
  use update;
  use delete;
  use action Activate;
  use action Discard;
  use action Edit;
  use action Resume;
  use action Prepare;

  use association _Veiculos { create; }
}

define behavior for ZC_CS4_Veiculo alias Veiculo
{
  use update;
  use delete;

  use association _Cliente;
}