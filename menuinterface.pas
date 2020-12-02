{$codepage utf8}
unit menuInterface;

{$mode objfpc}{$H+}

interface

  uses sysutils,gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage,unitRessources,sMenuGestionBatiments ; //appel des unités

  procedure mainMenuInterface(); {Procédure qui appelle toutes les fonctions et procédures pour afficher le menu interface }

implementation
  //déclaration des constantes connues de toute l'unité
  const
      //Nombre d'item dans les menus
      //nb d'item dans le menu
      totaleItemsMenu=5;

      //nb de ressources
      totaleItemsRessources=6;

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

      //absicces ressources
      txtGoldX= 115; //abcisse du text gold
      txtWoodX=115;
      txtFishX=115;
      txtLaineX=115;
      txtTissuX=115;
      txtToolX=115;

      //ordonnées ressources
      txtGoldY= 12;
      txtWoodY= 15;
      txtFishY= 18;
      txtLaineY= 21;
      txtTissuY= 24;
      txtToolY= 27;

  //type connue de toute l'unité
  type
   //déclaration type menu qui est un type qui sert à contenir les différents items de notre menu
   menu = array[1..totaleItemsMenu] of String;

   //déclaration type tabCoordXItem qui est un type qui sert à contenir les différentes abcisses où sont placées les items de notre menu
   tabCoordXItem = array[1..totaleItemsMenu] of Integer;

   //déclaration type tabCoordYItem qui est un type qui sert à contenir les différentes ordonnées où sont placées les items de notre menu
   tabCoordYItem = array[1..totaleItemsMenu] of Integer;

   //déclaration type qui sert à contenir les coordonnées du placement des txt des ressources
   tabCoordXItemRessources= array[1..totaleItemsRessources] of Integer;

   tabCoordYItemRessources = array[1..totaleItemsRessources] of Integer;



  //déclaration des variables connues de toute l'unité
  var

    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

    menuInterfa:menu=(txtSuivant,txtGestionbatiment,txtQuitter,txtTest,txtTest2); //tableau qui contient les différents item texte du menu

    itemsCoordX: tabCoordXItem = (txtSuivantX,txtGestionbatimentX,txtQuitterX,txtTestX,txtTest2X); //tableau qui contient les différents abcisses des items du menu

    itemsCoordY:tabCoordYItem = (txtSuivantY,txtGestionbatimentY,txtQuitterY,txtTestY,txtTest2Y); //tableau qui contient les différents ordonnées des items du menu

    //tableau qui contient les ressources
    RessourcesCoordX: tabCoordXItemRessources = (txtGoldX,txtWoodX,txtFishX,txtLaineX,txtTissuX,txtToolX);

    RessourcesCoordY: tabCoordYItemRessources = (txtGoldY,txtWoodY,txtFishY,txtLaineY,txtTissuY,txtToolY);

    joueur: perso; //variable de type perso (record issu de l'unité personnage)

  {Procédure qui affiche tous les items du menu en position X et Y  }
  procedure affichageItemsMenu();
  var
    item: Integer; //variable entière: compteur boucle affichage items menu interface
  begin
    //affichage des items du menu  (affichageItem est une fonction de bouclesJeux)
    for item:=1 to totaleItemsMenu do
        affichageItem(menuInterfa[item],itemsCoordX[item],itemsCoordY[item]);
  end;


  {  affiche tous les txt des ressources en position X et Y  }
  procedure affichageItemsRess(totalItem: Integer; CoordX: tabCoordXItemRessources; CoordY: tabCoordYItemRessources);
  var
    itemRess: Integer; //variable entière, compteur de la boucle d'affichage (index tableau)
  begin
    //affichage de chaque ressource
    for itemRess:=1 to totalItem do
        affichageItem(GetRessources(itemRess),CoordX[itemRess],CoordY[itemRess]); //affichage de l'item 1 du menu avec les coordonnées de cette item
  end;


  {Procédure qui colorier l'élément actuel sur lequel est placé l'utilisateur}
  procedure colorierElementActuel(margeGauche,margeDroite: integer);
  begin
    //colorie la zone en fonction de l'élément actuel sur lequel l'user est placé
    case getItemActuel() of
      1 : ColorierZone(1,15,itemsCoordX[1]-margeGauche,itemsCoordX[1]+margeDroite,itemsCoordY[1]) ; //colorie le 1er item
      2 : ColorierZone(1,15,itemsCoordX[2]-margeGauche,itemsCoordX[2]+margeDroite,itemsCoordY[2]) ; //colorie le 2eme item
      3 : ColorierZone(1,15,itemsCoordX[3]-margeGauche,itemsCoordX[3]+margeDroite,itemsCoordY[3]) ; //colorie le 3eme item
      4 : ColorierZone(1,15,itemsCoordX[4]-margeGauche,itemsCoordX[4]+margeDroite,itemsCoordY[4]) ; //colorie le 4eme item
      5 : ColorierZone(1,15,itemsCoordX[5]-margeGauche,itemsCoordX[5]+margeDroite,itemsCoordY[5]) ; //colorie le 5eme item
    end
  end;

  procedure reintialiserElementAnterieur(margeGauche,margeDroite: integer);
    begin
      //rétablie la couleur de l'élément précedemment choisie par l'user
      case getItemAnterieur() of
        1 : ColorierZone(0,15,itemsCoordX[1]-margeGauche,itemsCoordX[1]+margeDroite,itemsCoordY[1]); //rétablie la couleur du 1er item
        2 : ColorierZone(0,15,itemsCoordX[2]-margeGauche,itemsCoordX[2]+margeDroite,itemsCoordY[2]); //rétablie la couleur du 1er item
        3 : ColorierZone(0,15,itemsCoordX[3]-margeGauche,itemsCoordX[3]+margeDroite,itemsCoordY[3]); //rétablie la couleur du 1er item
        4 : ColorierZone(0,15,itemsCoordX[4]-margeGauche,itemsCoordX[4]+margeDroite,itemsCoordY[4]); //rétablie la couleur du 1er item
        5 : ColorierZone(0,15,itemsCoordX[5]-margeGauche,itemsCoordX[5]+margeDroite,itemsCoordY[5]); //rétablie la couleur du 1er item
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
    afficheNomMenu('Interface de jeu'); //procédure écrit nom menu
    affichageItemsMenu(); //procédure qui affiche tous les items du menu en position X et Y
    dessinerCadreLsRessources(); {Procédure qui dessine le cadre dans lequel on affiche les différentes ressources}
    affichageItemsRess((GetTotalItemRessources()),RessourcesCoordX, RessourcesCoordY);
    dessinerCadreLsHab(); {Procédure qui dessine le cadre dans lequel on afficha la liste des habitants}
    dessinerCadreDescription(); {Procédure qui dessine le cadre dans lequel on afficha la description}
    afficheNomJoueur(20,12); //procédure qui affiche le nom du joueur en position X et Y
  end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainMenuInterface();
    var
       running: Boolean; //variable booleenne qui permet de demarrer le menu
       runningTourSuivant: Boolean;
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
                  initItemChoisie(); //initialisation de l'itemChoisie
                  //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                  initialisationItemActuel(1);
                  //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                  initialisationItemAnterieur();

                  //affichage des rectangles, du texte et du menu
                  affichage();// affichage des rectangles du nom du menu et de tous les items du menu
                  colorierElementActuel(10,50); //initialisation de colorierElementActuel
                 end
            //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
             else if(getNbTourBoucle>=1) then
                begin
                  touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                  touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                  setItemChoisie(touche);
                  navigationTabMenu(menuInterfa,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                  colorierElementActuel(10,50);
                  reintialiserElementAnterieur(10,50); //réintialise la couleur de l'item précedemment choisie
                 end;
             incrementaNbTourBoucle(); //incrémentation du tour de boucle

             case (getItemChoisie()) of
               1:
                begin
                  effacerEcran;
                  running:=False;
                  runningTourSuivant:=True;
                  while runningTourSuivant do
                    begin
                      writeln('Sous-Menu tour suivant') ;
                      ReadLn();
                      //initialisation
                      initiaNbTourBoucle();
                      initItemChoisie();
                      runningTourSuivant:=False;
                      running:=true;
                    end;
                end;

               2:
                begin
                mainSMenuGBat();//affichage sous menu batiments
                initiaNbTourBoucle(); //initialisation nbTour boucle
                running:=True; //quand on sort du menu batiments
                end;

               3: halt(); //quitte la fenêtre si l'user choisi quitter

               4: writeln(menuInterfa[4]);

               5: writeln(menuInterfa[5]);

               end; //fin case of

            end; //fin boucle tant que
  end;

end.

