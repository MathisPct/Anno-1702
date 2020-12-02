unit navigationMenues;

{$mode objfpc}{$H+}

interface

  uses Keyboard;

  //procédure qui permet de naviguer dans un tableau grâce aux touches du clavier
  //retourne la position de l'élément dans le tableau sur lequel l'user est
  procedure navigationTabMenu(menu:Array Of String;touche: TkeyEvent;itemActuel:Integer);

  procedure initialisationItemActuel(valeur:Integer);  //cette procedure initialise l'itemActuel quand on lance le menu

  //fonction quie renvoie la valeur de la variable itemActuel
  function getItemActuel():Integer;

  //procedure qui modifie la valeur de la variable itemActuel
  procedure SetItemActuel(valeur:Integer);


  //procédure qui initialise l'item choisie: quand rien n'est choisie il est égale à 0
  procedure initItemChoisie();

  //fonction qui renvoie l'item choisie si l'user appuie sur entrée
  function getItemChoisie():Integer;

  //procédure qui modifie la valeur de l'item choisie si l'user appuie sur entrée
  procedure setItemChoisie(touche: TkeyEvent);


  //procédure qui initialise l'intem Anterieur à l'initialisation de l'itemActuel-1
  procedure initialisationItemAnterieur();

  //procédure qui modifie la valeur de la variable itemAnterieur
  procedure SetItemAnterieur(valeur:Integer);

  //fonction qui renvoie la valeur de la variable itemAnterieur
  function getItemAnterieur():Integer;


implementation
  //Glossaire
  //déclaration des variables  (elles sont connues de toute l'unité)
  var
    itemActuel:Integer; {variable entière qui est la position dans le tableau des élèments du menu, est incrémenté ou désincrémenté si l'user
                            descend ou monte avec les flèches directionnelles du clavier}
    itemAnterieur: Integer; {variable entière qui est l'item qui est l'avant dernier item choisie par l'user}

    itemChoisie: Integer; //variable entière qui est l'item choisi par l'user

   procedure initialisationItemActuel(valeur:Integer);  //cette procedure initialise l'itemActuel à un item du menu quand on lance le menu
     begin
       itemActuel:=valeur; //initialisation de l'itemActuel à 1 quand on ouvre le menu par exemple
     end;

   //procédure qui initialise l'intem Anterieur à l'initialisation de l'itemActuel-1
   procedure initialisationItemAnterieur();
     begin
       itemAnterieur:=getItemActuel()-1; // initialisation de l'item antérieur à l'intem actuel quand on rentre dans le boucle
     end;

   //procédure qui modifie la valeur de la variable itemAnterieur
   procedure SetItemAnterieur(valeur:Integer);
     begin
        itemAnterieur:=valeur; //incrémentation ou décrémentation suivant les valeurs des touches du clavier
     end;

  //fonction qui renvoie la valeur de la variable itemAnterieur
  function getItemAnterieur():Integer;
    begin
       getItemAnterieur:=itemAnterieur; //renvoie de la valeur de l'itemAnterieur
    end;

  //procedure qui modifie la valeur de la variable itemActuel
  procedure SetItemActuel(valeur:Integer);
    begin
        itemActuel:=getItemActuel()+valeur; //incrémentation ou décrémentation suivant les touches du clavier
    end;

  //fonction qui renvoie la valeur de la variable itemActuel
  function getItemActuel():Integer;
    begin
      getItemActuel:=itemActuel; //renvoie de la valeur de l'itemActuel
    end;

  //procédure qui permet de naviguer dans un tableau grâce aux touches du clavier  'haut' 'bas'
  //retourne la position de l'élément dans le tableau sur lequel l'user est
  procedure navigationTabMenu(menu:Array Of String; touche: TkeyEvent;itemActuel:Integer);
    var
      totaleItems:Integer; //variable entière qui est la taille du menu
    begin
      totaleItems:=Length(menu); //initialisation de totaleItem  à la longueur du menu
      if (touche=33619751) then //si toucheClavier = touche du bas pressée alors on passe à l'élément suivant du tableau
         begin
           //itemActuel:=itemActuel+1; //incrémentation de index
            SetItemActuel(1); //incrémentation de l'index du menu
            SetItemAnterieur(getItemActuel()-1);
         end
      else if (touche=33619745) then //si toucheClavier = touche du haut pressée alors on passe à l'élément précédent du tableau
         begin
            //itemActuel:=itemActuel-1; //décrémentation de index
            SetItemActuel(-1); //décrémentation de index du menu
            SetItemAnterieur(getItemActuel()+1);
         end;
      {si la position est inférieur à 1 cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au dernier élément du tableau}
      if (getItemActuel()<1) then
         begin
         //itemActuel:=totaleItems //revient au dernier élément du menu
         SetItemActuel(totaleItems); //revient au dernier élément du menu
         SetItemAnterieur(1);
         end
      {si la position est supérieur à; la taille du tableau cela veut dire qu'on sort du tableau, donc pour patche ce soucis on revient au
      premier élément du tableau}
      else if (getItemActuel()>totaleItems) then
         begin
           //itemActuel:=1;  //revient au premier élément du menu
           initialisationItemActuel(1); //revient au premier élément du menu
         end;
    end;

  //procédure qui initialise l'item choisie: quand rien n'est choisie il est égale à 0
  procedure initItemChoisie();
   begin
     itemChoisie:=0;
   end;

  //procédure qui modifie la valeur de l'item choisie si l'user appuie sur entrée
  procedure setItemChoisie(touche: TkeyEvent);
    begin
      if (touche=7181) then
         itemChoisie:=getItemActuel();
    end;

  //fonction qui retourne la valeur de itemChoisie
  function getItemChoisie():Integer;
    begin
      getItemChoisie:=itemChoisie; //renvoie l'item du menu qu'a choisie l'user
    end;

end.

