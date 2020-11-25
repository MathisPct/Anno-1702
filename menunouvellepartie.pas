unit menuNouvellePartie;

{$codepage utf8}
{$mode objfpc}{$H+}

interface
//Partie Visible pour les programmes qui appellent cette unité

{$codepage utf8}   //gérer les accents

//appel des unités
uses
  GestionEcran, navigationMenues;

procedure affichageMenuCreaPartie();{Procédure qui appelle toutes les fonctions et procédures pour afficher l'écran du menu}
procedure rectangleZoneJeu();  {Procédure qui dessine la zone du jeu}


implementation

  //déclaration des constantes connues de toute l'unité
  const
      //nb d'item dans le menu
      totaleItemsMenu=1;

      //Déclaration des items de notre menu Nouvelle Partie


      //Déclaration de l'item qui est le nom du menu (affiché tout en haut au milieu de l'écran et encadrée)
      txtNomMenu='Création de la partie'; //constante de type string

  {Procédure qui dessine le rectangle de la zone du jeu}
  procedure rectangleZoneJeu();
    begin
     //zone de jeu
      dessinerCadreXY(3,3,197,57,simple,15,0);
    end;

  {Procédure qui affiche le cadre entourant le texte 'Création d'une nouvelle partie}
  procedure cadreTxtNomMenu();
    begin
      dessinerCadreXY(80-10,1,80,5-2,simple,15,0); //petit rectangle décors gauche
      dessinerCadreXY(120,1,120+10,5-2,simple,15,0); //petit rectangle décors droit
      dessinerCadreXY(80,1,120,5,simple,15,0); //rectangle entourant le texte Création d'une nouvelle partie
    end;

  {Procédure qui affiche le nom du menu Création d'une nouvelle partie dans le rectangle entourant le txt}
  procedure afficheNomMenu();
    var
       positionTxt:coordonnees; //variable de type coordonnées qui est la position du texte dans la fenêtre
    begin
      positionTxt.x:=85; //initialisation de la position x d'écriture à partir de 90px en largeur
      positionTxt.y:=3; //initialisation de la position y d'écriture à partir de 3px en largeur
      ecrireEnPosition(positionTxt,txtNomMenu); //procédure issue de GestionEcran qui écrit à la positionTxt la constante txtNomMenu
    end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher l'écran du menu}
  procedure affichageMenuCreaPartie();
    begin
      //appel des procédures
      rectangleZoneJeu(); //dessine le rectangle de la zone de jeu
      cadreTxtNomMenu(); //dessine les éléments entourant le texte Création d'une nouvelle partie
      afficheNomMenu(); //procédure qui écrit à la positionTxt , Création d'une nouvelle partie
    end;

end.


