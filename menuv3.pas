unit menuV3;

interface
{$codepage utf8}
{$mode objfpc}{$H+}
//appel des unités
uses GestionEcran,Keyboard,SysUtils, Windows ;

//procédure qui permet d'afficher chaque item d'un tableau avec un coefDePlacement entre chacun et de surligner l'élément choisi actuel par l'user
procedure afficherMenu();
//fonction qui donne les coordonnées de l'élément du menu sur lequel l'user est
function elementMenuActuelPixel():coordonnees;
//procedure qui colorie l'élément actuel choisie
procedure colorierElementActuel();
//procédure qui permet de naviguer dans un tableau grâce aux touches du clavier
//retourne la position de l'élément dans le tableau sur lequel l'user est
procedure navigationTabMenu(toucheClavier: TkeyEvent); //passage par référence d'itemActuelle
implementation
//ces constantes sont connues de toute l'unité
const
  //Nombre d'item dans le menu principale du jeu
  totaleItemsMenuPrinc=3;

  //Déclaration des items de notre menu initial
  txtCrea= 'Création de la partie';
  txtOption='Options' ;
  txtQuitter='Quitter la partie';


type
  //déclaration type menuPrinc qui va contenir les différents items de notre menu principale
  menuPrinc = array[1..totaleItemsMenuPrinc] of String;

//les variables sont connues de toute l'unité
var
  //Tableau qui contient les différents items de notre menu principale
  menuItem:menuPrinc =(txtCrea,txtOption,txtQuitter);

  itemActuelMenuPrinc: Integer=1; {variable choisi, position dans le tableau des élèments du menu, est incrémenté ou désincrémenté si l'user
                          descend ou monte avec les flèches directionnelles du clavier . Initialisé à 1}
  posItemActuel:coordonnees; //variable de type coordonnées, qui est la position de l'item actuel choisie

  placementItemX:Integer=50; //variable entière qui est la position en pixel en x de tous les items du menu
  placement1erItemY: Integer=5; //variable entière qui est la position en pixel en y du premier item du menu
  coefPlacementItem: Integer=1; //variable entière => espacement de 1 pixel entre chaque item

//procédure qui permet d'afficher chaque item d'un tableau avec un coefDePlacement entre chacun et de surligner l'élément choisi actuel par l'user
procedure afficherMenu();
var
  i: Integer; //variable entière : compteur
  posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y

begin
  posItem.x:=placementItemX; //initialisation du placement en x de l'item placement1erItemX(permet de placer l'item en tout point x passé en paramètre)
  posItem.y:=placement1erItemY; //initialisation du placement en y de l'item à placement1erElement (permet de placer le premier item en tout point y passé en paramètre)

  //parcourt du tableau pour afficher chaque item du menu
  //totalItems et menuItem sont des Constantes exterieures à la procédure
  for i:=1 to totaleItemsMenuPrinc do
      begin
        posItem.y:= posItem.y+coefPlacementItem; //permet à l'item suivant d'être espacé de la valeur de coefPlacementItem => permet un espacement de même valeur entre chaque item
        ecrireEnPosition(posItem,menuItem[i]); //fonction de l'unité Gestion Ecran qui affiche les items du menu à la position PosItem
      end;
end;

//fonction qui donne les coordonnées de l'élément du menu sur lequel l'user est
function elementMenuActuelPixel():coordonnees;
begin
     posItemActuel.x:= placementItemX;//initialisation du placement en pixel, en x de l'item actuel. TOUS les items du menu principal ont la même valeur en x
     posItemActuel.y:=placement1erItemY;//initialisation du placement en y de l'item actuel à la valeur en pixel y du premier item du menu
     posItemActuel.y:=posItemActuel.y+coefPlacementItem*itemActuelMenuPrinc; //donne la valeur en y en pixel de l'item actuel choisie
     elementMenuActuelPixel:=posItemActuel; //retournement des coordonnées de l'item actuel choisie par l'utilisateur
end;

//procedure qui colorie l'élément actuelle choisie
procedure colorierElementActuel();
begin
  ColorierZone(1,15,posItemActuel.x,posItemActuel.x+20,posItemActuel.y+coefPlacementItem*itemActuelMenuPrinc); //colorie l'élément actuelle choisie. Même procédé que le placement des items
end;

//procédure qui permet de naviguer dans un tableau grâce aux touches du clavier
//retourne la position de l'élément dans le tableau sur lequel l'user est
procedure navigationTabMenu(toucheClavier: TkeyEvent); //passage par référence d'itemActuelle
var
  //Les valeurs des différentes touches
  //défini lors des test avec le module Keyboard, cf programme test.pas
  flecheHaut:Integer = 33619745;
  flecheBas:Integer = 33619751;
begin
  //itemChoisi:=menuItem[index]; //initialisation de choix Item par défaut on est sur le 1er index du menu car position=1
  if (toucheClavier=flecheBas) then //si toucheClavier = touche du bas pressée alors on passe à l'élément suivant du tableau
     begin
       itemActuelMenuPrinc:=itemActuelMenuPrinc+1; //incrémentation de index
       //itemChoisi:=menuItem[i]; //Index suivant car incrémentation de index donc on prend l'item qui précède dans le tableau
     end
  else if (toucheClavier=flecheHaut) then //si toucheClavier = touche du haut pressée alors on passe à l'élément précédent du tableau
     begin
        itemActuelMenuPrinc:=itemActuelMenuPrinc-1; //décrémentation de index
        //itemChoisi:=menuItem[i]; //Index précédent car décrémentation de index, donc on prend l'item qui précède dans le tableau
     end ;
  {si la position est inférieur à 1 cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au dernier élément du tableau}
  if (itemActuelMenuPrinc=0) then
     itemActuelMenuPrinc:=totaleItemsMenuPrinc //revient au dernier élément du menu
     //itemChoisi:=menuItem[i];
  {si la position est supérieur à la taille du tableau cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au
  premier élément du tableau}
  else if (itemActuelMenuPrinc>totaleItemsMenuPrinc) then
       itemActuelMenuPrinc:=1;  //revient au premier élément du menu
     //itemChoisi:=menuItem[i];
end;


end.

