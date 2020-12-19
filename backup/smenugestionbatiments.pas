{$codepage utf8}
unit sMenuGestionBatiments ;

{$mode objfpc}{$H+}

interface

  uses
    gestionecran,navigationMenues,Keyboard,bouclesJeux,personnage, unitBuilding,population; //appel des unités

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainSMenuGBat();

implementation
//déclaration des constantes de toute l'unité
const
  //nb d'items dans le sous menu
  totalItemsMenuGetBat    = 2;
  totalItemsMenuConstruColons   = 10;
  totalItemsMenuConstruCitoyen = 19;

  //nb d'item de batiments
  totalItemBatiments        = 9;
  totalItemBatimentsHabitat = 2; // batiment de type HABITAT
  totalItemBatimentsIndus   = 13; // batiment de type INDUSTRIE
  totalItemBatimentsSocial  = 2; // batiment de type SOCIAL


  //déclaration des items du menu
  txtConsBat  = 'Construire un bâtimement'; //constante de type string : item du sMenu
  txtMenuPrec = 'Menu précédent';

  //abcisses texte menu
  consBatX  =60;
  menuPrecX =60;

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
  txtCaPecheur          ='Cabane de pecheur';
  txtCaBucheron         ='Cabane de bucheron';
  txtBergerie           ='Bergerie';
  txtAtelierTisserand   ='Atelier Tisserand';
  txtEntrepot           ='Entrepot'         ;
  txtFermeBle           = 'Ferme à blé'; //string qui apparait que si les citoyens sont débloqués
  txtFournil            = 'Fournil'; //string qui apparait que si les citoyens sont débloqués
  txtPlantaCanne        = 'Plantation de canne à sucre'; //string qui apparait que si les citoyens sont débloqués
  txtDistilerie         = 'Distilerie'; //string qui apparait que si les citoyens sont débloqués
  txtArgiliere          = 'Argiliere'; //string qui apparait que si les citoyens sont débloqués
  txtBriqueterie        = 'Briqueterie'; //string qui apparait que si les citoyens sont débloqués
  txtMine               = 'Mine'; //string qui apparait que si les citoyens sont débloqués
  txtFonderie           = 'Fonderie'; //string qui apparait que si les citoyens sont débloqués
  txtOutillerie         = 'Outillerie'; //string qui apparait que si les citoyens sont débloqués

  //Abcisses texte batiments
  txtMaisonX            = 10;
  txtVillaX             = 10;
  txtCentreVilleX       = 10;
  txtChapelleX          = 10;
  txtCaPecheurX         = 10;
  txtCaBucheronX        = 10;
  txtBergerieX          = 10;
  txtAtelierTisserandX  = 10;
  txtEntrepotX          = 10;

  txtFermeBleX          = 110;
  txtFournilX           = 110;
  txtPlantaCanneX       = 110;
  txtDistilerieX        = 110;
  txtArgiliereX         = 110;
  txtBriqueterieX       = 110;
  txtMineX              = 110;
  txtFonderieX          = 110;
  txtOutillerieX        = 110;

  //Ordonnées texte batiments
  txtMaisonY            = 12;
  txtVillaY             = 15;
  txtCentreVilleY       = 18;
  txtChapelleY          = 21;
  txtCaPecheurY         = 24;
  txtCaBucheronY        = 27;
  txtBergerieY          = 30;
  txtAtelierTisserandY  = 33;
  txtEntrepotY          = 36;

  //apparait que si les citoyens sont débloqués
  txtFermeBleY          = 12;
  txtFournilY           = 15;
  txtPlantaCanneY       = 18;
  txtDistilerieY        = 21;
  txtArgiliereY         = 24;
  txtBriqueterieY       = 27;
  txtMineY              = 30;
  txtFonderieY          = 33;
  txtOutillerieY        = 36;


  // BATIMENT HABITAT coordonnées
  //abscisses habitat
  MaisonX        = 10;
  villaX         = 10;

  // ordonnées habitat
  MaisonY        = 17;
  villaY         = 17 + 5;

  // BATIMENT HABITAT coordonnées
  // abscisses habitat
  CentreVilleX        = 10;
  ChapelleX           = 10;
  //ordonnées habitat
  CentreVilleY        = 31;
  ChapelleY           = 31 + 5;

  //BATIMENT STOCKAGE
  EntrepotX           = 70;
  EntrepotY           = 31;

  // BATIMENT INDUSTRIE coordonnées
  // abcisses industrie
  CabPecheurX        = 104;
  CabBucheronX       = 104;
  BergerieX          = 104;
  TisserandX         = 104;
  //apparait que si les citoyens sont débloqués
  FermeBleX          = 104;
  FournilX           = 104;
  PlantaCanneX       = 104;
  DistilerieX        = 104;
  ArgiliereX         = 104;
  BriqueterieX       = 104;
  MineX              = 104;
  FonderieX          = 104;
  OutillerieX        = 104;
  //ordonnées industrie
  CabPecheurY        = 10;
  CabBucheronY       = 10 + 3;
  BergerieY          = 10 + 6;
  TisserandY         = 10 + 9;
  //apparait que si les citoyens sont débloqués
  FermeBleY          = 10 + 12;
  FournilY           = 10 + 15;
  PlantaCanneY       = 10 + 18;
  DistilerieY        = 10 + 21;
  ArgiliereY         = 10 + 24;
  BriqueterieY       = 10 + 27;
  MineY              = 10 + 30;
  FonderieY          = 10 + 33;
  OutillerieY        = 10 + 36;

  // sorte HABITAT
  B_Maison= 1; B_Villa= 2; //maison des citoyens et colons
  // sorte INDUSTRIE
  B_Fisher= 5;B_Bucheron= 6;B_Bergerie= 7;B_Tisserand= 8; B_FermeBle= 9;
  // sorte SOCIAL
  B_Chapelle= 3; B_CentreVille= 4;
  // sorte INDUSTRIE
  B_Fournil=10;
  B_PlantaCanne=11;
  B_Distillerie=12;
  B_Argiliere=13;
  B_Briqueterie=14;
  B_Mine=15;
  B_Fonderie=16;
  B_Outilleur=17;
  //sorte STOCKAGE
  B_Entrepot = 18;


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

   tabCoordXItemBatStockage= array[1..1] of Integer;
   tabCoordYItemBatStockage= array[1..1] of Integer;

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
   //tableau qui contient les items présent dans le menu construction lorsqu'il y a juste des colons
   menu2ConstruColons: array[1..totalItemsMenuConstruColons] of String  = (txtMenuPrec,txtMaison,txtVilla,txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtEntrepot);
   //tableau qui contient les items présent dans le menu construction lorsque les citoyens ont été débloqué
   menu2ConstruCitoyens: array[1..totalItemsMenuConstruCitoyen] of String = (txtMenuPrec,txtMaison,txtVilla,txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtEntrepot,txtFermeBle,txtFournil,txtPlantaCanne,txtDistilerie,txtArgiliere,txtBriqueterie,txtMine,txtFonderie,txtOutillerie);


   //tableau contient coordonnées des items du menu1
   menu1X: array[1..totalItemsMenuGetBat] of Integer = (consBatX,menuPrecX);
   menu1Y: array[1..totalItemsMenuGetBat] of Integer = (consBatY,menuPrecY);

   //tableau qui contient les coordonnées des items du menu construction colons   (apparait lorsque les citoyens ne sont pas débloqués)
   menu2ConstruColonsX: array[1..totalItemsMenuConstruColons] of Integer  = (menuPrecX,txtMaisonX,txtVillaX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX,txtEntrepotX);
   menu2ConstruColonsY: array[1..totalItemsMenuConstruColons] of Integer = (menuPrecY,txtMaisonY,txtVillaY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY,txtEntrepotY);

   //tableau qui contient les coordonnées des items du menu construction citoyens (apparait lorsque les citoyens sont débloqués)
   menu2ConstruCitoyensX: array[1..totalItemsMenuConstruCitoyen] of Integer  = (menuPrecX,txtMaisonX,txtVillaX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX,txtEntrepotX,txtFermeBleX,txtFournilX,txtPlantaCanneX,txtDistilerieX,txtArgiliereX,txtBriqueterieX,txtMineX,txtFonderieX,txtOutillerieX);
   menu2ConstruCitoyensY: array[1..totalItemsMenuConstruCitoyen] of Integer =  (menuPrecY,txtMaisonY,txtVillaY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY,txtEntrepotY,txtFermeBleY,txtFournilY,txtPlantaCanneY,txtDistilerieY,txtArgiliereY,txtBriqueterieY,txtMineY,txtFonderieY,txtOutillerieY);

   //tableau qui contient les textes des items batiments
   itemsBat:tabItemBatiments=(txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtMaison,txtVilla,txtEntrepot);
   //tableau qui contient les coordonnées des items batiments
   itemsBatX: tabCoordXItemBatiments=(txtMaisonX,txtVillaX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX,txtEntrepotX);
   itemsBatY: tabCoordYItemBatiments=(txtMaisonY,txtVillaY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY,txtEntrepotY);

   //tableau qui contient les coordonnées des items batiments HABITAT
   itemsBatHabitatX: tabCoordXItemBatHabitat=(MaisonX,villaX);
   itemsBatHabitatY: tabCoordYItemBatHabitat=(MaisonY,villaY);

   //tableau qui contient les coordonnées des items batiments SOCIAL
   itemsBatSocialX: tabCoordXItemBatSocial=(CentreVilleX, ChapelleX);
   itemsBatSocialY: tabCoordYItemBatSocial=(CentreVilleY, ChapelleY);

   //tableau qui contient les coordonnées de l'item bat STOCKAGE
   itemsBatStockageX: tabCoordXItemBatStockage= (EntrepotX);
   itemsBatStockageY: tabCoordYItemBatStockage= (EntrepotY);

   //tableau qui contient les coordonnées des items batiments INDUSTRIE
   itemsBatIndusX: tabCoordXItemBatIndus=(CabPecheurX,CabBucheronX,BergerieX,TisserandX,FermeBleX,FournilX,PlantaCanneX,DistilerieX,ArgiliereX,BriqueterieX,MineX,FonderieX,OutillerieX);
   itemsBatIndusY: tabCoordYItemBatIndus=(CabPecheurY,CabBucheronY,BergerieY,TisserandY,FermeBleY,FournilY,PlantaCanneY,DistilerieY,ArgiliereY,BriqueterieY,MineY,FonderieY,OutillerieY);

  procedure affichageItemsBat_Habitat(CoordX: tabCoordXItemBatHabitat; CoordY: tabCoordYItemBatHabitat);
      const
         margeX = 4;  // marge x des textes infos de chaque batiment
         margeY = 1;  // marge y

         // permet de changer l'ordre d'affichage des batiments
         Maison  = 1;
         villa   =2;
        begin
          // affichage maison de colon
          affichageBatiment(B_Maison,'nom'         ,CoordX[Maison]          ,CoordY[Maison]);
          affichageBatiment(B_Maison,'quantity'    ,CoordX[Maison] + margeX ,CoordY[Maison] + (1*margeY));
          //affichageBatiment(1,'necessite'   ,CoordX[Maison] + margeX ,CoordY[Maison] + (2*margeY));

          affichageBatiment(B_Villa,'nom'         ,CoordX[villa]          ,CoordY[villa]);
          affichageBatiment(B_Villa,'quantity'    ,CoordX[villa] + margeX ,CoordY[villa] + (1*margeY));
          //affichageBatiment(8,'necessite'   ,CoordX[villa] + margeX ,CoordY[villa] + (2*margeY));
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
          affichageBatiment(B_CentreVille,'nom'         ,CoordX[CentreVille]          ,CoordY[CentreVille]);
          affichageBatiment(B_CentreVille,'quantity'    ,CoordX[CentreVille] + margeX ,CoordY[CentreVille] + (1*margeY));
          //affichageBatiment(7,'necessite'   ,CoordX[CentreVille] + margeX ,CoordY[CentreVille] + (2*margeY));
          // affichage chapelle
          affichageBatiment(B_Chapelle,'nom'         ,CoordX[Chapelle]          ,CoordY[Chapelle]);
          affichageBatiment(B_Chapelle,'quantity'    ,CoordX[Chapelle] + margeX ,CoordY[Chapelle] + (1*margeY));
          //affichageBatiment(6,'necessite'   ,CoordX[Chapelle] + margeX ,CoordY[Chapelle] + (2*margeY));
    end;

  procedure affichageItemBatStockage(CoordX:tabCoordXItemBatStockage; CoordY: tabCoordYItemBatStockage);
    begin
       affichageBatiment(B_Entrepot,'nom'         ,CoordX[1]          ,CoordY[1]);
       affichageBatiment(B_Entrepot,'quantity'    ,CoordX[1] + 4 ,CoordY[1] + 1);
    end;

  procedure affichageItemsBat_Industrie(CoordX: tabCoordXItemBatIndus; CoordY: tabCoordYItemBatIndus);
        const
         margeX = 25;  // marge x des textes infos de chaque batiment
         margeY = 1;  // marge y

         // permet de changer l'ordre d'affichage des batiments
         cabPecheur  = 1;
         cabBucheron = 2;
         Bergerie    = 3;
         Tiserand    = 4;
         fermeBle    = 5;
         Fournil     = 6;
         PlantaCanne = 7;
         Distilerie  = 8;
         Argiliere   = 9;
         Briqueterie = 10;
         Mine        = 11;
         Fonderie    = 12;
         Outillerie  = 13;

    begin
          // affichage cabane de pecheur
          affichageBatiment(B_Fisher,'nom'         ,CoordX[cabPecheur]          ,CoordY[cabPecheur]);
          affichageBatiment(B_Fisher,'quantity'    ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur] );
          affichageBatiment(B_Fisher,'production'  ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur]   + margeY);
          //affichageBatiment(2,'necessite'   ,CoordX[cabPecheur] + margeX ,CoordY[cabPecheur]   + (3*margeY));
          // affichage cabane de bucheron
          affichageBatiment(B_Bucheron,'nom'         ,CoordX[cabBucheron]          ,CoordY[cabBucheron]);
          affichageBatiment(B_Bucheron,'quantity'    ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] );
          affichageBatiment(B_Bucheron,'production'  ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] + (1*margeY) );
          //affichageBatiment(3,'necessite'   ,CoordX[cabBucheron] + margeX ,CoordY[cabBucheron] + (3*margeY));
          // affichage bergerie
          affichageBatiment(B_Bergerie,'nom'                   ,CoordX[Bergerie]             ,CoordY[Bergerie] );
          affichageBatiment(B_Bergerie,'quantity'              ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie] );
          affichageBatiment(B_Bergerie,'production'            ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie]    + (1*margeY));
          //affichageBatiment(4,'necessite'             ,CoordX[Bergerie]    + margeX ,CoordY[Bergerie]    + (3*margeY));
          // affichage atelier tisserand
          affichageBatiment(B_Tisserand,'nom'       ,CoordX[Tiserand]             ,CoordY[Tiserand]);
          affichageBatiment(B_Tisserand,'quantity'  ,CoordX[Tiserand]    + margeX ,CoordY[Tiserand] );
          affichageBatiment(B_Tisserand,'production',CoordX[Tiserand]    + margeX ,CoordY[Tiserand]    + (1*margeY));
          affichageBatiment(B_Tisserand,'necessite' ,CoordX[Tiserand]    + margeX ,CoordY[Tiserand]    + (2*margeY));

          //si les citoyens sont débloqué alors affiche quantite bat
          if (getNbHabCatePop(2)>0) then
            begin
               //Bat débloqués par les CITOYENS
              // affichage usine ble
              affichageBatiment(B_FermeBle,'nom'         ,CoordX[fermeBle]          ,CoordY[fermeBle]);
              affichageBatiment(B_FermeBle,'quantity'    ,CoordX[fermeBle] + margeX ,CoordY[fermeBle] );
              affichageBatiment(B_FermeBle,'production'  ,CoordX[fermeBle] + margeX ,CoordY[fermeBle]   + (1*margeY));

              affichageBatiment(B_Fournil,'nom'          ,CoordX[Fournil]             ,CoordY[Fournil]);
              affichageBatiment(B_Fournil,'quantity'  ,CoordX[Fournil]    + margeX ,CoordY[Fournil] );
              affichageBatiment(B_Fournil,'production',CoordX[Fournil]    + margeX ,CoordY[Fournil]    + (1*margeY));
              affichageBatiment(B_Fournil,'necessite' ,CoordX[Fournil]    + margeX ,CoordY[Fournil]    + (2*margeY));

              affichageBatiment(B_PlantaCanne,'nom'         ,CoordX[PlantaCanne]          ,CoordY[PlantaCanne]);
              affichageBatiment(B_PlantaCanne,'quantity'    ,CoordX[PlantaCanne] + margeX ,CoordY[PlantaCanne] );
              affichageBatiment(B_PlantaCanne,'production'  ,CoordX[PlantaCanne] + margeX ,CoordY[PlantaCanne]   + (1*margeY));

              affichageBatiment(B_Distillerie,'nom'       ,CoordX[Distilerie]             ,CoordY[Distilerie]);
              affichageBatiment(B_Distillerie,'quantity'  ,CoordX[Distilerie]    + margeX ,CoordY[Distilerie] );
              affichageBatiment(B_Distillerie,'production',CoordX[Distilerie]    + margeX ,CoordY[Distilerie]    + (1*margeY));
              //affichageBatiment(B_Distillerie,'necessite' ,CoordX[Distilerie]    + margeX ,CoordY[Distilerie]    + (2*margeY));

              affichageBatiment(B_Argiliere,'nom'         ,CoordX[Argiliere]          ,CoordY[Argiliere]);
              affichageBatiment(B_Argiliere,'quantity'    ,CoordX[Argiliere] + margeX ,CoordY[Argiliere] );
              affichageBatiment(B_Argiliere,'production'  ,CoordX[Argiliere] + margeX ,CoordY[Argiliere]   + (1*margeY));

              affichageBatiment(B_Briqueterie,'nom'       ,CoordX[Briqueterie]             ,CoordY[Briqueterie]);
              affichageBatiment(B_Briqueterie,'quantity'  ,CoordX[Briqueterie]    + margeX ,CoordY[Briqueterie] );
              affichageBatiment(B_Briqueterie,'production',CoordX[Briqueterie]    + margeX ,CoordY[Briqueterie]    + (1*margeY));
              affichageBatiment(B_Briqueterie,'necessite' ,CoordX[Briqueterie]    + margeX ,CoordY[Briqueterie]    + (2*margeY));

              affichageBatiment(B_Mine,'nom'         ,CoordX[Mine]          ,CoordY[Mine]);
              affichageBatiment(B_Mine,'quantity'    ,CoordX[Mine] + margeX ,CoordY[Mine] );
              affichageBatiment(B_Mine,'production'  ,CoordX[Mine] + margeX ,CoordY[Mine]   + (1*margeY));

              affichageBatiment(B_Fonderie,'nom'       ,CoordX[Fonderie]             ,CoordY[Fonderie]);
              affichageBatiment(B_Fonderie,'quantity'  ,CoordX[Fonderie]    + margeX ,CoordY[Fonderie] );
              affichageBatiment(B_Fonderie,'production',CoordX[Fonderie]    + margeX ,CoordY[Fonderie]    + (1*margeY));
              affichageBatiment(B_Fonderie,'necessite' ,CoordX[Fonderie]    + margeX ,CoordY[Fonderie]    + (2*margeY));

              affichageBatiment(B_Outilleur,'nom'       ,CoordX[Outillerie]             ,CoordY[Outillerie]);
              affichageBatiment(B_Outilleur,'quantity'  ,CoordX[Outillerie]    + margeX ,CoordY[Outillerie] );
              affichageBatiment(B_Outilleur,'production',CoordX[Outillerie]    + margeX ,CoordY[Outillerie]    + (1*margeY));
              affichageBatiment(B_Outilleur,'necessite' ,CoordX[Outillerie]    + margeX ,CoordY[Outillerie]    + (2*margeY));
            end;

    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu1}
  procedure affichageMenu1();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Inventaire batiments'); //procédure écrit nom menu

      dessinerCadreXY(5,14,60,25,simple,15,0); //dessine gros cadre habitat
      dessinerCadreXY(23,12,43,15,double,15,0); //dessine cadre etiquette habitat
      ecrireTexte('H A B I T A T',27,13);   // ecrit le texte habitat

      dessinerCadreXY(5,28,60,45,simple,15,0); //dessine gros cadre social
      dessinerCadreXY(23,26,43,29,double,15,0); //dessine cadre etiquette social
      ecrireTexte(' S O C I A L ',27,27);   // ecrit le texte habitat

      dessinerCadreXY(65,28,95,45,simple,15,0); //dessine gros cadre stockage
      dessinerCadreXY(72,26,90,29,double,15,0); //dessine cadre etiquette stockage
      ecrireTexte(' S T O C K A G E',73,27);   // ecrit le texte habitat

      dessinerCadreXY(100,8,194,55,simple,15,0); //dessine gros cadre industrie
      dessinerCadreXY(135,6,160,9,double,15,0); //dessine cadre etiquette industrie
      ecrireTexte('I N D U S T R I E',140,7);   // ecrit le texte industrie

      // message pour le joueur
      dessinerCadreXY(5,6,97,8,double,15,0); //dessine cadre etiquette habitat
      ecrireTexte('Action: ',7,7);   // ecrit le texte d'action
      ecrireTexte(message,15,7);   // ecrit le resultat de l'action faite

      printItemsMenu(totalItemsMenuGetBat,menu1,menu1X,menu1Y); //procédure qui affiche tous les items du menu en position X et Y
      affichageItemBatStockage(itemsBatStockageX,itemsBatStockageY);
      affichageItemsBat_Habitat(itemsBatHabitatX, itemsBatHabitatY);
      affichageItemsBat_Social(itemsBatSocialX, itemsBatSocialY);
      affichageItemsBat_Industrie(itemsBatIndusX, itemsBatIndusY);
    end;

  {procedure qui initialise l'affichage}
  procedure initItemsMenu2();
    const
       txtCout= ' | cout |   ';
       longMaxTxt=20;
    begin
       menu2ConstruColons[2]:=txtIndentation(txtMaison,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Maison);
       menu2ConstruColons[3]:=txtIndentation(txtVilla,longMaxTxt) +txtCout+getBat_Cost_Txt(B_Villa);
       menu2ConstruColons[4]:=txtIndentation(txtCentreVille,longMaxTxt)+txtCout+getBat_Cost_Txt(B_CentreVille);
       menu2ConstruColons[5]:=txtIndentation(txtChapelle,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Chapelle);
       menu2ConstruColons[6]:=txtIndentation(txtCaPecheur,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Fisher);
       menu2ConstruColons[7]:=txtIndentation(txtCaBucheron,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Bucheron);
       menu2ConstruColons[8]:=txtIndentation(txtBergerie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Bergerie);
       menu2ConstruColons[9]:=txtIndentation(txtAtelierTisserand,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Tisserand);
       menu2ConstruColons[10]:=txtIndentation(txtEntrepot,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Entrepot);

       menu2ConstruCitoyens[2]:=txtIndentation(txtMaison,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Maison);
       menu2ConstruCitoyens[3]:=txtIndentation(txtVilla,longMaxTxt) +txtCout+getBat_Cost_Txt(B_Villa);
       menu2ConstruCitoyens[4]:=txtIndentation(txtCentreVille,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Bergerie);
       menu2ConstruCitoyens[5]:=txtIndentation(txtChapelle,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Chapelle);
       menu2ConstruCitoyens[6]:=txtIndentation(txtCaPecheur,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Fisher);
       menu2ConstruCitoyens[7]:=txtIndentation(txtCaBucheron,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Bucheron);
       menu2ConstruCitoyens[8]:=txtIndentation(txtBergerie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Bergerie);
       menu2ConstruCitoyens[9]:=txtIndentation(txtAtelierTisserand,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Tisserand);
       menu2ConstruCitoyens[10]:=txtIndentation(txtEntrepot,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Entrepot);
       //si les citoyens sont débloqués => init de l'affichage des coûts des bats spécifique à leur arrivée
       if (getNbHabCatePop(2)>0) then
         begin
            menu2ConstruCitoyens[11]:= txtIndentation(txtFermeBle,longMaxTxt)+txtCout+getBat_Cost_Txt(B_FermeBle); //affiche cout construct ferme ble
            menu2ConstruCitoyens[12]:= txtIndentation(txtFournil,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Fournil); //affiche cout construct du fournil
            menu2ConstruCitoyens[13]:= txtIndentation(txtPlantaCanne,longMaxTxt)+txtCout+getBat_Cost_Txt(B_PlantaCanne); //affiche cout construct de la plantation de canne à sucre
            menu2ConstruCitoyens[14]:= txtIndentation(txtDistilerie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Distillerie); //affiche cout construct distillerie
            menu2ConstruCitoyens[15]:= txtIndentation(txtArgiliere,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Argiliere); //affiche cout construct argilerie
            menu2ConstruCitoyens[16]:= txtIndentation(txtBriqueterie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Briqueterie); //affiche cout construct briqueterie
            menu2ConstruCitoyens[17]:= txtIndentation(txtMine,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Mine); //affiche cout construct mine
            menu2ConstruCitoyens[18]:= txtIndentation(txtFonderie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Fonderie); //affiche cout construct fonderie
            menu2ConstruCitoyens[19]:= txtIndentation(txtOutillerie,longMaxTxt)+txtCout+getBat_Cost_Txt(B_Outilleur); //affiche cout construct de l'outillerie
         end;
    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu2}
  procedure affichageMenu2();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Construction batiments'); //procédure écrit nom menu
      //si les citoyens ne sont pas débloqué
      if (getNbHabCatePop(2)<1) then
        printItemsMenu(totalItemsMenuConstruColons,menu2ConstruColons,menu2ConstruColonsX,menu2ConstruColonsY) //procédure qui affiche tous les items du menu en position X et Y
      else //sinon affichage des items du menu quand les citoyens sont débloqués
        printItemsMenu(totalItemsMenuConstruCitoyen,menu2ConstruCitoyens,menu2ConstruCitoyensX,menu2ConstruCitoyensY);
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
                //choix 1=> menu construction
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
                              initItemsMenu2();
                              //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                              initialisationItemActuel(2);
                              //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                              initialisationItemAnterieur();
                              initItemChoisie();  //initia item choisie
                              //affichage
                              affichageMenu2(); //affichage de tous les éléments du menu2
                              //si citoyens débloqués => menu citoyens
                              if (getNbHabCatePop(2)>0) then
                                 colorierElementActu(2,80,menu2ConstruCitoyensX,menu2ConstruCitoyensY)
                              //si citoyens non débloqués => menu colons
                              else
                                 colorierElementActu(2,80,menu2ConstruColonsX,menu2ConstruColonsY);
                          end
                        else if (getNbTourBoucle>=1) then
                          begin
                              touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                              touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                              setItemChoisie(touche);
                              //si citoyens débloqués => menu citoyens
                              if (getNbHabCatePop(2)>0) then
                                begin
                                 navigationTabMenu(menu2ConstruCitoyens,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu
                                 colorierElementActu(2,80,menu2ConstruCitoyensX,menu2ConstruCitoyensY);
                                 reintialiserElementAnt(2,80,menu2ConstruCitoyensX,menu2ConstruCitoyensY); //réintialise la couleur de l'item précedemment choisie
                                end
                              //si citoyens non débloqués => menu colons
                              else
                                begin
                                 navigationTabMenu(menu2ConstruColons,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu
                                 colorierElementActu(2,80,menu2ConstruColonsX,menu2ConstruColonsY);
                                 reintialiserElementAnt(2,80,menu2ConstruColonsX,menu2ConstruColonsY); //réintialise la couleur de l'item précedemment choisie
                                end;
                          end;
                        incrementaNbTourBoucle(); //incrémentation du tour de boucle

                        //choix batiments à construire dans le menu 2
                        Case getItemChoisie() of
                          1: //item 1 du menu => menu précédent
                             begin
                                 initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                 initItemChoisie();
                                 runningMenuSuivant:=False;
                                 running:=true;
                             end;
                          2: begin
                                  message:=Build_Batiment(B_Maison,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          3:
                            begin
                                  message:=Build_Batiment(B_Villa,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                            end;
                          4: begin
                                  message:=Build_Batiment(B_CentreVille,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          5: begin
                                  message:=Build_Batiment(B_Chapelle,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          6: begin
                                  message:=Build_Batiment(B_Fisher,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          7: begin
                                  message:=Build_Batiment(B_Bucheron,getEtatAllBesoinsColons());
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          8: begin
                                  message:=Build_Batiment(B_Bergerie,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;

                          9: begin
                                  message:=Build_Batiment(B_Tisserand,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          10: begin
                                  message:=Build_Batiment(B_Entrepot,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;

                              end;
                          11:
                             begin
                                  message:=Build_Batiment(B_FermeBle,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          12:
                             begin
                                  message:=Build_Batiment(B_Fournil,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          13:
                             begin
                                  message:=Build_Batiment(B_PlantaCanne,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          14:
                             begin
                                  message:=Build_Batiment(B_Distillerie,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          15:
                             begin
                                  message:=Build_Batiment(B_Argiliere,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          16:
                             begin
                                  message:=Build_Batiment(B_Briqueterie,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          17:
                             begin
                                  message:=Build_Batiment(B_Mine,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          18:
                             begin
                                  message:=Build_Batiment(B_Fonderie,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
                                  runningMenuSuivant:=False;
                                  running:=true;
                             end;
                          19:
                             begin
                                  message:=Build_Batiment(B_Outilleur,getEtatAllBesoinsColons());
                                  initItemChoisie();
                                  initiaNbTourBoucle(); //initialisation  nb Tour boucle
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


