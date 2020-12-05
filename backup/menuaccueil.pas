{$codepage utf8}
unit menuAccueil;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, GestionEcran, Keyboard,bouclesJeux,navigationMenues ; //appel des unités

procedure mainMenuAccueil(); {Procédure qui appelle toutes les fonctions et procédures du menu accueil }

implementation

  //déclaration des constantes connues de toute l'unité
  const
    //Nombre d'item dans les menus
    //nb d'item dans le menu
    totaleItemsMenu=2;

    //Déclaration des items de notre menu initial
    txtNewPartie='-- Nouvelle Partie'; //constante de type string qui est le 1er item du menu
    txtQuitter='Quitter'; //constante de type string qui est le 3ème item du menu


    //Déclaration des abcisses de notre menu
    txtNewPartieX= 10; //abcisse de txtSuivant à 30px
    txtQuitterX=10; //abcisse de txtGestionbatiment à 10px

    //Déclaration des ordonnées de notre menu
    txtNewPartieY= 20; //ordonnée de txtSuivant à 20px
    txtQuitterY=30; //ordonnée de txtGestionbatiment à 30px

   //déclaration des variables connues de toute l'unité
    var
      touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

      menuInterfaAccueil: array[1..totaleItemsMenu] of String =(txtNewPartie,txtQuitter); //tableau qui contient les différents item texte du menu
      itemsCoordX: array[1..totaleItemsMenu] of Integer = (txtNewPartieX,txtQuitterX); //tableau qui contient les différents abcisses des items du menu
      itemsCoordY:array[1..totaleItemsMenu] of Integer = (txtNewPartieY,txtQuitterY); //tableau qui contient les différents ordonnées des items du menu

    {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
    procedure affichage();
    begin
      rectangleZoneJeu(); //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu(); //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      printItemsMenu(totaleItemsMenu,menuInterfaAccueil,itemsCoordX,itemsCoordY) ; //procédure qui affiche tous les items du menu en position X et Y
    end;

    procedure mainMenuAccueil(); {Procédure qui appelle toutes les fonctions et procédures du menu accueil }
    var
        menu:Boolean; //variable booléenne qui permet de rester dans le menu tant qu'elle est vraie
    begin
      initiaNbTourBoucle(); //initialisation du nb de tour de boucle quand on arrive sur le menu
      menu:=True; //initialisation de menu à true quand on arrive sur le menuAccueil

      //tant que le menu est lancé executé les instructions
      while (menu=True) do
        begin
          //si on vient d'arriver sur le menu on initialise l'affichage des éléments du menu, initialisation de l'item actuel à 1 etc
          if (getNbTourBoucle()=0) then
            begin
            effacerEcran; //raffraichissement de l'écran car on vient d'arriver sur un autre menu
            initItemChoisie(); //initialisation de l'itemChoisie
            initialisationItemActuel(1); //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
            initialisationItemAnterieur(); //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
            //affichage des rectangles, du texte et du menu
            affichage();// affichage des rectangles du nom du menu et de tous les items du menu
            colorierElementActu(0,60,itemsCoordX,itemsCoordY); //colorie l'item actuel sur lequel l'user est
            end

          //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
          else if(getNbTourBoucle>=1) then
            begin
              touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
              touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
              setItemChoisie(touche);
              navigationTabMenu(menuInterfaAccueil,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menu
              colorierElementActu(0,60,itemsCoordX,itemsCoordY); //colorie l'item actuel sur lequel l'user est
              reintialiserElementAnt(0,60,itemsCoordX,itemsCoordY); //colorie l'item actuel sur lequel l'user est
            end;
          incrementaNbTourBoucle(); //incrémentation du tour de boucle

          if (getItemChoisie()=1) then
            begin
            effacerEcran;
            menu:=False; // on passe au menu suivant
            end
          else if (getItemChoisie()=2) then
            begin
              halt(); //quitte la fenêtre si l'user choisi quitter
            end;
        end;
    end;

end.

