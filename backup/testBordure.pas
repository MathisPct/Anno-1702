program testBordure;
//appel des unités
uses GestionEcran;

const
  //taille de notre fenêtre de jeu
  largeur=200; //largeur de la fenêtre
  hauteur=60; //hauteur de la fenêtre

var
  gaucheX:Integer=10; //variable entière qui est le haut-gauche en x du rectangle
  droiteX:Integer=50; //variable entière qui est le bas-droit en x du rectangle
  hautRectangle: Integer=5; //variable entière qui est le haut du rectangle en Y
  basRectangle: Integer=10; //variable entière qui est la bas du rectangle en Y


procedure
  changerTailleConsole(largeur,hauteur);

procedure zoneCreationPartie();
  begin
   //zone de jeu
    dessinerCadreXY(3,3,197,57,simple,15,0);
    dessinerCadreXY(80,1,120,5,simple,15,0);
    dessinerCadreXY(80-10,1,80,5-2,simple,15,0);
    dessinerCadreXY(120,1,120+10,5-2,simple,15,0);
  end;

begin
  changerTailleConsole(largeur,hauteur);
  zoneCreationPartie();
  readln;
end.

