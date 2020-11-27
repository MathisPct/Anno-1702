unit bouclesJeux;

{$mode objfpc}{$H+}

interface
//visibles par les programmes qui appelle l'unité

uses
  SysUtils; //appel des unités

{Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
procedure initiaNbTourBoucle();

{Procédure qui modifie le nbTourBoucle : incrémente de 1 le nb de tour de boucle }
procedure incrementaNbTourBoucle();

//Cette fonction renvoie la valeur de la variable nbTourBoucle
function getNbTourBoucle(): Integer;

implementation
  //variables connues de toute l'unité
  var
    nbTourBoucle:Integer; //variable de type integer qui compte le nb de tour dans la boucle

  {Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
  procedure initiaNbTourBoucle();
    begin
      nbTourBoucle:=1; //initialisation du nb de tour de boucle à 1 quand on arrive sur le menu
    end;

  {Procédure qui modifie le nbTourBoucle : incrémente de 1 le nb de tour de boucle }
  procedure incrementaNbTourBoucle();
    begin
      nbTourBoucle:=nbTourBoucle+1;//incrémentation du nombre de tours dans la boucle
    end;

  //Cette fonction renvoie la valeur de la variable nbTourBoucle
  function getNbTourBoucle(): Integer;
  begin
       getNbTourBoucle := nbTourBoucle;
  end;

end.

