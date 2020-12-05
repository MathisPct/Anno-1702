unit bouclesJeux;

{$mode objfpc}{$H+}

interface
//visibles par les programmes qui appelle l'unité

uses
  SysUtils,GestionEcran, unitBuilding ; //appel des unités

{Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
procedure initiaNbTourBoucle();

{Procédure qui modifie le nbTourBoucle : incrémente de 1 le nb de tour de boucle }
procedure incrementaNbTourBoucle();

//Cette fonction renvoie la valeur de la variable nbTourBoucle
function getNbTourBoucle(): Integer;


{Procédure qui initialise la boucle du Jeu à True quand le programme est lancé}
procedure initBoucleJeu();

//Procédure qui sert à affecter True ou False à la variable boucleJeu
procedure setBoucleJeu(valeur:Boolean);

//Fonction qui sert à renvoyer la valeur de la variable boucleJeu
function getBoucleJeu():Boolean;


{Procédure qui dessine le rectangle de la zone du jeu}
 procedure rectangleZoneJeu();

 {Procédure qui affiche le cadre entourant le texte Bienvenue sur 'NomIle'}
 procedure cadreTxtNomMenu();

 {Procédure: écrit le nom du menu en pos x et y (en haut de l'écran)}
 procedure afficheNomMenu(nom:String);

 procedure ecrireTexte(nom:String; x:Integer; y:Integer);

 {Procédure qui affiche un item présents dans le menu en position X et Y}
procedure affichageItem(item:String;posX,posY:Integer);

{Procédure qui affiche tous les items d'un menu d'éléments txt passé en paramètre en position X et Y}
//procedure affichageItemsMenu(menuTxt: Array of String;arrayCoordX,arrayCoordY:Array of Integer;const totaleItemsMenu: Integer);

//procedure affichageBatiment(sorte: String; nom:String; propriety: String; posX,posY:Integer);


//Liste procédures fonctions pour nbTour

//procédure qui sert à initialiser le nombre de tour
procedure initNombreDeTour();

//procédure qui sert à affecter le nombre de tour
procedure setBoucleNbTour(valeur:Integer);

//fonction qui retourne la valeur du nb de tour
function getNbTour():Integer;

implementation
  //variables connues de toute l'unité
  var
    nbTourBoucle:Integer; //variable de type integer qui compte le nb de tour dans la boucle
    boucleJeu:Boolean; //variable de type boolean -> sert pour lancer ou quitter la boucle du jeu
    nbTour: Integer; //variable int, initialisé à 0 qui est le numéro du tour de jeu, Incrémenté quand Tour Suivant

   //--------------DEBUT Fonctions et Procédure qui servent pour les Boucles des Menus---------------------//

  {Procédure qui initialise le nb de tour de boucle: permet d'initialiser le menu quand on arrive dessus}
  procedure initiaNbTourBoucle();
    begin
      nbTourBoucle:=0; //initialisation du nb de tour de boucle à 1 quand on arrive sur le menu
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



  {Procédure qui initialise la boucle du Jeu à True quand le programme est lancé}
  procedure initBoucleJeu();
    begin
       boucleJeu:=True;
    end;

  //Procédure qui sert à affecter True ou False à la variable boucleJeu
  procedure setBoucleJeu(valeur:Boolean);
    begin
       boucleJeu:=valeur;
    end;

  //Fonction qui sert à renvoyer la valeur de la variable boucleJeu
  function getBoucleJeu():Boolean;
    begin
       getBoucleJeu:=boucleJeu;
    end;


  //procédure qui sert à initialiser le nombre de tour
  procedure initNombreDeTour();
    begin
       nbTour:=0;
    end;

  //procédure qui sert à affecter le nombre de tour
  procedure setBoucleNbTour(valeur:Integer);
    begin
       nbTour:= nbTour+valeur;
    end;

  //fonction qui retourne la valeur du nb de tour
  function getNbTour():Integer;
    begin
       getNbTour:=nbTour; //retourne le nombre de tour
    end;

  //--------------Fin Fonctions et Procédure qui servent pour les Boucles des Menus---------------------//


  //--------------Procédures qui servent à décorer la zone de jeu---------------//

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

  {Procédure: écrit le nom du menu en pos x et y (en haut de l'écran)}
  procedure afficheNomMenu(nom:String);
    var
      posNomMenu: coordonnees; //variable, coordonnées de placement du texte nom en paramètre
    begin
      posNomMenu.x:=92; //initialisation placement en x passé en paramètre
      posNomMenu.y:=3; //initialisation placement en y du nom passé en paramètre
      ecrireEnPosition(posNomMenu,nom); //fonction de l'unité Gestion Ecran qui affiche le nom à la position posNomMenu
    end;

    procedure ecrireTexte(nom:String; x:Integer; y:Integer);
    var
      posTexte: coordonnees; //variable, coordonnées de placement du texte nom en paramètre
    begin
      posTexte.x:=x; //initialisation placement en x passé en paramètre
      posTexte.y:=y; //initialisation placement en y du nom passé en paramètre
      ecrireEnPosition(posTexte,nom); //fonction de l'unité Gestion Ecran qui affiche le nom à la position posNomMenu
    end;

   //--------------FIN Procédures qui servent à décorer la zone de jeu---------------//


   //--------------DEBUT Procédures qui servent pour les items---------------------//

  {Procédure qui affiche un item présents dans le menu en position X et Y}
  procedure affichageItem(item:String;posX,posY:Integer);
  var
    posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
  begin
    posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
    posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
    ecrireEnPosition(posItem,item); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem
  end;

 { procedure affichageBatiment(sorte: String; nom:String; propriety: String; posX,posY:Integer);
  var
    posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
    //marge: Integer;
    txtToDisplay: String;
  begin
    //marge:= 3;
    case propriety of
         'nom'              : txtToDisplay:= getBat_Nom(sorte,nom);
         'quantity'         : txtToDisplay:= 'Nombre : ' + IntToStr(getBat_Prop(sorte,nom,'quantity'));
         'nom_quantity'     : txtToDisplay:=  getBat_Nom(sorte,nom) + ' : ' + IntToStr(getBat_Prop(sorte,nom,'quantity'));
         'construct'        : txtToDisplay:= '[Cout de construction] '  + getBat_Cost_Txt(sorte,nom) + ']';
         'production'       : txtToDisplay:= '[Production de ressources]  ' + get_Bat_Prod_Txt(sorte,nom,'produit','total');
         'necessite'        : txtToDisplay:= '[Utilisation de ressources] ' +get_Bat_Prod_Txt(sorte,nom,'necessite','total');
         'productionUnique' : txtToDisplay:= '[Produit] ' + get_Bat_Prod_Txt(sorte,nom,'produit','unique');
         'necessiteUnique'  : txtToDisplay:= '[Utilise] ' +get_Bat_Prod_Txt(sorte,nom,'necessite','unique');
    end;
         posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
         posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
         ecrireEnPosition(posItem,txtToDisplay); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem

  end;  }


  {Procédure qui affiche tous les items d'un menu d'éléments txt passé en paramètre en position X et Y}
  {
  procedure affichageItemsMenu(menuTxt: Array of String;arrayCoordX,arrayCoordY:Array of Integer;const totaleItemsMenu: Integer);
  var
    item: Integer; //variable entière: compteur boucle affichage items menu interface
  begin
    //affichage des items du menu  (affichageItem est une fonction de bouclesJeux)
    for item:=1 to totaleItemsMenu do
        affichageItem(menuTxt[item],arrayCoordX[item],arrayCoordY[item]);
  end;
  }
  //--------------FIN Procédures qui servent pour les items---------------------//

end.

