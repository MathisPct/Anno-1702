unit population ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils, GestionEcran, unitRessources ;

  type pop = record
    nomType:String; //nom du type de la population
    nombre: Integer; //nb de colons
    coefNutrition:Real; //coef faim de la population
    coefConfort: Real; //coef confort de la population (utilisation laine, tissus)
  end;


  {Procédure qui initialise le nom de la pop et le coef Nutrition}
  procedure initCaractPop();

  {procédure qui modifie et calcul de la valeur du nombre de la population}
  procedure setNbPop(numType,quantiteMaison,capaMaison:Integer);

  {procédure qui modie la valeur des différentes ressources qui ont été consommé}
  procedure consommation(numType:Integer);

  {procedure qui affiche la valeur du nombre de la pop en position x et y}
  procedure afficheNbHab(numType,posX,posY:Integer);

  {Fonction qui renvoie la valeur de la population}
  function getNbHab():Integer;

  {Fonction qui renvoie la consommation de poissons}
  function eatFish():Integer;

  {fonction qui renvoie la laine consommée}
  function consoLaine():Integer;

implementation
  const
    nbTotalTypeHabitant=1; //constante: nb de catégories de pop (colons)

  var
    typeHabitant: array[1..nbTotalTypeHabitant] of pop; //tableau contenant le type de population

  {Procédure qui initialise le nom de la pop et le coef Nutrition}
  procedure initCaractPop();
    begin
      //initialisation colons
      typeHabitant[1].nomType := 'colons';
      typeHabitant[1].coefNutrition := 0.1; //initialisation du coef de nutrition à 0.1
      typeHabitant[1].coefConfort := 0.1; //initialisation du coef de confort à 0.1
    end;

  {procédure qui modifie et calcul la valeur du nombre de la population}
  procedure setNbPop(numType,quantiteMaison,capaMaison:Integer);
    var
      nbPop: Integer;
    begin
      nbPop:=quantiteMaison*capaMaison; //modifie la valeur du nb de pop sur l'Ile
      typeHabitant[numType].nombre:=nbPop;
    end;

  {procedure qui affiche la valeur du nombre de la pop en position x et y}
  procedure afficheNbHab(numType,posX,posY:Integer);
    const
      txtNbHab='Nombre d''habitant: '; //constante chaine de caractère txt description
    var
      posTxtNbHab:coordonnees; //variable type coordonnées: position du texte 'Nombre d'habitant
      posNbHab: coordonnees; //variable type coordonnées: position nb habitant
    begin
      posTxtNbHab.x:=posX;
      posTxtNbHab.y:=posY;
      posNbHab.x:=posX+Length(txtNbHab)+1;
      posNbHab.y:=posY;
      ecrireEnPosition(posTxtNbHab,txtNbHab);
      ecrireEnPosition(posNbHab,IntToStr(typeHabitant[numType].nombre));
    end;

  {Fonction qui renvoie la valeur de la population}
  function getNbHab():Integer;
    begin
      getNbHab:=typeHabitant[1].nombre; //renvoie de la valeur des habitants
    end;

  {Fonction qui renvoie la consommation de poissons}
  function eatFish():Integer;
    begin
       eatFish:=round((typeHabitant[1].nombre * typeHabitant[1].coefNutrition)); //calcul du nombre de poissons mangés par la pop
    end;

  {fonction qui renvoie la laine consommée}
  function consoLaine():Integer;
    begin
       consoLaine:=round((typeHabitant[1].nombre * typeHabitant[1].coefConfort)); //calcul du nombre de laines mangés par la pop
    end;

  {procédure qui modie la valeur des différentes ressources qui ont été consommé}
  procedure consommation(numType:Integer);
    begin
      //modif des valeurs des ressources
      //if (getFish()>0) then
      setFish(-eatFish()); //soustraction de fishEat à la quantité de poissons
      setLaine(-consoLaine()); //soustraction de laineConso à la quantité de laine
    end;

end.

