{$codepage utf8}
unit sMenuGestionBatiments ;

{$mode objfpc}{$H+}

interface

  uses
    gestionecran,navigationMenues,evenementClavier,Keyboard,bouclesJeux,personnage; //appel des unités

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainSMenuGBat();

implementation
//déclaration des constantes de toute l'unité
const
  //nb d'items dans le sous menu
  totalItemsMenuGetBat=2;
  totalItemsMenuConstru=8;

  //nb d'item de batiments
  totalItemBatiments=7;

  //déclaration des items du menu
  txtConsBat= 'Construire un bâtimement'; //constante de type string : item du sMenu
  txtMenuPrec= 'Menu précédent';

  //abcisses texte menu
  consBatX=80;
  menuPrecX=80;

  //ordonnées texte menu
  consBatY=50;
  menuPrecY=53;

  //déclaration des items des bâtiments
  txtMaison='Maisons';
  //bâtiments sociaux
  txtCentreVille='Centre-Ville';
  txtChapelle='Chapelle';
  //industries
  txtCaPecheur='Cabane de pêcheur';
  txtCaBucheron='Cabane de bucheron';
  txtBergerie='Bergerie';
  txtAtelierTisserand='Atelier Tisserand';

  //Abcisses texte batiments
  txtMaisonX= 20;
  txtCentreVilleX= 20;
  txtChapelleX= 20;
  txtCaPecheurX= 20;
  txtCaBucheronX= 20;
  txtBergerieX= 20;
  txtAtelierTisserandX= 20;

  //Ordonnées texte batiments
  txtMaisonY= 12;
  txtCentreVilleY= 15;
  txtChapelleY= 18;
  txtCaPecheurY= 21;
  txtCaBucheronY= 24;
  txtBergerieY= 27;
  txtAtelierTisserandY= 30;

 //type connu de toute l'unité
 type
   //déclaration type menu qui sert à contenir les différents item du menu
   menuGetBat= array[1..totalItemsMenuGetBat] of String;
   menuChoixConstru= array[1..totalItemsMenuConstru] of String;

   //déclaration types contient les coordonnées des items du menuGetBat
   tabCoordXItemGetBat= array[1..totalItemsMenuGetBat] of Integer;
   tabCoordYItemGetBat= array[1..totalItemsMenuGetBat] of Integer;

   //déclaration types contient les coordonnées des items du menu de construction
   tabCoordXItemConstru= array[1..totalItemsMenuConstru] of Integer;
   tabCoordYItemConstru= array[1..totalItemsMenuConstru] of Integer;


   //déclaration type qui sert à contenir les txt des bâtiments
   tabItemBatiments= array [1..totalItemBatiments] of String;
   //déclaration type qui sert à contenir les coordonnées du placement des txt des bâtiments
   tabCoordXItemBatiments= array [1..totalItemBatiments] of Integer;
   tabCoordYItemBatiments= array [1..totalItemBatiments] of Integer;

 //déclaration des variables connues de toute l'unité
 var
   touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

   //marges
   margeGauche:Integer;
   margeDroite: Integer;

   //tableaux qui contient les textes des menu
   menu1: menuGetBat = (txtConsBat, txtMenuPrec);
   menu2: menuChoixConstru  = (txtMaison,txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtMenuPrec);

   //tableau contient coordonnées des items du menu1
   menu1X: tabCoordXItemGetBat = (consBatX,menuPrecX);
   menu1Y: tabCoordYItemGetBat = (consBatY,menuPrecY);

   //tableau qui contient les coordonnées des items du menu2
   menu2X: tabCoordXItemConstru  = (txtMaisonX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX,menuPrecX);
   menu2Y: tabCoordYItemConstru = (txtMaisonY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY,menuPrecY);


   //tableau qui contient les textes des items batiments
   itemsBat:tabItemBatiments=(txtCentreVille,txtChapelle, txtCaPecheur,txtCaBucheron, txtBergerie,txtAtelierTisserand,txtMaison);
   //tableau qui contient les coordonnées des items batiments
   itemsBatX: tabCoordXItemBatiments=(txtMaisonX,txtCentreVilleX,txtChapelleX, txtCaPecheurX,txtCaBucheronX, txtBergerieX,txtAtelierTisserandX);
   itemsBatY: tabCoordYItemBatiments=(txtMaisonY,txtCentreVilleY,txtChapelleY, txtCaPecheurY,txtCaBucheronY, txtBergerieY,txtAtelierTisserandY);


  {Procédure qui affiche tous les items du menu 1 position X et Y  }
  procedure affichageItemsMenu1();
  var
    item: Integer; //variable entière: compteur boucle affichage items menu interface
  begin
    //affichage des items du menu  (affichageItem est une fonction de bouclesJeux)
    for item:=1 to totalItemsMenuGetBat do
        affichageItem(menu1[item],menu1X[item],menu1Y[item]);
  end;


    {Procédure qui affiche tous les items du menu 2 en position X et Y  }
  procedure affichageItemsMenu2();
    var
      item: Integer; //variable entière: compteur boucle affichage items menu interface
    begin
      //affichage des items du menu  (affichageItem est une fonction de bouclesJeux)
      for item:=1 to totalItemsMenuConstru do
          affichageItem(menu2[item],menu2X[item],menu2Y[item]);
    end;

  {  affiche tous les txt des bâtiments en position X et Y  }
  procedure affichageItemsBat(totalItem: Integer; CoordX: tabCoordXItemBatiments; CoordY: tabCoordYItemBatiments);
    var
      itemBat: Integer; //variable entière, compteur de la boucle d'affichage (index tableau)
    begin
      //affichage de chaque ressource
      for itemBat:=1 to totalItem do
          affichageItem(itemsBat[itemBat],CoordX[itemBat],CoordY[itemBat]); //affichage de l'item 1 du menu avec les coordonnées de cette item
    end;

  {Procédure qui colorier l'élément actuel sur lequel est placé l'utilisateur}
  procedure colorierElementActuelMenu1(margeGauche,margeDroite: integer);
    begin
      //colorie la zone en fonction de l'élément actuel sur lequel l'user est placé
      case getItemActuel() of
        1 : ColorierZone(1,15,menu1X[1]-margeGauche,menu1Y[1]+margeDroite,menu1Y[1]) ; //colorie le 1er item
        2 : ColorierZone(1,15,menu1X[2]-margeGauche,menu1Y[2]+margeDroite,menu1Y[2]) ; //colorie le 2eme item
      end
    end;

  procedure reintialiserElementAnterieurMenu1(margeGauche,margeDroite: integer);
    begin
      //rétablie la couleur de l'élément précedemment choisie par l'user
      case getItemAnterieur() of
        1 : ColorierZone(0,15,menu1X[1]-margeGauche,menu1Y[1]+margeDroite,menu1Y[1]); //rétablie la couleur du 1er item
        2 : ColorierZone(0,15,menu1X[2]-margeGauche,menu1Y[2]+margeDroite,menu1Y[2]); //rétablie la couleur du 2eme item
      end;
    end;

    {Procédure qui colorier l'élément actuel sur lequel est placé l'utilisateur}
  procedure colorierElementActuelMenu2(margeGauche,margeDroite: integer);
    begin
      //colorie la zone en fonction de l'élément actuel sur lequel l'user est placé
      case getItemActuel() of
        1 : ColorierZone(1,15,menu2X[1]-margeGauche,menu2Y[1]+margeDroite,menu2Y[1]) ; //colorie le 1er item
        2 : ColorierZone(1,15,menu2X[2]-margeGauche,menu2Y[2]+margeDroite,menu2Y[2]) ; //colorie le 2e item
        3 : ColorierZone(1,15,menu2X[3]-margeGauche,menu2Y[3]+margeDroite,menu2Y[3]) ; //colorie le 3e item
        4 : ColorierZone(1,15,menu2X[4]-margeGauche,menu2Y[4]+margeDroite,menu2Y[4]) ; //colorie le 4e item
        5 : ColorierZone(1,15,menu2X[5]-margeGauche,menu2Y[5]+margeDroite,menu2Y[5]) ; //colorie le 5e item
        6 : ColorierZone(1,15,menu2X[6]-margeGauche,menu2Y[6]+margeDroite,menu2Y[6]) ; //colorie le 6e item
        7 : ColorierZone(1,15,menu2X[7]-margeGauche,menu2Y[7]+margeDroite,menu2Y[7]) ; //colorie le 7e item
        8 : ColorierZone(1,15,menu2X[8]-margeGauche,menu2Y[8]+margeDroite,menu2Y[8]) ; //colorie le 8e item
      end
    end;

  procedure reintialiserElementAnterieurMenu2(margeGauche,margeDroite: integer);
    begin
      //rétablie la couleur de l'élément précedemment choisie par l'user
      case getItemAnterieur() of
        1 : ColorierZone(0,15,menu2X[1]-margeGauche,menu2Y[1]+margeDroite,menu2Y[1]); //rétablie la couleur du 1er item
        2 : ColorierZone(0,15,menu2X[2]-margeGauche,menu2Y[2]+margeDroite,menu2Y[2]) ; //rétablie la couleur 2e item
        3 : ColorierZone(0,15,menu2X[3]-margeGauche,menu2Y[3]+margeDroite,menu2Y[3]) ; //rétablie la couleur 3e item
        4 : ColorierZone(0,15,menu2X[4]-margeGauche,menu2Y[4]+margeDroite,menu2Y[4]) ; //rétablie la couleur 4e item
        5 : ColorierZone(0,15,menu2X[5]-margeGauche,menu2Y[5]+margeDroite,menu2Y[5]) ; //rétablie la couleur 5e item
        6 : ColorierZone(0,15,menu2X[6]-margeGauche,menu2Y[6]+margeDroite,menu2Y[6]) ; //rétablie la couleur 6e item
        7 : ColorierZone(0,15,menu2X[7]-margeGauche,menu2Y[7]+margeDroite,menu2Y[7]) ; //rétablie la couleur 7e item
        8 : ColorierZone(0,15,menu2X[8]-margeGauche,menu2Y[8]+margeDroite,menu2Y[8]) ; //rétablie la couleur 8e item
      end;
    end;


  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu1}
  procedure affichageMenu1();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Inventaire batiments'); //procédure écrit nom menu
      affichageItemsMenu1(); //procédure qui affiche tous les items du menu en position X et Y
      affichageItemsBat(7,itemsBatX,itemsBatY);
    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu2}
  procedure affichageMenu2();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Construction batiments'); //procédure écrit nom menu
      affichageItemsMenu2(); //procédure qui affiche tous les items du menu en position X et Y
      //affichageItemsBat(7,itemsBatX,itemsBatY);
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
                  colorierElementActuelMenu1(10,60); //initialisation de colorierElementActuel
                end
              //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
              else if(getNbTourBoucle>=1) then
                begin
                  touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                  touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                  setItemChoisie(touche);
                  navigationTabMenu(menu1,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                  colorierElementActuelMenu1(10,60);
                  reintialiserElementAnterieurMenu1(10,60); //réintialise la couleur de l'item précedemment choisie
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
                              colorierElementActuelMenu2(10,50);
                          end
                        else if (getNbTourBoucle>=1) then
                          begin
                              touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                              touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                              setItemChoisie(touche);
                              navigationTabMenu(menu2,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
                              colorierElementActuelMenu2(10,50);
                              reintialiserElementAnterieurMenu2(10,50); //réintialise la couleur de l'item précedemment choisie
                          end;
                        incrementaNbTourBoucle(); //incrémentation du tour de boucle

                        //choix batiments à construire dans le menu 2
                        Case getItemChoisie() of
                          1: writeln('Construction de ',menu2[1]); //perte argent, bois, incrémentation nb maison
                          2: writeln('Construction de ',menu2[2]); //perte argent, bois, incrémentation nb Centre-Ville
                          3: writeln('Construction de ',menu2[3]); //perte argent, bois, incrémentation nb Chapelle
                          4: writeln('Construction de ',menu2[4]); //perte argent, bois, incrémentation nb Cabane de pêcheur
                          5: writeln('Construction de ',menu2[5]); //perte argent, bois, incrémentation nb Cabane de bucheron
                          6: writeln('Construction de ',menu2[6]); //perte argent, bois, incrémentation nb Bergerie
                          7: writeln('Construction de ',menu2[7]); //perte argent, bois, incrémentation nb Atelier Tisserand
                          8: //item 8 du menu => menu précédent
                             begin
                                 effacerEcran(); //raffraichissement de l'écran
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

