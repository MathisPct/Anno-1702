{$codepage utf8}
unit sMenuMarchand ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils , bouclesJeux, gestionEcran , Keyboard , navigationMenues , unitRessources, personnage;

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
    txtPayWoodX           =60; //abcisse de txtSuivant
    txtPayFishX           =60; //abcisse de txtGestionbatiment
    txtPayLaineX          =60; //abcisse de txtGestionbatiment
    txtPayTissuX          =60;  //abcisse de txtGestionbatiment
    txtPayToolX           =60; //abcisse de txtTest2

    txtSendWoodX          =120; //constante de type string qui est le 1er item du menu
    txtSendFishX          =120; //constante de type string qui est le 2ème item du menu
    txtSendLaineX         =120; //constante de type string qui est le 3ème item du menu
    txtSendTissuX         =120;
    txtSendToolX          =120;

    txtNoPayX             =92;

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

    txtNoPayY             =48;

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

  //procedure qui affiche le paragraphe que dit le marchand lors de son arrivée
  procedure afficheScenarioMarchand(interligne: integer);
    const
      p1v1='Un homme mystérieux est de passage sur votre île... :';
      p2v1='OYE mon brave! Je me présente, je suis un marchand et il se trouve que je suis de passage sur votre île';
      p3v1='durant mon voyage.';
      p4v1='Vous savez j''ai toutes sortes de marchandises dans mon sac ! Seriez vous intéressé par un échange ? ';
      p5v1='Bien évidemment je ne souhaite pas vous importuner, je me contenterais de partir en cas de refus...';

      p1v2='Un homme mystérieux est de passage sur votre île... :';
      p2v2='OYE mon brave! Je me présente, je suis un marchand et il se trouve que je suis de passage sur votre île durant mon voyage';
      p3v2='Vous savez j''ai toutes sortes de marchandises dans mon sac ! Seriez vous intéressé par un échange ? ';
      p4v2='Bien évidemment je ne souhaite pas vous importuner, je me contenterais de partir en cas de refus...';

      txtTotalVariante=2; //total txt variante
    var
      numParagra:Integer;
      posX,posY: Integer;
      arrTxtMarchandV1: Array[1..5] of String=(p1v1,p2v1,p3v1,p4v1,p5v1); //tableau contenant les différents paragraphes
      arrTxtMarchandV2: Array[1..4] of String=(p1v2,p2v2,p3v2,p4v2);
      numAleaTxt: Integer; //nb de variantes de texte (aléatoire à l'affichage)
    begin
      randomize; //init de random
      posX:=20;
      posY:=10;
      numAleaTxt:=1+random(txtTotalVariante); //nb aléatoire entre 1 et 2 (choix du texte à afficher)
      case numAleaTxt of
        1:
          begin
             for numParagra:=1 to High(arrTxtMarchandV1) do
               begin
                 ecrireTexte(arrTxtMarchandV1[numParagra],posX,posY);
                 posY:=posY+interligne;
               end;
          end;
        2:
          begin
             for numParagra:=1 to High(arrTxtMarchandV2) do
               begin
                 ecrireTexte(arrTxtMarchandV2[numParagra],posX,posY);
                 posY:=posY+interligne;
               end;
          end;
      end;
    end;

  procedure affichage();
    begin
      DoneKeyboard; //pas d'event clavier
      afficheScenarioMarchand(2);
      readln; //attente event user
      InitKeyboard;
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Le marchand'); //procédure écrit nom menu
      printItemsMenu(totalItemsMenu,menuMarchand,itemsCoordX,itemsCoordY);
    end;

  //procédure qui est lancé si piraterie est pas actif
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
                        if (getGold()-getPriceRessource(2)>=0) then
                            begin
                              setWood(5);
                              setGold(-getPriceRessource(2));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''or      ',80,45);
                      end;
                     2:
                      begin
                        if (getGold()-getPriceRessource(3)>=0) then
                            begin
                              setFish(5);
                              setGold(-getPriceRessource(3));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''or      ',80,45);
                      end;

                     3:
                      begin
                        if (getGold()-getPriceRessource(4)>=0) then
                            begin
                              setLaine(5);
                              setGold(-getPriceRessource(4));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''or      ',80,45);
                      end;

                     4:
                      begin
                        if (getGold()-getPriceRessource(5)>=0) then
                            begin
                              setTissu(5);
                              setGold(-getPriceRessource(5));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''or       ',80,45);
                      end;

                     5:
                      begin
                        if (getGold()-getPriceRessource(6)>=0) then
                            begin
                              setTool(5);
                              setGold(-getPriceRessource(6));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''or       ',80,45);
                      end;
                     6:
                      begin
                        if (getWood()>=5) then
                          begin
                            setWood(-5);
                            setGold(getPriceRessource(2));
                            initItemChoisie(); //initialisation de l'itemChoisie
                            running:=False;
                          end;
                        ecrireTexte('Vous n''avez pas assez de bois        ',80,45);
                      end;
                     7:
                      begin
                        if (getFish()>=5) then
                            begin
                              setFish(-5);
                              setGold(getPriceRessource(3));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                           end;
                        ecrireTexte('Vous n''avez pas assez de poissons    ',80,45);
                      end;

                     8:
                      begin
                        if (getLaine()>=5) then
                          begin
                            setLaine(-5);
                            setGold(getPriceRessource(4));
                            initItemChoisie(); //initialisation de l'itemChoisie
                            running:=False;
                          end;
                        ecrireTexte('Vous n''avez pas assez de laine       ',80,45);
                      end;
                     9:
                      begin
                        //si assez de tissus
                        if (getTissu()>=5) then
                          begin
                            setTissu(-5);
                            setGold(getPriceRessource(5));
                            initItemChoisie(); //initialisation de l'itemChoisie
                            running:=False;
                          end;
                        //sinon pas assez de tissus
                        ecrireTexte('Vous n''avez pas assez de tissus      ',80,45);
                      end;
                     10:
                      begin
                        //si assez d'outils
                        if(getTool>=5) then
                            begin
                              setTool(-5);
                              setGold(getPriceRessource(6));
                              initItemChoisie(); //initialisation de l'itemChoisie
                              running:=False;
                            end;
                        ecrireTexte('Vous n''avez pas assez d''outils      ',80,45);
                      end;
                     11: running:=False;
                   end;
               end;
           end;
    end;

end.

