{$codepage utf8}
unit menuInterface;

{$mode objfpc}{$H+}

interface

uses gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage; //appel des unités

procedure mainMenuInterface(); {Procédure qui appelle toutes les fonctions et procédures pour afficher le menu interface }

implementation
  //déclaration des constantes connues de toute l'unité
  const
      //Nombre d'item dans les menus
      //nb d'item dans le menu
      totaleItemsMenu=5;

      //Déclaration des items de notre menu initial
      txtSuivant='Tour suivant'; //constante de type string qui est le 1er item du menu
      txtGestionbatiment='Accéder au menu de gestion des batimênts'; //constante de type string qui est le 2ème item du menu
      txtQuitter='Quitter la partie'; //constante de type string qui est le 3ème item du menu
      txtTest='Test1';
      txtTest2='Test2';

      //Déclaration des abcisses de notre menu
      txtSuivantX= 15; //abcisse de txtSuivant
      txtGestionbatimentX=15; //abcisse de txtGestionbatiment
      txtQuitterX=15; //abcisse de txtGestionbatiment
      txtTestX=15;  //abcisse de txtGestionbatiment
      txtTest2X=15; //abcisse de txtTest2

      //Déclaration des ordonnées de notre menu
      txtSuivantY= 40; //ordonnée de txtSuivant
      txtGestionbatimentY=42; //ordonnée de txtGestionbatiment
      txtQuitterY=48; //ordonnée de txtGestionbatiment
      txtTestY=50;  //ordonnée de txtGestionbatiment
      txtTest2Y=52; //ordonnée de txtTest2

  //type connue de toute l'unité
  type
   //déclaration type menu qui est un type qui sert à contenir les différents items de notre menu
   menu = array[1..totaleItemsMenu] of String;

   //déclaration type tabCoordXItem qui est un type qui sert à contenir les différentes abcisses où sont placées les items de notre menu
   tabCoordXItem = array[1..totaleItemsMenu] of Integer;

   //déclaration type tabCoordYItem qui est un type qui sert à contenir les différentes ordonnées où sont placées les items de notre menu
   tabCoordYItem = array[1..totaleItemsMenu] of Integer;

  //déclaration des variables connues de toute l'unité
  var

    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

    menuInterfa:menu=(txtSuivant,txtGestionbatiment,txtQuitter,txtTest,txtTest2); //tableau qui contient les différents item texte du menu

    itemsCoordX: tabCoordXItem = (txtSuivantX,txtGestionbatimentX,txtQuitterX,txtTestX,txtTest2X); //tableau qui contient les différents abcisses des items du menu

    itemsCoordY:tabCoordYItem = (txtSuivantY,txtGestionbatimentY,txtQuitterY,txtTestY,txtTest2Y); //tableau qui contient les différents ordonnées des items du menu

    joueur: perso; //variable de type perso (record issu de l'unité personnage)

  {Procédure qui affiche tous les items du menu en position X et Y}
  procedure affichageItemsMenu();
  begin
    //affichage des items du menu  (affichageItem est une fonction de gestionEcran)
    affichageItem(menuInterfa[1],itemsCoordX[1],itemsCoordY[1]); //affichage de l'item 1 du menu avec les coordonnées de cette item
    affichageItem(menuInterfa[2],itemsCoordX[2],itemsCoordY[2]); //affichage de l'item 2 du menu
    affichageItem(menuInterfa[3],itemsCoordX[3],itemsCoordY[3]); //affichage de l'item 3 du menu
    affichageItem(menuInterfa[4],itemsCoordX[4],itemsCoordY[4]); //affichage de l'item 4 du menu
    affichageItem(menuInterfa[5],itemsCoordX[5],itemsCoordY[5]); //affichage de l'item 5 du menu
  end;

  {Procédure qui colorier l'élément actuel sur lequel est placé l'utilisateur}
  procedure colorierElementActuel();
  begin
    //colorie la zone en fonction de l'élément actuel sur lequel l'user est placé
    case getItemActuel() of
      1 : ColorierZone(1,15,itemsCoordX[1],itemsCoordX[1]+30,itemsCoordY[1]) ; //colorie le 1er item
      2 : ColorierZone(1,15,itemsCoordX[2],itemsCoordX[2]+30,itemsCoordY[2]) ; //colorie le 2eme item
      3 : ColorierZone(1,15,itemsCoordX[3],itemsCoordX[3]+30,itemsCoordY[3]) ; //colorie le 3eme item
      4 : ColorierZone(1,15,itemsCoordX[4],itemsCoordX[4]+30,itemsCoordY[4]) ; //colorie le 4eme item
      5 : ColorierZone(1,15,itemsCoordX[5],itemsCoordX[5]+30,itemsCoordY[5]) ; //colorie le 5eme item
    end
  end;

  procedure reintialiserElementAnterieur();
    begin
      //rétablie la couleur de l'élément précedemment choisie par l'user
      case getItemAnterieur() of
        1 : ColorierZone(0,15,itemsCoordX[1],itemsCoordX[1]+30,itemsCoordY[1]); //rétablie la couleur du 1er item
        2 : ColorierZone(0,15,itemsCoordX[2],itemsCoordX[2]+30,itemsCoordY[2]); //rétablie la couleur du 1er item
        3 : ColorierZone(0,15,itemsCoordX[3],itemsCoordX[3]+30,itemsCoordY[3]); //rétablie la couleur du 1er item
        4 : ColorierZone(0,15,itemsCoordX[4],itemsCoordX[4]+30,itemsCoordY[4]); //rétablie la couleur du 1er item
        5 : ColorierZone(0,15,itemsCoordX[5],itemsCoordX[5]+30,itemsCoordY[5]); //rétablie la couleur du 1er item
      end;
    end;

  {Procédure qui dessine le cadre dans lequel on affiche les différentes ressources}
  procedure dessinerCadreLsRessources();
  begin
    dessinerCadreXY(100+10,10,190,55,simple,15,0); //procédure qui dessine le cadre
  end;

  {Procédure qui dessine le cadre dans lequel on afficha la description}
  procedure dessinerCadreDescription();
  begin
    dessinerCadreXY(10,10,90,20,simple,15,0); //procédure qui dessine le cadre
  end;

  {Procédure qui dessine le cadre dans lequel on afficha la liste des habitants}
  procedure dessinerCadreLsHab();
  begin
    dessinerCadreXY(10,25,90,35,simple,15,0); //procédure qui dessine le cadre
  end;



  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
  procedure affichage();
  begin
    rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
    cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
    affichageItemsMenu; //procédure qui affiche tous les items du menu en position X et Y
    dessinerCadreLsRessources(); {Procédure qui dessine le cadre dans lequel on affiche les différentes ressources}
    dessinerCadreLsHab(); {Procédure qui dessine le cadre dans lequel on afficha la liste des habitants}
    dessinerCadreDescription(); {Procédure qui dessine le cadre dans lequel on afficha la description}
    afficheNomJoueur(20,12); //procédure qui affiche le nom du joueur en position X et Y
  end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainMenuInterface();
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
          //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
          else if(getNbTourBoucle>=1) then
            touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
            touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
            begin
              navigationTabMenu(menuInterfa,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menu
              //affichage test
              colorierElementActuel();
              reintialiserElementAnterieur(); //réintialise la couleur de l'item précedemment choisie
            end;
          incrementaNbTourBoucle(); //incrémentation du tour de boucle
          if (getItemChoisie(touche)=1) then
            begin
            effacerEcran;
            running:=False;
            while true do
              write(menuInterfa[1]);
            end
          else if (getItemChoisie(touche)=2) then
            writeln(menuInterfa[2])
          else if (getItemChoisie(touche)=3) then
            begin
            writeln(menuInterfa[3]);
            running:=False; //fin du jeu si l'user clique sur entree
            end
          else if (getItemChoisie(touche)=4) then
            writeln(menuInterfa[4])
          else if (getItemChoisie(touche)=5) then
            writeln(menuInterfa[5])
        end;
    end;

end.

