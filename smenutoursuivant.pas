{$codepage utf8}
unit smenutoursuivant ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils , GestionEcran , bouclesJeux , navigationMenues , Keyboard , population , sMenuMarchand , unitRessources  ;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu tour suivant }
  procedure maintSMenuTs();

implementation
  //déclaration des constantes connues de toute l'unit
  const
    //nb d'items dans le menu
    totaleItemsMenu = 1;

    //déclaration des items textuels de notre menu
    txtPasser       = 'Menu Interface'; //constante chaine de caractère 1er item du menu
    //Déclaration des coordonnées des items du Menu
    txtPasserX       = 80; //abcisse de l'item txtPasser
    txtPasserY       = 50; //ordonnées de l'item txtPasser

  //déclaration variables connues de toute l'unité
  var
    //tableau qui contient les textes des items du menu
    menuTourSuivant:array[1 .. totaleItemsMenu] of String=(txtPasser);
    //tableau qui contient les coordonnées des items du menu
    menuTourSuivantX: array[1 .. totaleItemsMenu] of Integer=(txtPasserX);
    menuTourSuivantY: array[1 .. totaleItemsMenu] of Integer=(txtPasserY);

    touche: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

  {Procédure qui affiche les ressources consommées par la pop durant le tour en position x et y}
  procedure affichageRessourcesConso();
    const
      txtConso= 'Ressources consommées par la population: ';
      txtRessourcesEmpty= ' aucunes';
    var
      texte: String;
    begin
      texte:=txtConso+ IntToStr(eatFish()) + ' poissons ' + IntToStr(consoLaine()) + ' laines';
      ecrireTexte(texte,10,12);
    end;

  {procédure qui fait appel à toutes les procédures d'affichage => affichage de tous les éléments du menu tour suivant}
  procedure affichage();
    begin
      rectangleZoneJeu; //appel de la procédure: on dessine le rectangle sur l'écran
      cadreTxtNomMenu; //procédure qui dessine le cadre qui entoure le texte en haut au milieu
      afficheNomMenu('Tour suivant'); //procédure écrit nom menu
      affichageRessourcesConso();
      printItemsMenu(totaleItemsMenu,menuTourSuivant,menuTourSuivantX,menuTourSuivantY); //affichage des éléments du menu tour suivant
    end;

  {Procédure qui appelle toutes les fonctions et procédures pour afficher et interragir avec le menu tour suivant }
  procedure maintSMenuTs();
    var
      running: Boolean; //variable booleenne qui permet de démarrer le menu
    begin
      running:=True; //init boucle à true quand on arrive sur le menu
      initiaNbTourBoucle(); //init nb tour boucle pour afficher les éléments 1 fois puis attendre event keyboard

      //tant que le menu est lancé executer les insctruction
      while (running) do
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
              affichage();// affichage des éléments du menu 1
              printAllRessQuantityGagne(10,15,1);
              colorierElementActu(10,60,menuTourSuivantX,menuTourSuivantY);  //initialisation de colorierElementActuel
            end

          //sinon on capte à tout instant les touches du clavier pour savoir s'il faut se déplacer dans le menu etc
          else if (getNbTourBoucle()>=1) then
            begin
              touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
              touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
              setItemChoisie(touche);
              navigationTabMenu(menuTourSuivant,touche,getItemActuel());//appel de la procédure qui permet de naviguer dans le tableau du menu, tant qu'on a pas choisi une option dans le menu, on reste dans le menucolorierElementActuel();
              colorierElementActu(10,60,menuTourSuivantX,menuTourSuivantY);  //colorie l'item actuel
              reintialiserElementAnt(10,60,menuTourSuivantX,menuTourSuivantY); //réintialise la couleur de l'item précedemment choisie
            end;

          incrementaNbTourBoucle(); //incrémentation du tour de boucle

          //choix dans le menu
          Case (getItemChoisie()) of
            1:
              begin
                InitiaNbTourBoucle();
                running:=False; //fin boucle
              end;
          end;//fin case of
        end; //fin boucle tant que
    end;//fin procédure
end.

