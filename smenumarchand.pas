unit sMenuMarchand ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils , bouclesJeux, gestionEcran , Keyboard , navigationMenues , unitRessources ;

  procedure mainSMenuMarchand(piraterie:Boolean);
  procedure initTauxAppaMarchand(valeur: Integer);

implementation
  const
    //nb d'items dans le menu
    totalItemsMenu = 11;

    //Déclaration des items de notre menu initial
    txtPayWood             ='Acheter 5 bois'; //constante de type string qui est le 1er item du menu
    txtPayFish             ='Acheter 5 poissons'; //constante de type string qui est le 2ème item du menu
    txtPayLaine            ='Acheter 5 laine'; //constante de type string qui est le 3ème item du menu
    txtPayTissu            ='Acheter 5 tissu';
    txtPayTool             ='Acheter 5 Outils';

    txtSendWood             ='Vendre 5 bois'; //constante de type string qui est le 1er item du menu
    txtSendFish             ='Vendre 5 poissons'; //constante de type string qui est le 2ème item du menu
    txtSendLaine            ='Vendre 5 laine'; //constante de type string qui est le 3ème item du menu
    txtSendTissu            ='Vendre 5 tissu';
    txtSendTool             ='Vendre 5 Outils';

    txtNoPay                ='Ne rien acheter';

    //Déclaration des abcisses de notre menu
    txtPayWoodX           =15; //abcisse de txtSuivant
    txtPayFishX           =15; //abcisse de txtGestionbatiment
    txtPayLaineX          =15; //abcisse de txtGestionbatiment
    txtPayTissuX          =15;  //abcisse de txtGestionbatiment
    txtPayToolX           =15; //abcisse de txtTest2

    txtSendWoodX          =100; //constante de type string qui est le 1er item du menu
    txtSendFishX          =100; //constante de type string qui est le 2ème item du menu
    txtSendLaineX         =100; //constante de type string qui est le 3ème item du menu
    txtSendTissuX         =100;
    txtSendToolX          =100;

    txtNoPayX             =90;

    //Déclaration des ordonnées de notre menu
    txtPayWoodY           =10; //ordonnée de txtSuivant
    txtPayFishY           =12; //ordonnée de txtGestionbatiment
    txtPayLaineY          =14; //ordonnée de txtGestionbatiment
    txtPayTissuY          =16;  //ordonnée de txtGestionbatiment
    txtPayToolY           =18; //ordonnée de txtTest2

    txtSendWoodY          =10; //constante de type string qui est le 1er item du menu
    txtSendFishY          =12; //constante de type string qui est le 2ème item du menu
    txtSendLaineY         =14; //constante de type string qui est le 3ème item du menu
    txtSendTissuY         =16;
    txtSendToolY          =18;

    txtNoPayY             =50;

  var
    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard
    menuMarchand: array[1..totalItemsMenu] of String = (txtPayWood,txtPayFish,txtPayLaine,txtPayTissu,txtPayTool,txtSendWood,txtSendFish,txtSendLaine,txtSendTissu,txtSendTool,txtNoPay);

    itemsCoordX: array[1..totalItemsMenu] of Integer = (txtPayWoodX,txtPayFishX,txtPayLaineX,txtPayTissuX,txtPayToolX,txtSendWoodX,txtSendFishX,txtSendLaineX,txtSendTissuX,txtSendToolX,txtNoPayX);
    itemsCoordY: array[1..totalItemsMenu] of Integer = (txtPayWoodY,txtPayFishY,txtPayLaineY,txtPayTissuY,txtPayToolY,txtSendWoodY,txtSendFishY,txtSendLaineY,txtSendTissuY,txtSendToolY,txtNoPayY);

    nbTauxAppaMenu: Integer;

  procedure initTauxAppaMarchand(valeur: Integer);
    begin
       nbTauxAppaMenu:= valeur;
    end;

  procedure affichage();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Le marchand'); //procédure écrit nom menu
      //affichageItemsMenu();
      printItemsMenu(totalItemsMenu,menuMarchand,itemsCoordX,itemsCoordY);
    end;

  procedure mainSMenuMarchand(piraterie:Boolean);
    var
      running: Boolean;
      nbAleatoire: Integer;
    begin
       randomize; //initialisation de random
       nbAleatoire:=random(nbTauxAppaMenu);
       //menu lance si nbAleatoire = nbTrue et event piraterie = false
       if ((nbAleatoire= 1) and (piraterie=False)) then
         begin
           running:=True; //on lance le menu
           initiaNbTourBoucle(); //initialisation du nb de tour de boucle quand on arrive sur le me
           while (running=True) do
             begin
               //si on vient d'arriver sur le menu on initialise l'affichage des éléments du menu, initialisation de l'item actuel à 1 etc
               if (getNbTourBoucle()=0) then
                   begin
                     effacerEcran; //raffraichissement écran
                     initItemChoisie(); //initialisation de l'itemChoisie
                     //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                     initialisationItemActuel(1);
                     //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                     initialisationItemAnterieur();
                     affichage();
                     //colorierElementActuel(10,50); //initialisation de colorierElementActuel
                     colorierElementActu(10,50,itemsCoordX,itemsCoordY);
                   end
               //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
               else if(getNbTourBoucle>=1) then
                   begin
                      touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                      touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                      setItemChoisie(touche);
                      navigationTabMenu(menuMarchand,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                      colorierElementActu(10,50,itemsCoordX,itemsCoordY);
                      reintialiserElementAnt(10,50,itemsCoordX,itemsCoordY);
                   end;
                   incrementaNbTourBoucle(); //incrémentation du tour de boucle

                   case (getItemChoisie()) of
                     1:
                      begin
                        writeln(menuMarchand[1]);
                        setWood(5);
                        setGold(-getPriceRessource(wood));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;
                     2:
                      begin
                        writeln(menuMarchand[2]);
                        setFish(5);
                        setGold(-getPriceRessource(fish));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;

                     3:
                      begin
                        writeln(menuMarchand[3]);
                        setLaine(5);
                        setGold(-getPriceRessource(laine));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;

                     4:
                      begin
                        writeln(menuMarchand[4]);
                        setTissu(5);
                        setGold(-getPriceRessource(tissu));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;

                     5:
                      begin
                        writeln(menuMarchand [5]);
                        setTool(5);
                        setGold(-getPriceRessource(tool));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;
                     6:
                      begin
                        writeln(menuMarchand [6]);
                        setWood(-5);
                        setGold(getPriceRessource(wood));
                        initItemChoisie(); //initialisation de l'itemChoisie
                      end;
                     7:
                      begin
                        writeln(menuMarchand [7]);
                        setFish(-5);
                        setGold(getPriceRessource(fish));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;

                     8:
                      begin
                        writeln(menuMarchand [8]);
                        setLaine(-5);
                        setGold(getPriceRessource(laine));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;
                     9:
                      begin
                        writeln(menuMarchand [9]);
                        setTissu(-5);
                        setGold(getPriceRessource(tissu));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;
                     10:
                      begin
                        writeln(menuMarchand [10]);
                        setTool(-5);
                        setGold(getPriceRessource(tool));
                        initItemChoisie(); //initialisation de l'itemChoisie
                        running:=False;
                      end;
                     11: running:=False;
                   end;
               end;
           end;
    end;

end.

