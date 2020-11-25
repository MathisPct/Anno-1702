{$codepage utf8}
unit menuInterface;

{$mode objfpc}{$H+}

interface

uses gestionecran,navigationMenues,evenementClavier; //appel des unités

procedure mainMenuInterface(); {Procédure qui appelle toutes les fonctions et procédures pour afficher le menu interface }

implementation
  //déclaration des constantes connues de toute l'unité
  const
      //Nombre d'item dans les menus
      //nb d'item dans le menu
      totaleItemsMenu=4;

      //Déclaration des items de notre menu initial
      txtSuivant='Tour suivant'; //constante de type string qui est le 1er item du menu
      txtGestionbatiment='Accéder au menu de gestion des batimênts'; //constante de type string qui est le 2ème item du menu
      txtQuitter='Quitter la partie'; //constante de type string qui est le 3ème item du menu
      txtTest='Test1';

      //Déclaration des ordonnées de notre menu
      txtSuivantY= 30; //ordonnée de txtSuivant à 30px
      txtGestionbatimentY=35; //ordonnée de txtGestionbatiment 35px
      txtQuitterY=40; //ordonnée de txtGestionbatiment 40px
      txtTestY=45;  //ordonnée de txtGestionbatiment 45px

  //type connue de toute l'unité
  type
   //déclaration type menu qui est un type qui sert à contenir les différents items de notre menu
   menu = array[1..totaleItemsMenu] of String;

   //déclaration type tabCoordYItem qui est un type qui sert à contenir les différentes ordonnées où sont placées les items de notre menu
   tabCoordYItem = array[1..totaleItemsMenu] of Integer;

  //déclaration des variables connues de toute l'unité
  var

    nbTourBoucle:Integer; //variable de type integer qui compte le nb de tour dans la boucle

    menuInterfa:menu=(txtSuivant,txtGestionbatiment,txtQuitter,txtTest); //tableau qui contient les différents item texte de notre menu

    itemsCoordY:tabCoordYItem = (txtSuivantY,txtGestionbatimentY,txtQuitterY,txtTestY); //tableau qui contient les différents item texte de notre menu

  {Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
  procedure initiaNbTourBoucle();
    begin
      nbTourBoucle:=1; //initialisation du nb de tour de boucle à 1 quand on arrive sur le menu
    end;

  {Procédure qui modifie le nbTourBoucle : incrémente de 1 le nb de tour de boucle }
  procedure incrementaNbTourBoucle();
    begin
      nbTourBoucle:=nbTourBoucle+1;//incrémentation du nombre de tours dans la boucle
    end;

  //Cette fonction renvoie la valeur de la variable nbTourBoucle
  function getNbTourBoucle(): Integer;
  begin
       getNbTourBoucle := nbTourBoucle;
  end;

  {Procédure qui dessine le rectangle de la zone du jeu}
  procedure rectangleZoneJeu();
    begin
     //zone de jeu
      dessinerCadreXY(3,3,197,57,simple,15,0);
    end;

  {Procédure qui affiche le cadre entourant le texte Bienvenue sur 'NomIle'}
  procedure cadreTxtNomMenu();
    begin
      dessinerCadreXY(80-10,1,80,5-2,simple,15,0); //petit rectangle décors gauche
      dessinerCadreXY(120,1,120+10,5-2,simple,15,0); //petit rectangle décors droit
      dessinerCadreXY(80,1,120,5,simple,15,0); //rectangle entourant le texte Création d'une nouvelle partie
    end;

  {Procédure qui affiche un item présents dans le menu en position X et Y}
  procedure affichageItem(item:String;posX,posY:Integer);
  var
    posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
  begin
    posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
    posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)

    ecrireEnPosition(posItem,item); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem
  end;

  {Procédure qui affiche tous les items du menu en position X et Y}
  procedure affichageItemsMenu();
  begin
    //affichage des items du menu  (affichageItem est une fonction de gestionEcran)
    affichageItem(menuInterfa[1],10,itemsCoordY[1]); //affichage de l'item 1 du menu avec les coordonnées de cette item
    affichageItem(menuInterfa[2],10,itemsCoordY[2]); //affichage de l'item 2 du menu
    affichageItem(menuInterfa[3],10,itemsCoordY[3]); //affichage de l'item 3 du menu
    affichageItem(menuInterfa[4],10,itemsCoordY[4]); //affichage de l'item 4 du menu
  end;

  {Procédure qui colorier l'élément actuel sur lequel est placé l'utilisateur}
  procedure colorierElementActuel();
  begin
    //colorie la zone qui est l'élément actuel sur lequel l'user est placé
    case getItemActuel() of
      1 : ColorierZone(1,15,10,10+20,itemsCoordY[1]) ; //colorie le 1er item
      2 : ColorierZone(1,15,10,10+20,itemsCoordY[2]) ; //colorie le 2eme item
      3 : ColorierZone(1,15,10,10+20,itemsCoordY[3]) ; //colorie le 3eme item
      4 : ColorierZone(1,15,10,10+20,itemsCoordY[4]) ; //colorie le 4eme item
    end
  end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu}
  //créer la procédure ICIIII
  procedure affichage();
  begin
    rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
    cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
    affichageItemsMenu; //procédure qui affiche tous les items du menu en position X et Y
  end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu interface }
  procedure mainMenuInterface();
    var
      running: Boolean; //variable booleenne qui permet de demarrer le menu
    begin
      running:=True; //initialisation de running à true quand on arrive sur le menu

      //tant que le menu est lancé executé les instructions
      while (running=True) do
          begin
          //si on vient d'arriver sur le menu on initialise l'affichage des éléments du menu, initialisation de l'item actuel à 1 etc
          if (nbTourBoucle=0) then
            begin
              //initialisation de l'item actuel au 1er item du menu quand on arrive sur le menu
              initialisationItemActuel(1);

              {
              //affichage des rectangles, du texte et du menu
              rectangleZoneJeu(); //dessine le rectangle de la zone de jeu
              cadreTxtNomMenu(); //dessine les éléments entourant le texte Création d'une nouvelle partie

              //Procédure qui affiche tous les items du menu en position X et Y
              affichageItemsMenu();
              //FIN affichage des rectangles, du texte et du menu...
              }
            end

          //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
          else if(nbTourBoucle>=1) then
            begin
               //affichage des rectangles, du texte et du menu
              //rectangleZoneJeu(); //dessine le rectangle de la zone de jeu
              //cadreTxtNomMenu(); //dessine les éléments entourant le texte Création d'une nouvelle partie
              {Procédure qui affiche tous les items du menu en position X et Y}
              //affichageItemsMenu();
              //FIN affichage des rectangles, du texte et du menu...

              affichage;// affichage des rectangles du nom du menu et de tous les items du menu
              //navigationTabMenu(menuInterfa,toucheClavier(),getItemChoisi()); //appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menu
              navigationTabMenu(menuInterfa,toucheClavier(),getItemActuel());

              //affichage test
              colorierElementActuel();

              //writeln('L''item actuel est: ',getItemActuel()); //affichage de l'item actuel quand on appuie sur les flèches haut et bas
              //fonction qui renvoie l'item choisie si l'user appuie sur entrée
              //writeln('L''item choisie est',getItemChoisie(toucheClavier())); //affichage de l'item choisie quand on appuie sur entrée

              //FIN affichage test
              //effacerEcran; //mise à jour de l'affichage de l'écran

            end;

          incrementaNbTourBoucle(); //incrémentation du tour de boucle
        end;
    end;

end.

