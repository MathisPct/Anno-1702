{$codepage utf8}
unit menuInterface;

{$mode objfpc}{$H+}

interface

uses sysutils,gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage,unitRessources,sMenuGestionBatiments, smenutoursuivant ,population , UnitBuilding ,sMenuMarchand; //appel des unités

procedure mainMenuInterface(); {Procédure qui appelle toutes les fonctions et procédures pour afficher le menu interface }

implementation
  //déclaration des constantes connues de toute l'unité
  const
    //nb d'item dans le menu
    totaleItemsMenu=5;
    //nb de ressources (affichage x et y)
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

  type
    //déclaration type qui sert à contenir les coordonnées du placement des txt des ressources
   tabCoordXItemRessources= array[1..totaleItemsRessources] of Integer;
   tabCoordYItemRessources = array[1..totaleItemsRessources] of Integer;

  //déclaration des variables connues de toute l'unité
  var

    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

    menuInterfa:array[1..totaleItemsMenu] of String =(txtSuivant,txtGestionbatiment,txtQuitter,txtTest,txtTest2); //tableau qui contient les différents item texte du menu
    itemsCoordX:array[1..totaleItemsMenu] of Integer = (txtSuivantX,txtGestionbatimentX,txtQuitterX,txtTestX,txtTest2X) ;//tableau qui contient les différents abcisses des items du menu
    itemsCoordY:array[1..totaleItemsMenu] of Integer= (txtSuivantY,txtGestionbatimentY,txtQuitterY,txtTestY,txtTest2Y); //tableau qui contient les différents ordonnées des items du menu

    //tableaux qui contient les coordonnées (x et y) des ressources
    RessourcesCoordX:  tabCoordXItemRessources = (txtGoldX,txtWoodX,txtFishX,txtLaineX,txtTissuX,txtToolX);
    RessourcesCoordY:  tabCoordYItemRessources = (txtGoldY,txtWoodY,txtFishY,txtLaineY,txtTissuY,txtToolY);

    joueur: perso; //variable de type perso (record issu de l'unité personnage)

  {  affiche tous les txt des ressources en position X et Y  }
  procedure affichageItemsRess(totalItem: Integer; CoordX:tabCoordXItemRessources;CoordY: tabCoordXItemRessources);
  var
    itemRess: Integer; //variable entière, compteur de la boucle d'affichage (index tableau)
  begin
    //affichage de chaque ressource
    for itemRess:=1 to totalItem do
        affichageItem(GetRessourcesTxtValue(itemRess),CoordX[itemRess],CoordY[itemRess]); //affichage de l'item 1 du menu avec les coordonnées de cette item
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

      printItemsMenu(totaleItemsMenu,menuInterfa,itemsCoordX,itemsCoordY);
      dessinerCadreLsRessources(); {Procédure qui dessine le cadre dans lequel on affiche les différentes ressources}
      affichageItemsRess(GetTotalItemRessources(),RessourcesCoordX, RessourcesCoordY);
      //affichageItemsRess();  //affichage des ressources
      dessinerCadreLsHab(); {Procédure qui dessine le cadre dans lequel on afficha la liste des habitants}
      dessinerCadreDescription(); {Procédure qui dessine le cadre dans lequel on afficha la description}
      afficheNomJoueur(20,12); //procédure qui affiche le nom du joueur en position X et Y
      afficheNbHab(1,15,27);  {procedure qui affiche la valeur du nombre de la pop en position x et y}
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

                  colorierElementActu(10,50,itemsCoordX,itemsCoordY);

                  quantityAllRessTPrec();
                 end
            //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
             else if(getNbTourBoucle>=1) then
                begin
                  touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                  touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                  setItemChoisie(touche);
                  navigationTabMenu(menuInterfa,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                  //colorierElementActuel(10,50);
                  //reintialiserElementAnterieur(10,50); //réintialise la couleur de l'item précedemment choisie
                  colorierElementActu(10,50,itemsCoordX,itemsCoordY);
                  reintialiserElementAnt(10,50,itemsCoordX,itemsCoordY);
                 end;
             incrementaNbTourBoucle(); //incrémentation du tour de boucle

             case (getItemChoisie()) of
               1:
                begin
                  setBoucleNbTour(1);//incrémentation nbTour
                  running:=False;   //on sort du menu interface
                  initItemChoisie(); //initialisation de l'itemChoisie
                  mainSMenuMarchand();
                  initiaNbTourBoucle(); //initialisation nbTourBoucle pour affichage etc
                  productionBatTour(); //produire des ressources suivant le nb de batiment qu'on a et les coefs de prod de ressources de chaque bat
                  consommation(1); //consommation de ressources par la pop (nbHab*coefNutri)
                  //initialisation système de jeu
                  setNbPop(1,getBat_Prop('HABITAT','Maison de Colon','quantity'),getBat_Prop('HABITAT','Maison de Colon','capacity')); //init nb population (type , nbMaison, capacité maison )
                  maintSMenuTs(); //affichage du sous menu
                  running:=True;
                end;

               2:
                begin
                  mainSMenuGBat();//affichage sous menu bat
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

