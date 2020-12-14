{$codepage utf8}
unit sMenuGestionBatiments ;

{$mode objfpc}{$H+}

interface

  uses
    gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage, unitBuilding; //appel des unités

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainSMenuGBat();

implementation
//déclaration des constantes de toute l'unité
const
  //nb d'items dans le sous menu
  totalItemsMenuGetBat    = 2;
  totalItemsMenuConstru   = 9;

  //nb d'item de batiments
  totalItemBatiments        = 8;
  totalItemBatimentsHabitat = 2; // batiment de type HABITAT
  totalItemBatimentsIndus   = 4; // batiment de type INDUSTRIE
  totalItemBatimentsSocial  = 2; // batiment de type SOCIAL


  //déclaration des items du menu
  txtConsBat  = 'Construire un bâtimement'; //constante de type string : item du sMenu
  txtMenuPrec = 'Menu précédent';

  //abcisses texte menu
  consBatX  =80;
  menuPrecX =80;

  //ordonnées texte menu
  consBatY  =50;
  menuPrecY =53;

  //déclaration des items des bâtiments
  txtMaison             ='Maisons';
  txtVilla              ='Villa de citoyens';
  //bâtiments sociaux
  txtCentreVille        ='Centre-Ville';
  txtChapelle           ='Chapelle';
  //industries
  txtCaPecheur          ='Cabane de pêcheur';
  txtCaBucheron         ='Cabane de bucheron';
  txtBergerie           ='Bergerie';
  txtAtelierTisserand   ='Atelier Tisserand';

  //Abcisses texte batiments
  txtMaisonX            = 20;
  txtVillaX             = 20;
  txtCentreVilleX       = 20;
  txtChapelleX          = 20;
  txtCaPecheurX         = 20;
  txtCaBucheronX        = 20;
  txtBergerieX          = 20;
  txtAtelierTisserandX  = 20;

  //Ordonnées texte batiments
  txtMaisonY            = 12;
  txtVillaY             = 13;
  txtCentreVilleY       = 15;
  txtChapelleY          = 18;
  txtCaPecheurY         = 21;
  txtCaBucheronY        = 24;
  txtBergerieY          = 27;
  txtAtelierTisserandY  = 30;

  // BATIMENT HABITAT coordonnées
  // ordonnées habitat
  MaisonX        = 10;
  //abscisses habitat
  MaisonY        = 10;

  villaX         =10 ;
  villaY         =20 ;

   // BATIMENT HABITAT coordonnées
  // ordonnées habitat
  CentreVilleX        = 7;
  ChapelleX           = 7;
  //abscisses habitat
  CentreVilleY        = 31;
  ChapelleY           = 31 + 6;


  // BATIMENT INDUSTRIE coordonnées
  // ordonnées industrie
  CabPecheurX    = 123;
  CabBucheronX   = 123;
  BergerieX      = 123;
  TisserandX     = 123;
  //abscisses industrie
  CabPecheurY    = 10;
  CabBucheronY   = 10 + 6;
  BergerieY      = 10 + 12;
  TisserandY     = 10 + 18;


 //type connu de toute l'unité
 type
   //déclaration type qui sert à contenir les txt des bâtiments
   tabItemBatiments= array [1..totalItemBatiments] of String;
   //déclaration type qui sert à contenir les coordonnées du placement des txt des bâtiments
   tabCoordXItemBatiments= array [1..totalItemBatiments] of Integer;
   tabCoordYItemBatiments= array [1..totalItemBatiments] of Integer;

   tabCoordXItemBatHabitat= array [1..totalItemBatimentsHabitat] of Integer;
   tabCoordYItemBatHabitat= array [1..totalItemBatimentsHabitat] of Integer;

   tabCoordXItemBatSocial= array [1..totalItemBatimentsSocial] of Integer;
   tabCoordYItemBatSocial= array [1..totalItemBatimentsSocial] of Integer;

   tabCoordXItemBatIndus= array [1..totalItemBatimentsIndus] of Integer;
   tabCoordYItemBatIndus= array [1..totalItemBatimentsIndus] of Integer;

 //déclaration des variables connues de toute l'unité
 var
   message: String; // message pour le joueur

   touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

   //marges
   margeGauche:Integer;
   margeDroite: Integer;

   //tableaux qui contient les textes des menu
   menu1: array[1..totalItemsMenuGetBat] of String = (txtConsBat, txtMenuPrec);
   menu2: array[1..totalItemsMenuConstru] of String  = (txtMaison,txtVilla,txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtMenuPrec);

   //tableau contient coordonnées des items du menu1
   menu1X: array[1..totalItemsMenuGetBat] of Integer = (consBatX,menuPrecX);
   menu1Y: array[1..totalItemsMenuGetBat] of Integer = (consBatY,menuPrecY);

   //tableau qui contient les coordonnées des items du menu2
   menu2X: array[1..totalItemsMenuConstru] of Integer  = (txtMaisonX,txtVillaX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX,menuPrecX);
   menu2Y: array[1..totalItemsMenuConstru] of Integer = (txtMaisonY,txtVillaY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY,menuPrecY);


   //tableau qui contient les textes des items batiments
   itemsBat:tabItemBatiments=(txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtMaison,txtVilla);
   //tableau qui contient les coordonnées des items batiments
   itemsBatX: tabCoordXItemBatiments=(txtMaisonX,txtVillaX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX);
   itemsBatY: tabCoordYItemBatiments=(txtMaisonY,txtVillaY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY);

   //tableau qui contient les coordonnées des items batiments HABITAT
   itemsBatHabitatX: tabCoordXItemBatHabitat=(MaisonX,villaX);
   itemsBatHabitatY: tabCoordYItemBatHabitat=(MaisonY,villaY);

   //tableau qui contient les coordonnées des items batiments SOCIAL
   itemsBatSocialX: tabCoordXItemBatSocial=(CentreVilleX, ChapelleX);
   itemsBatSocialY: tabCoordYItemBatSocial=(CentreVilleY, ChapelleY);

   //tableau qui contient les coordonnées des items batiments INDUSTRIE
   itemsBatIndusX: tabCoordXItemBatIndus=(CabPecheurX,CabBucheronX,BergerieX,TisserandX);
   itemsBatIndusY: tabCoordYItemBatIndus=(CabPecheurY,CabBucheronY,BergerieY,TisserandY);

    procedure affichageItemsBat_Habitat(CoordX: tabCoordXItemBatHabitat; CoordY: tabCoordYItemBatHabitat);
        const
         margeX = 4;  // marge x des textes infos de chaque batiment
         margeY = 1;  // marge y

         // permet de changer l'ordre d'affichage des batiments
         Maison  = 1;
         villa   =2;
    begin
          // affichage maison de colon
          affichageBatiment('HABITAT','Maison de Colon'   ,'nom'         ,CoordX[Maison]          ,CoordY[Maison]             );
          affichageBatiment('HABITAT','Maison de Colon'   ,'quantity'    ,CoordX[Maison] + margeX ,CoordY[Maison] + (1*margeY));
          affichageBatiment('HABITAT','Maison de Colon'   ,'necessite'   ,CoordX[Maison] + margeX ,CoordY[Maison] + (2*margeY));

          affichageBatiment('HABITAT','Villa de citoyen'   ,'nom'         ,CoordX[villa]          ,CoordY[villa]             );
          affichageBatiment('HABITAT','Villa de citoyen'   ,'quantity'    ,CoordX[villa] + margeX ,CoordY[villa] + (1*margeY));
          affichageBatiment('HABITAT','Villa de citoyen'   ,'necessite'   ,CoordX[villa] + margeX ,CoordY[villa] + (2*margeY));
    end;

    procedure affichageItemsBat_Social(CoordX: tabCoordXItemBatSocial; CoordY: tabCoordYItemBatSocial);
        const
         margeX = 4;  // marge x des textes infos de chaque batiment
         margeY = 1;  // marge y

         // permet de changer l'ordre d'affichage des batiments
         CentreVille  = 1;
         Chapelle     = 2;
    begin
          // affichage centre-ville
          affichageBatiment('SOCIAL','Centre-Ville'   ,'nom'         ,CoordX[CentreVille]          ,CoordY[CentreVille]             );
          affichageBatiment('SOCIAL','Centre-Ville'   ,'quantity'    ,CoordX[CentreVille] + margeX ,CoordY[CentreVille] + (1*margeY));
          affichageBatiment('SOCIAL','Centre-Ville'   ,'necessite'   ,CoordX[CentreVille] + margeX ,CoordY[CentreVille] + (2*margeY));
          // affichage chapelle
          affichageBatiment('SOCIAL','Chapelle'   ,'nom'         ,CoordX[Chapelle]          ,CoordY[Chapelle]             );
          affichageBatiment('SOCIAL','Chapelle'   ,'quantity'    ,CoordX[Chapelle] + margeX ,CoordY[Chapelle] + (1*margeY));
          affichageBatiment('SOCIAL','Chapelle'   ,'necessite'   ,CoordX[Chapelle] + margeX ,CoordY[Chapelle] + (2*margeY));
    end;

  procedure affichageItemsBat_Industrie(CoordX: tabCoordXItemBatIndus; CoordY: tabCoordYItemBatIndus);
        const
         margeX = 4;  // marge x des textes infos de chaque batiment
         margeY = 1;  // marge y

         // permet de changer l'ordre d'affichage des batiments
         cabPecheur  = 1;
         cabBucheron = 2;
         Bergerie    = 3;
         Tiserand    = 4;
    begin
          // affichage cabane de pecheur
          affichageBatiment('INDUSTRIE','Cabane de Pecheur'   ,'nom'         ,CoordX[cabPecheur]          ,CoordY[cabPecheur]               );
          affichageBatiment('INDUSTRIE','Cabane de Pecheur'   ,'quantity'    ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur]   + (1*margeY));
          affichageBatiment('INDUSTRIE','Cabane de Pecheur'   ,'production'  ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur]   + (2*margeY));
          affichageBatiment('INDUSTRIE','Cabane de Pecheur'   ,'necessite'   ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur]   + (3*margeY));
          // affichage cabane de bucheron
          affichageBatiment('INDUSTRIE','Cabane de Bucheron'  ,'nom'         ,CoordX[cabBucheron]          ,CoordY[cabBucheron]             );
          affichageBatiment('INDUSTRIE','Cabane de Bucheron'  ,'quantity'    ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] + (1*margeY));
          affichageBatiment('INDUSTRIE','Cabane de Bucheron'  ,'production'  ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] + (2*margeY));
          affichageBatiment('INDUSTRIE','Cabane de Bucheron'  ,'necessite'   ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] + (3*margeY));
          // affichage bergerie
          affichageBatiment('INDUSTRIE','Bergerie'  ,'nom'                   ,CoordX[Bergerie]             ,CoordY[Bergerie]                );
          affichageBatiment('INDUSTRIE','Bergerie'  ,'quantity'              ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie]    + (1*margeY));
          affichageBatiment('INDUSTRIE','Bergerie'  ,'production'            ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie]    + (2*margeY));
          affichageBatiment('INDUSTRIE','Bergerie'  ,'necessite'             ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie]    + (3*margeY));
          // affichage atelier tisserand
          affichageBatiment('INDUSTRIE','Atelier de Tisserand'  ,'nom'       ,CoordX[Tiserand]             ,CoordY[Tiserand]                );
          affichageBatiment('INDUSTRIE','Atelier de Tisserand'  ,'quantity'  ,CoordX[Tiserand]    + margeX ,CoordY[Tiserand]    + (1*margeY));
          affichageBatiment('INDUSTRIE','Atelier de Tisserand'  ,'production',CoordX[Tiserand]    + margeX ,CoordY[Tiserand]    + (2*margeY));
          affichageBatiment('INDUSTRIE','Atelier de Tisserand'  ,'necessite' ,CoordX[Tiserand]    + margeX ,CoordY[Tiserand]    + (3*margeY));

    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu1}
  procedure affichageMenu1();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Inventaire batiments'); //procédure écrit nom menu

      dessinerCadreXY(5,8,115,25,simple,15,0); //dessine gros cadre habitat
      dessinerCadreXY(50,6,75,9,double,15,0); //dessine cadre etiquette habitat
      ecrireTexte('H A B I T A T',56,7);   // ecrit le texte habitat

      dessinerCadreXY(5,28,115,45,simple,15,0); //dessine gros cadre habitat
      dessinerCadreXY(50,26,75,29,double,15,0); //dessine cadre etiquette habitat
      ecrireTexte(' S O C I A L ',56,27);   // ecrit le texte habitat

      dessinerCadreXY(118,8,194,55,simple,15,0); //dessine gros cadre industrie
      dessinerCadreXY(145,6,170,9,double,15,0); //dessine cadre etiquette industrie
      ecrireTexte('I N D U S T R I E',150,7);   // ecrit le texte industrie

      // message pour le joueur
      dessinerCadreXY(5,4,45,6,double,15,0); //dessine cadre etiquette habitat
      ecrireTexte(message,6,5);   // ecrit le texte habitat

      printItemsMenu(totalItemsMenuGetBat,menu1,menu1X,menu1Y); //procédure qui affiche tous les items du menu en position X et Y
      affichageItemsBat_Habitat(itemsBatHabitatX, itemsBatHabitatY);
      affichageItemsBat_Social(itemsBatSocialX, itemsBatSocialY);
      affichageItemsBat_Industrie(itemsBatIndusX, itemsBatIndusY)
    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu2}
  procedure affichageMenu2();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Construction batiments'); //procédure écrit nom menu
      printItemsMenu(totalItemsMenuConstru,menu2,menu2X,menu2Y); //procédure qui affiche tous les items du menu en position X et Y
    end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainSMenuGBat();
     var
        running: Boolean; //variable booleenne qui permet de demarrer le menu
        runningMenuSuivant: Boolean; //variable booleenne permet de passer au menu2
     begin
        running:=True;
        runningMenuSuivant:=False;
        initiaNbTourBoucle;
        message:=''; // ininitialisation du message vide pour le joueur
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
                  affichageMenu1();// affichage des éléments du menu 1
                  colorierElementActu(10,30,menu1X,menu1Y);
                end
              //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
              else if(getNbTourBoucle>=1) then
                begin
                  touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                  touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                  setItemChoisie(touche);
                  navigationTabMenu(menu1,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                  colorierElementActu(10,30,menu1X,menu1Y);
                  reintialiserElementAnt(10,30,menu1X,menu1Y); //réintialise la couleur de l'item précedemment choisie
                end;
              incrementaNbTourBoucle(); //incrémentation du tour de boucle

              //choix dans le menu 1
              Case getItemChoisie() of
                1:
                  begin
                    //menu construction
                    effacerEcran;
                    running:=False;
                    runningMenuSuivant:=True;
                    initiaNbTourBoucle();  //initia nb tour boucle
                    while (runningMenuSuivant=True) do
                      begin
                        if (getNbTourBoucle()=0) then
                          begin
                              //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                              initialisationItemActuel(1);
                              //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                              initialisationItemAnterieur();
                              initItemChoisie();  //initia item choisie
                              //affichage
                              affichageMenu2(); //affichage de tous les éléments du menu2
                              colorierElementActu(10,30,menu2X,menu2Y);
                          end
                        else if (getNbTourBoucle>=1) then
                          begin
                              touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                              touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                              setItemChoisie(touche);
                              navigationTabMenu(menu2,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                              colorierElementActu(10,30,menu2X,menu2Y);
                              reintialiserElementAnt(10,30,menu2X,menu2Y); //réintialise la couleur de l'item précedemment choisie
                          end;
                        incrementaNbTourBoucle(); //incrémentation du tour de boucle

                        //choix batiments à construire dans le menu 2
                        Case getItemChoisie() of
                          1: begin
                                  message:=Build_Batiment('HABITAT', 'Maison de Colon');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          3: begin
                                  message:=Build_Batiment('SOCIAL', 'Centre-Ville');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          4: begin
                                  message:=Build_Batiment('SOCIAL', 'Chapelle');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          5: begin
                                  message:=Build_Batiment('INDUSTRIE', 'Cabane de Pecheur');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          6: begin
                                  message:=Build_Batiment('INDUSTRIE', 'Cabane de Bucheron');
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          7: begin
                                  message:=Build_Batiment('INDUSTRIE', 'Bergerie');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;

                          8: begin
                                  message:=Build_Batiment('INDUSTRIE', 'Atelier de Tisserand');
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          9: //item 8 du menu => menu précédent
                             begin
                                 initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                 initItemChoisie();
                                 runningMenuSuivant:=False;
                                 running:=true;
                             end;
                        end; //fin case of

                      end; //fin tant que

                    end; //fin case of 1

                2:
                   begin
                       effacerEcran; //raffraichissement de l'écran
                       running:=False; //fin du sMenuGestionBatiments
                   end;

              end; //fin case of

            end; //fin tant que

     end; //fin procédure
end.

