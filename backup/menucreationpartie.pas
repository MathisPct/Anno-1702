{$codepage utf8}
unit menuCreationPartie;

{$mode objfpc}{$H+}

interface

uses gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage; //appel des unités

{Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu de création de partie }
procedure mainMenuCreaPartie();

implementation
//déclaration des constantes connues de toute l'unité
const
    //Nombre d'item dans les menus
    //nb d'item dans le menu
    totaleItemsMenu=1;

    //Déclaration des items de notre menu initial
    txtNomPerso='Nom du personnage: '; //constante de type string qui est le 1er item du menu

    //Déclaration des abcisses de notre menu
    txtNomPersoX= 15; //abcisse de txtNomPerso

    //Déclaration des ordonnées de notre menu
    txtNomPersoY= 10; //ordonnée de txtNomPerso

 //déclaration des variables connues de toute l'unité
 var
    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

    menuCreaPartie:array[1..totaleItemsMenu] of String=(txtNomPerso); //tableau qui contient les différents item texte du menu

    itemsCoordX: array[1..totaleItemsMenu] of Integer = (txtNomPersoX); //tableau qui contient les différents abcisses des items du menu

    itemsCoordY:array[1..totaleItemsMenu] of Integer = (txtNomPersoY); //tableau qui contient les différents ordonnées des items du menu

    joueur : perso; //variable de type perso (record issu de l'unité personnage)

   //procédure de saisie du nom du personnage
   procedure saisieNom();
   begin
       //tant que le nom a pas été saisie on reste à la position x et y
       repeat
         //déplacer curseur à la position où l'user entre le nom du perso
        deplacerCurseurXY(txtNomPersoX+20,txtNomPersoY);
        nouveauPerso(demandeNom()); //Fonction (issu de personnage) qui créer un nouveau personnage dont le nom est donné en paramètre
       until (getNomJoueur <>'');
   end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
  procedure affichage();
  begin
    rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
    printItemsMenu(totaleItemsMenu,menuCreaPartie,itemsCoordX,itemsCoordY); //procédure qui affiche tous les items du menu en position X et Y
  end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu de création de partie }
  procedure mainMenuCreaPartie();
     var
        running: Boolean; //variable booleenne qui permet de demarrer le menu
     begin
        initiaNbTourBoucle(); //initialisation du nb de tour de boucle quand on arrive sur le menu
        running:=True; //initialisation de running à true quand on arrive sur le menu
        //tant que le menu est lancé executé les instructions
        while (running=True) do
          begin
              //si on vient d'arriver sur le menu on initialise l'affichage des éléments du menu, initialisation de l'item actuel à 1 etc
              if (getNbTourBoucle()=0) then
                begin
                  effacerEcran; //raffraichissement de l'écran car on est passé sur un autre menu
                  //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                  initialisationItemActuel(1);
                  //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                  initialisationItemAnterieur();
                  //affichage des rectangles, du texte et du menu
                  affichage();// affichage des rectangles du nom du menu et de tous les items du menu
                end
              else if(getNbTourBoucle>=1) then
                begin
                  navigationTabMenu(menuCreaPartie,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menu
                  saisieNom(); //procédure de saisie du nom du personnage
                  running:=False; //fin du menu quand le nom a été saisi
                end;
              incrementaNbTourBoucle(); //incrémentation du tour de boucle
          end;  //fin tant que

       end;  //fin procédure

end.

