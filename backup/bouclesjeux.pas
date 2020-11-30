unit bouclesJeux;

{$mode objfpc}{$H+}

interface
//visibles par les programmes qui appelle l'unité

uses
  SysUtils,GestionEcran ; //appel des unités

{Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
procedure initiaNbTourBoucle();

{Procédure qui modifie le nbTourBoucle : incrémente de 1 le nb de tour de boucle }
procedure incrementaNbTourBoucle();

//Cette fonction renvoie la valeur de la variable nbTourBoucle
function getNbTourBoucle(): Integer;


{Procédure qui dessine le rectangle de la zone du jeu}
 procedure rectangleZoneJeu();

 {Procédure qui affiche le cadre entourant le texte Bienvenue sur 'NomIle'}
 procedure cadreTxtNomMenu();


 {Procédure qui affiche un item présents dans le menu en position X et Y}
procedure affichageItem(item:String;posX,posY:Integer);

implementation
  //variables connues de toute l'unité
  var
    nbTourBoucle:Integer; //variable de type integer qui compte le nb de tour dans la boucle

  {Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
  procedure initiaNbTourBoucle();
    begin
      nbTourBoucle:=0; //initialisation du nb de tour de boucle à 1 quand on arrive sur le menu
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


  //--------------Procédures qui servent à décorer la zone de jeu---------------//

  {Procédure qui dessine le rectangle de la zone du jeu}
  procedure rectangleZoneJeu();
    begin
     //zone de jeu
      dessinerCadreXY(3,3,197,57,simple,15,0);
    end;

  {Procédure qui affiche le cadre entourant le texte Bienvenue sur 'NomIle'}
  procedure cadreTxtNomMenu();
    begin
      dessinerCadreXY(80-10,1,80,5-2,simple,15,0); //petit rectangle décors gauche
      dessinerCadreXY(120,1,120+10,5-2,simple,15,0); //petit rectangle décors droit
      dessinerCadreXY(80,1,120,5,simple,15,0); //rectangle entourant le texte Création d'une nouvelle partie
    end;

   //--------------FIN Procédures qui servent à décorer la zone de jeu---------------//

  {Procédure qui affiche un item présents dans le menu en position X et Y}
  procedure affichageItem(item:String;posX,posY:Integer);
  var
    posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
  begin
    posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
    posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
    ecrireEnPosition(posItem,item); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem
  end;

end.

