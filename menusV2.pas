{$mode objfpc}{$H+}
{$codepage utf8}
program menusV2;

//appel des unités
uses GestionEcran,Keyboard,SysUtils, Windows ;


const
  //Taille de notre fenêtre de jeu
  largeur=200;  //largeur de la fenêtre
  hauteur=60; //hauteur de la fenêtre

  //Déclaration des items de notre menu initial
  txtCrea= 'Création de la partie';
  txtOption='Options' ;
  txtQuitter='Quitter la partie';

  //Nombre d'item dans les menus
  //nb d'item dans le menu principale du jeu
  totaleItemsMenuPrinc=3;

  //Les valeurs des différentes touches
  //défini lors des test avec le module Keyboard, cf programme test.pas
  flecheHaut:Integer = 33619745;
  flecheBas:Integer = 33619751;
  toucheEsc:Integer = 283;

 type
   //déclaration Tableau qui va contenir les différents items de notre menu principale
   menuPrinc = array[1..totaleItemsMenuPrinc] of String;


var
  posCurseur: coordonnees ; //Variable de type coordonnees qui prendra la valeur de fonction positionCurseur

  toucheClavier: TkeyEvent; //Variable de type TkeyEvent issue de l'unité Keyboard

  menuItem:menuPrinc =(txtCrea,txtOption,txtQuitter);   // varriable de type menuPrinc qui contient les différents items de notre menu principale

  continuerMenu : Boolean; //Variable de type boolean => tant que sa valeur est True alors on reste dans le menu
  coefPlacementItem: Integer; //variable entière => espacement y en pixel entre chaque item
  itemActuelMenuPrinc: Integer; {variable choisi, position dans le tableau des élèments du menu, est incrémenté ou désincrémenté si l'user
                          descend ou monte avec les flèches directionnelles du clavier}


//procédure qui permet d'afficher chaque item d'un tableau avec un coefDePlacement entre chacun ,de surligner l'élément choisi actuel par l'user, et de placer le curseur
procedure afficherMenu(var menu:Array of String;coefPlacementItem,elementMenuActuelle,placementItemX,placement1erItemY:Integer);
var
  i: Integer; //variable entière : compteur
  posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y

begin
  posItem.x:=placementItemX; //initialisation du placement en x de l'item placement1erItemX(permet de placer l'item en tout point x passé en paramètre)
  posItem.y:=placement1erItemY ; //initialisation du placement en y de l'item à placement1erElement (permet de placer le premier item en tout point y passé en paramètre)

  //parcourt du tableau pour afficher chaque item du menu
  //totalItems et menuItem sont des Constantes exterieures à la procédure
  for i:=1 to totaleItemsMenuPrinc do
      begin
        posItem.y:= posItem.y+coefPlacementItem; //permet à l'item suivant d'être espacé de la valeur de coefPlacementItem => permet un espacement de même valeur entre chaque item
        ecrireEnPosition(posItem,menuItem[i]); //fonction de l'unité Gestion Ecran qui affiche les items du menu à la position PosItem
      end;
  posItem.y:=placement1erItemY+coefPlacementItem*elementMenuActuelle; //initialisation du placement en y de l'item à placement1erElement (permet de placer où on veut le menu)
  ColorierZone(1,15,posItem.x,posItem.x+20,posItem.y); //colorie l'élément actuelle choisie. Même procédé que le placement des items
  changerColonneCurseur(posItem.x);
  changerLigneCurseur(posItem.y);
end;

//procédure qui permet de naviguer dans un tableau grâce aux touches du clavier
//retourne la position de l'élément dans le tableau sur lequel l'user est
procedure navigationTabMenu(totaleItems:Integer;toucheClavier: TkeyEvent;var itemActuelle:Integer); //passage par référence d'itemActuelle
begin
  //itemChoisi:=menuItem[index]; //initialisation de choix Item par défaut on est sur le 1er index du menu car position=1
  if (toucheClavier=flecheBas) then //si toucheClavier = touche du bas pressée alors on passe à l'élément suivant du tableau
     begin
       itemActuelle:=itemActuelle+1; //incrémentation de index
       //itemChoisi:=menuItem[i]; //Index suivant car incrémentation de index donc on prend l'item qui précède dans le tableau
     end
  else if (toucheClavier=flecheHaut) then //si toucheClavier = touche du haut pressée alors on passe à l'élément précédent du tableau
     begin
        itemActuelle:=itemActuelle-1; //décrémentation de index
        //itemChoisi:=menuItem[i]; //Index précédent car décrémentation de index, donc on prend l'item qui précède dans le tableau
     end ;


  {si la position est inférieur à 1 cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au dernier élément du tableau}
  if (itemActuelle=0) then
     itemActuelle:=totaleItems //revient au dernier élément du menu
     //itemChoisi:=menuItem[i];
  {si la position est supérieur à la taille du tableau cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au
  premier élément du tableau}
  else if (itemActuelle>totaleItems) then
       itemActuelle:=1;  //revient au premier élément du menu
     //itemChoisi:=menuItem[i];
end;

begin
  //initialisation générale
  //initialisation de l'unité Keyboard
  InitKeyboard;

  //Initialisation de la taille de notre fenêtre de jeu
  changerTailleConsole(largeur,hauteur);

  //au démarrage du jeu, le joueur arrive sur le menu
  continuerMenu:=True;

  coefPlacementItem:=1; //espace entre chaque item de 3px
  itemActuelMenuPrinc :=1; //initialisation de la variable. Par défaut l'élément choisi a comme valeur le premier élément du tableau menu
  posCurseur:=positionCurseur();  //initialisation des coordoonnées du curseur
  while (continuerMenu=True) do
  begin
    afficherMenu(menuItem,coefPlacementItem,itemActuelMenuPrinc,50,5); //appel de la procédure afficherMenu pour afficher chaque item du menu et l'élément séléctionné à un endroit précis dans la console : Mise à jour de l'écran permet
    toucheClavier:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui reçoit les évènements du clavier
    toucheClavier:= TranslateKeyEvent(toucheClavier); //retourne la valeur ascii de la touche si elle est pressée . Variable de type int
    navigationTabMenu(totaleItemsMenuPrinc,toucheClavier,itemActuelMenuPrinc); //permet de se déplacer dans le tableau suivant si on fait fleche haut ou bas
    effacerEcran;   //permet de mettre à jour l'élément séléctionné
  end;
  readln;
end.

