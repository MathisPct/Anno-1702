{$codepage utf8}
unit menuAccueil;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, GestionEcran, Keyboard,bouclesJeux,navigationMenues, unitRessources , sMenuMarchand , unitBuilding, eventImpromptus ; //appel des unités

procedure mainMenuAccueil(); {Procédure qui appelle toutes les fonctions et procédures du menu accueil }

implementation

  //déclaration des constantes connues de toute l'unité
  const
      //Nombre d'item dans les menus
      //nb d'item dans le menu
      totaleItemsMenu=3;

      totalDifficultes=4;

      //Déclaration des items de notre menu initial
      txtNewPartie='Nouvelle Partie'; //constante de type string qui est le 1er item du menu
      txtOptionDifficultes='Difficultés'; //constante de type string qui est le 2ème item du menu
      txtQuitter='Quitter'; //constante de type string qui est le 3ème item du menu

      //déclaration des items du menu difficulté
      txtDiffFacile='Difficulté facile';
      txtxtDiffNormale='Difficulté normale';
      txtDiffHard='Difficulté hard';
      txtMenuPrecedent='Menu Précédent';


      //Déclaration des abcisses de notre menu
      txtNewPartieX= 10; //abcisse de txtSuivant à 30px
      txtDiffX=10;
      txtQuitterX=10; //abcisse de txtGestionbatiment à 10px
      //Déclaration des ordonnées de notre menu
      txtNewPartieY= 48; //ordonnée de txtSuivant à 20px
      txtDiffY=49;
      txtQuitterY=50; //ordonnée de txtGestionbatiment à 30px

      //abcisses des items du sous-Menu difficultés
      txtDiffFacileX=90;
      txtxtDiffNormaleX=90;
      txtDiffHardX=90;
      txtMenuPrecedentX=90;
      //ordonnées des items du sous-Menu difficultés
      txtDiffFacileY=20;
      txtxtDiffNormaleY=22;
      txtDiffHardY=24;
      txtMenuPrecedentY=50;

   //déclaration des variables connues de toute l'unité
    var
      touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

      menuInterfaAccueil: array[1..totaleItemsMenu] of String =(txtNewPartie,txtOptionDifficultes,txtQuitter); //tableau qui contient les différents item texte du menu
      itemsCoordX: array[1..totaleItemsMenu] of Integer = (txtNewPartieX,txtDiffX,txtQuitterX); //tableau qui contient les différents abcisses des items du menu
      itemsCoordY:array[1..totaleItemsMenu] of Integer = (txtNewPartieY,txtDiffY,txtQuitterY); //tableau qui contient les différents ordonnées des items du menu

      menuDiff: array[1..totalDifficultes] of String =(txtDiffFacile,txtxtDiffNormale,txtDiffHard,txtMenuPrecedent); //tableau qui contient les différents items texte du sous menu difficultés
      itemsDiffCoordX: array[1..totalDifficultes] of Integer =(txtDiffFacileX,txtxtDiffNormaleX,txtDiffHardX,txtMenuPrecedentX);
      itemsDiffCoordY: array[1..totalDifficultes] of Integer =(txtDiffFacileY,txtxtDiffNormaleY,txtDiffHardY,txtMenuPrecedentY);


    //procédure qui affiche le logo
    procedure printLogo() ;
      begin
        deplacerCurseurXY(7,15);
          write('                                #                         #########                #######          #########                #######                  ###############');
          deplacerCurseurXY(7,16);
          write('                               ###                           #######                 ###               #######                 ###                 #####            ####');
          deplacerCurseurXY(7,17);
          write('                              #####                          #########               ###               ########                ###               ####                #####');
          deplacerCurseurXY(7,18);
          write('                             #######                         ##  ######              ##                ## #######              ##               ####                   ####');
          deplacerCurseurXY(7,19);
          write('                            ##  #####                        ##   #######            ##                ##   #######            ##              ####                     ####');
          deplacerCurseurXY(7,20);
          write('                           ##    #####                       ##     #######          ##                ##     #######          ##             ####                       ####');
          deplacerCurseurXY(7,21);
          write('                          ##      #####                      ##       #######        ##                ##       #######        ##             ####                       ####');
          deplacerCurseurXY(7,22);
          write('                         ##        #####                     ##         #######      ##                ##         ######       ##             ####                       ####');
          deplacerCurseurXY(7,23);
          write('                        #################                    ##          #######      #                ##          #######      #             ####                       ####');
          deplacerCurseurXY(7,24);
          write('                       ###################                   ##            #######    #                ##            #######    #             ####                       ####');
          deplacerCurseurXY(7,25);
          write('                      ##             ######                  ##              #######  #                ##              #######  #             #####                     #####');
          deplacerCurseurXY(7,26);
          write('                     ##               ######                 ##                ###### #                ##               ####### #              ####                     ####');
          deplacerCurseurXY(7,27);
          write('                    ##                 ######                ##                 #######                ##                 #######               #####                 #####');
          deplacerCurseurXY(7,28);
          write('                   ###                  ######               ##                   #####                ##                   #####                ######              ####');
          deplacerCurseurXY(7,29);
          write('                  ####                   ######             ####                   ####               ####                   ####                  ######         #####');
          deplacerCurseurXY(7,30);
          write('                 #######                #########          #######                   ##              #######                   ##                     ###############');
          deplacerCurseurXY(7,31);
          write('     ###############################################################################################################################################################################');
          deplacerCurseurXY(7,32);
          write('       ###########################################################################################################################################################################');
          deplacerCurseurXY(7,33);
          write('             ############################                                                                                                       ############################');
          deplacerCurseurXY(7,34);
          write('               ##    ####################             ##         #################            ######                    #######                 ####################    ##');
          deplacerCurseurXY(7,35);
          write('                          ###############           ####         ################           ###    ###               ####    #####              ###############');
          deplacerCurseurXY(7,36);
          write('                               ##########         ######         ##         ####          ###        ###            ##         ####             ########## ');
          deplacerCurseurXY(7,37);
          write('                                  #######            ###         #          ###          ####        ####          ##           ####            ####### ');
          deplacerCurseurXY(7,38);
          write('                                    #####            ###                   ###          ####          ####         ##           ####            ####');
          deplacerCurseurXY(7,39);
          write('                                       ##            ###                  ##            ####          ####          ##          ###             ##');
          deplacerCurseurXY(7,40);
          write('                                       ##            ###                 ##             ####          ####                     ####             ##');
          deplacerCurseurXY(7,41);
          write('                                        #            ###                ##              ####          ####                    ###               #');
          deplacerCurseurXY(7,42);
          write('                                        #            ###              ###               ####          ####                  ###                 #');
          deplacerCurseurXY(7,43);
          write('                                                     ###             ###                 ####        ####                 ###                ');
          deplacerCurseurXY(7,44);
          write('                                                     ###            ###                   ###        ###               #######');
          deplacerCurseurXY(7,45);
          write('                                                    ####           ###                      ###    ###               ###############');
          deplacerCurseurXY(7,46);
          write('                                                   #######       #######                      ######                ################');
      end;

    {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
    procedure affichage();
    begin
      rectangleZoneJeu(); //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu(); //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      printLogo(); //affichage du logo
      printItemsMenu(totaleItemsMenu,menuInterfaAccueil,itemsCoordX,itemsCoordY) ; //procédure qui affiche tous les items du menu en position X et Y
    end;

    {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
    procedure printMenuDifficulty();
      begin
        rectangleZoneJeu(); //appel de la procédure: on dessine le rectangle sur l'écran
        cadreTxtNomMenu(); //procédure qui dessine le cadre qui entoure le texte en haut au milieu
        printItemsMenu(totalDifficultes,menuDiff,itemsDiffCoordX,itemsDiffCoordY) ; //procédure qui affiche tous les items du menu en position X et Y
      end;

    procedure mainMenuAccueil(); {Procédure qui appelle toutes les fonctions et procédures du menu accueil }
    var
        menuAccueil:Boolean; //variable booléenne qui permet de rester dans le menu accueil tant qu'elle est vraie
        menuChoiceDiff:Boolean; //variable booléenne qui permet de rester dans le menu difficulte tant qu'elle est vraie
    begin
      initiaNbTourBoucle(); //initialisation du nb de tour de boucle quand on arrive sur le menu
      menuChoiceDiff:=False;
      menuAccueil:=True; //initialisation de menu à true quand on arrive sur le menuAccueil

      //tant que le menu est lancé executé les instructions
      while (menuAccueil=True) do
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
            menuAccueil :=False; // on passe au menu suivant
            end
          else if (getItemChoisie()=2) then
            begin
              effacerEcran();
              initItemChoisie();
              initiaNbTourBoucle();
              menuChoiceDiff:=True;
              while (menuChoiceDiff) do
                begin
                  if (getNbTourBoucle()=0) then
                    begin
                      initialisationItemActuel(1); //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
                      initialisationItemAnterieur(); //initialisation de l'item antérieur à itemActuel-1 quand on arrive sur le menu
                      printMenuDifficulty(); //affichage des éléments du menu des difficultés
                      colorierElementActu(0,60,itemsDiffCoordX,itemsDiffCoordY); //init de la couleur de l'item actuel sur lequel l'user est
                    end
                  else if (getNbTourBoucle()>=1) then
                    begin
                      touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
                      touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
                      setItemChoisie(touche);
                      navigationTabMenu(menuDiff,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menu
                      colorierElementActu(0,60,itemsDiffCoordX,itemsDiffCoordY); //colorie l'item actuel sur lequel l'user est
                      reintialiserElementAnt(0,60,itemsDiffCoordX,itemsDiffCoordY); //colorie l'item actuel sur lequel l'user est
                    end;
                  incrementaNbTourBoucle();
                  //choix des difficultés
                  case (getItemChoisie) of
                    1: //si difficulté choisie = facile
                      begin
                        initBuildingDiffFacile(); //init bulding difficulté facile
                        initRessourceDiffFacile(); //init ressources difficulté facile
                        initTauxAppaMarchand(2); //initialisation taux apparition marchand difficulté facile
                        initItemChoisie();
                        initiaNbTourBoucle();
                        menuChoiceDiff:=False; //fin du menu du choix des difficulés
                        menuAccueil:=True; //retour menu accueil
                      end;
                    2: //si difficulté choisie = normale
                      begin
                        initEImpromDiffNormal(); //init event impromptus en mode normal
                        initBuilding(); //init building en difficulté normal
                        initRessourceDiffNormal(); //init ressources diff normal
                        initTauxAppaMarchand(5); //initialisation taux apparition marchand
                        initItemChoisie();
                        initiaNbTourBoucle();
                        menuChoiceDiff:=False; //fin du menu du choix des difficulés
                        menuAccueil:=True; //retour menu accueil
                      end;
                    3: //si difficulté choisie = hard
                      begin
                        initEImpromDiffHard(); {procedure qui initialise les event en difficulté hard}
                        initBuildingDiffHard(); //init building difficulté hard
                        initRessourceDiffHard(); //init ressources diff hard
                        initTauxAppaMarchand(10); //initialisation taux apparition marchand
                        initItemChoisie();
                        initiaNbTourBoucle();
                        menuChoiceDiff:=False; //fin du menu du choix des difficulés
                        menuAccueil:=True; //retour menu accueil

                      end;
                    4:
                      begin
                        initItemChoisie();
                        initiaNbTourBoucle();
                        menuChoiceDiff:=False; //fin du menu du choix des difficulés
                        menuAccueil:=True; //retour menu accueil
                      end;
                  end;

                end;
            end
          else if (getItemChoisie()=3) then
            begin
              halt(); //quitte la fenêtre si l'user choisi quitter
            end;
        end;
    end;

end.

