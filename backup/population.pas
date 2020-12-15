{$codepage utf8}
unit population ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils, GestionEcran, unitRessources , bouclesJeux, UnitBuilding;

  type pop = record
    nomType:String; //nom du type de la population
    nbPopCatego: Integer; //nb de pop dans une catégorie de personnes
    nbPopMort: Integer; //nb de pop mort dans une catégorie de personnes
    coefNutrition:Real; //coef faim de la population
    coefConfort: Real; //coef confort de la population (utilisation laine, tissus)
    coefReprod: Real; //coef de reproduction qui change en fonction du niveau bonheur
    bonheur: String; //niveau de bonheur
  end;


  {Procédure qui initialise le nom de la pop et le coef Nutrition}
  procedure initCaractPop();

  {procédure qui modifie et calcul la valeur du nombre de la population}
  procedure setNbCategoPop(numType,quantiteMaisonGagne,capacite:Integer);

  {procédure qui modie la valeur des différentes ressources qui ont été consommé par la pop}
  procedure consommation();

  {procedure qui affiche les différents nb d'habitants de chaque catégorie en position x et y}
   procedure afficheNbHabCatego(espacement,posX,posYPremierItem:Integer);

   {fonction qui retourne le nombre total de personnes d'une catégorie de pop}
   function getNbHabCatePop(numType: Integer):Integer;

   {Fonction qui renvoie le nb total d'une population}
   function getNbTotalPop():Integer;

  {procédure : modifie la valeur du nb totale de la pop }
  procedure setNbHab(valeur,numType: Integer);

  {Fonction qui renvoie la consommation de poissons}
  function eatFish(numType:Integer):Integer;

  {fonction qui renvoie la laine consommée}
  function consoLaine(numType:Integer):Integer;

  {Procédure qui affiche les ressources consommées par les colons durant le tour en position x et y}
  procedure affichageRessourcesConsoColons(posX,posY:Integer);

  {Procédure qui affiche les ressources consommées par les citoyens durant le tour en position x et y}
  procedure affichageRessourcesConsoCitoyens(posX,posY:Integer);

  {procédure qui affiche l'or rapporté par la population durant le tour en position x et y}
  procedure affichageOrPop(posX,posY: Integer);

  {procedure qui écrit les besoins de la pop dans le menu tour suivant}
  procedure besoinsColons(posX,posY:Integer);

  {procedure qui écrit les besoins de la pop dans le menu tour suivant en posX et posY}
  procedure besoinsCitoyens(posX,posY: Integer);

  {procedure qui modifie le nombre de mort d'une population }
  procedure setNbMortCatego(numType,nbMort: Integer);

  {procédure qui update le niveau de bonheur des colons suivant les besoins accomplies}
  procedure updateBonheurColons();

  {procédure qui update le niveau de bonheur des citoyens suivant les besoins accomplies}
  procedure updateBonheurCitoyens();

  {procédure qui affiche le niveau de bonheur des 2 catégories d'habitants en posX et posY}
  procedure printBonheurHab(posX,posY: Integer);

  {fonction qui renvoie true si les bonheurs des colons sont tous validés}
  function getEtatAllBesoinsColons(): Boolean;

implementation
  const
    nbTotalTypeHabitant=2; //constante: nb de catégories de pop (colons)

  var
    typeHabitant: array[1..nbTotalTypeHabitant] of pop; //tableau contenant le type de population
    nbTotalPop: Integer; //variable integer nb total de la population
    coefTravail: Real; //coef de travail commun à toute pop qui permet de rapporter de l'or

    //besoins colons
    besoinFishColons: Boolean;
    besoinWoodColons: Boolean;
    besoinLaineColons: Boolean;
    besoinVilleColons: Boolean;
    besoinChappelleColons: Boolean;

  {Procédure qui initialise les différentes catégories de population}
  procedure initCaractPop();
    begin
      //initialisation colons
      typeHabitant[1].nomType := 'colons';
      typeHabitant[1].nbPopCatego :=0;  //init nb pop
      typeHabitant[1].coefNutrition := 0.3; //initialisation du coef de nutrition à 0.1
      typeHabitant[1].coefConfort := 0.3; //initialisation du coef de confort à 0.1
      typeHabitant[1].nbPopMort:=0;
      typeHabitant[1].bonheur:='malheureux'; //initialisation du niv de bonheur des colons

      //initialisation citoyens
      typeHabitant[2].nomType := 'citoyens';
      typeHabitant[2].nbPopCatego := 0; //init nb pop
      typeHabitant[2].coefNutrition := 0.3; //initialisation du coef de nutrition citoyens
      typeHabitant[2].coefConfort := 0.3; //initialisation du coef de confort citoyens
      typeHabitant[2].nbPopMort:=0;
      typeHabitant[2].bonheur:='malheureux'; //initialisation du niv de bonheur des citoyens
      coefTravail:= 0.5;
    end;

  {fonction qui modifie le coef de reproduction d'un type d'habitant en fonction de son niv de bonheur}
  procedure setCoefRep(numType:Integer);
    begin
      if (typeHabitant[numType].bonheur='malheureux') then
         typeHabitant[numType].coefReprod := 0.25
      else if (typeHabitant[numType].bonheur='satisfait') then
         typeHabitant[numType].coefReprod := 0.5
      else if (typeHabitant[numType].bonheur='content') then
         typeHabitant[numType].coefReprod := 0.8
      else if (typeHabitant[numType].bonheur='heureux') then
         typeHabitant[numType].coefReprod := 1;
    end;

  {procédure qui modifie et calcul la valeur du nombre de la population}
  procedure setNbCategoPop(numType,quantiteMaisonGagne,capacite:Integer);
    begin
      setCoefRep(numType);
      typeHabitant[numType].nbPopCatego:=typeHabitant[numType].nbPopCatego+round(quantiteMaisonGagne*capacite*typeHabitant[numType].coefReprod); //modifie la valeur du nb d'une catégorie
    end;

  {
    {procédure qui modifie et calcul la valeur du nombre de la population}
  procedure setNbCategoPop(numType,quantiteMaisonDebTour,capaMaison:Integer);
    begin
      typeHabitant[numType].nbPopCatego:=typeHabitant[numType].nbPopCatego+(quantiteMaison*capaMaison)-typeHabitant[numType].nbPopMort; //modifie la valeur du nb d'une catégorie
    end;
    }

  {procedure qui modifie le nombre d'une population en lui affectant les morts}
  procedure setNbMortCatego(numType,nbMort: Integer);
    begin
      typeHabitant[numType].nbPopCatego:=typeHabitant[numType].nbPopCatego-nbMort;
    end;

  {Fonction qui renvoie le nb total d'une population}
  function getNbTotalPop():Integer;
    var
      numType: Integer; //numéro type d'une catégorie d'une population
      nbTotalPop: Integer; //nombre totale de la population
    begin
      nbTotalPop:=0;
      for numType:=1 to nbTotalTypeHabitant do
        nbTotalPop:=nbTotalPop + typeHabitant[numType].nbPopCatego; //ajoute le nombre d'habitant d'une catégorie à nbTotalPop
      getNbTotalPop:=nbTotalPop;
    end;

  {fonction qui retourne le nombre total de personnes d'une catégorie de pop}
  function getNbHabCatePop(numType: Integer):Integer;
    begin
      getNbHabCatePop:=typeHabitant[numType].nbPopCatego; //retourne le nb d'hab dans la catégorie en question
    end;

  {procedure qui affiche la valeur du nombre de la pop en position x et y}
  procedure afficheNbHabCatego(espacement,posX,posYPremierItem:Integer);
    var
      txtNbHab:String;
      numType: Integer; //type de population (colons, citoyens...)
    begin
      for numType:=1 to nbTotalTypeHabitant do
        begin
          txtNbHab:= 'Nombre de '+ typeHabitant[numType].nomType+' :'+IntToStr(getNbHabCatePop(numType));  //concaténation de plusieurs str le text description avec la quantité gagné de chaque item
          ecrireTexte(txtNbHab,posX,posYPremierItem); //ecrit le txt description avec la quantité de ress gagné
          posYPremierItem:=posYPremierItem+espacement; //incrément de la posY de l'item suivant
        end;
    end;

  {procédure : modifie la valeur du nb totale de la pop }
  procedure setNbHab(valeur,numType: Integer);
    begin
      typeHabitant[numType].nbPopCatego:= typeHabitant[numType].nbPopCatego+valeur;
    end;

  {Fonction qui renvoie la consommation de poissons par une catégorie de population}
  function eatFish(numType: Integer):Integer;
    begin
       eatFish:=round((typeHabitant[numType].nbPopCatego * typeHabitant[numType].coefNutrition)); //calcul du nombre de poissons mangés par la pop
    end;

  {fonction qui renvoie la laine consommée par une catégorie de population}
  function consoLaine(numType: Integer):Integer;
    begin
       consoLaine:=round((typeHabitant[1].nbPopCatego  * typeHabitant[numType].coefConfort)); //calcul du nombre de laines mangés par la pop
    end;

  {Fonction qui renvoie l'or rapporté par une catégorie de population}
  function orRapporte(): Integer;
    begin
      orRapporte:= round(getNbTotalPop()*coefTravail); //calcul du nombre d'or rapportés par la pop
    end;

  {procédure qui modie la valeur des différentes ressources qui ont été consommé par la population}
  procedure consommation();
    var
      numTypePop: Integer; //variable entière: compteur de la boucle (numéro de catégo d'une pop)
    begin
      // parcourt des différents types de pop et affectation des consommation de chaque ressources
      for numTypePop:=1 to nbTotalTypeHabitant do
        begin
          setFish(-eatFish(numTypePop)); //soustraction de fishEat à la quantité de poissons
          setGold(orRapporte()); //ajout or à la quantité d'or en stock
        end;
    end;

  {Procédure qui affiche les ressources consommées par les colons durant le tour en position x et y}
  procedure affichageRessourcesConsoColons(posX,posY:Integer);
    const
      txtConso= 'Ressources consommées par les colons: ';
    var
      texte: String;
    begin
      if (typeHabitant[1].nbPopCatego>0) then
         texte:=txtConso+ IntToStr(eatFish(1)) + ' poissons '
      else
         texte:='Vous n''avez pas encore de colons sur votre île';
      ecrireTexte(texte,posX,posY);
    end;

    {Procédure qui affiche les ressources consommées par les citoyens durant le tour en position x et y}
  procedure affichageRessourcesConsoCitoyens(posX,posY:Integer);
    const
      txtConso= 'Ressources consommées par les citoyens: ';
    var
      texte: String;
    begin
      if (getNbHabCatePop(2)>0) then
         texte:=txtConso+ IntToStr(eatFish(2)) + ' poissons ' + IntToStr(consoLaine(2)) + ' laines'
      else
         texte:='Vous n''avez pas encore de citoyens sur votre île';
      ecrireTexte(texte,posX,posY);
    end;

  {procédure qui affiche l'or rapporté par la population durant le tour en position x et y}
  procedure affichageOrPop(posX,posY: Integer);
    var
      texte: String;
    begin
      if (getNbTotalPop()>0) then
         texte:= 'Les habitants de l''île vous ont rapporté '+ IntToStr(orRapporte()) + ' d''or'
      else
         texte:='';
      ecrireTexte(texte,posX,posY);
    end;

  //Besoins des colons
  {fonction qui retourne si le besoin de poissons pour les colons est vrai ou faux s'il est satisfait}
  function getBesoinFish(): Boolean;
    begin
      if (getBat_Prop(2, 'quantity')<1) then
         getBesoinFish:= True  //besoin insatisfait
      else if (getBat_Prop(2, 'quantity')>=1) then
         getBesoinFish:= False; //besoin satisfait
    end;

  {fonction qui retourne si le besoin de bois pour les colons est vrai ou faux s'il est satisfait}
  function getBesoinWood(): Boolean;
    begin
      if (getBat_Prop(3, 'quantity')<3) then
         getBesoinWood:= True  //besoin insatisfait
      else if (getBat_Prop(3, 'quantity')>=3) then
         getBesoinWood:= False; //besoin satisfait
    end;

  {fonction qui retourne si le besoin de tissus pour les colons est vrai ou faux s'il est satisfait}
  function getBesoinTissus(): Boolean;
    begin
      if (getBat_Prop(5, 'quantity')<1) then
         getBesoinTissus:= True  //besoin insatisfait
      else if (getBat_Prop(5, 'quantity')>=1) then
         getBesoinTissus:= False; //besoin satisfait
    end;

   {Fonction qui retourne true si une ville a besoin d'être construite pour la pop}
  function getBesoinCity():Boolean;
    begin
      if (getBat_Prop(7, 'quantity')<1) then
         getBesoinCity:=True
      else if (getBat_Prop(7, 'quantity')>=1) then
         getBesoinCity:=False;
    end;

  {fonction qui retourne true si une chappelle n'est pas construite}
  function getBesoinChap():Boolean;
    begin
      if (getBat_Prop(6, 'quantity')<1) then
         getBesoinChap:=True
      else if (getBat_Prop(6, 'quantity')>=1) then
         getBesoinChap:=False;
    end;

  {procedure qui écrit les besoins de la pop dans le menu tour suivant}
  procedure besoinsColons(posX,posY:Integer);
    begin
      if (getNbHabCatePop(1)>0)   then
         begin
            if (getBesoinFish()) then
               ecrireTexte('Vos colons vous demande plus de poissons!',posX,posY);
            if ((getBesoinWood()) and not(getBesoinFish()) ) then
               ecrireTexte('Vos colons vous demande plus de bois',posX,posY);
            if ((getBesoinTissus()) and(not(getBesoinWood())) and (not(getBesoinFish())) ) then
               ecrireTexte('Vos colons vous demande du tissus',posX,posY);
            if ((getBesoinCity()) and (not(getBesoinTissus())) and(not(getBesoinWood())) and (not(getBesoinFish())) ) then
               ecrireTexte('La population vous demande un centre-ville!',posX,posY);
            if ((getBesoinChap()) and (not(getBesoinCity()=True)) and (not(getBesoinTissus())) and(not(getBesoinWood())) and (not(getBesoinFish())) )then
               ecrireTexte('Votre population aimerait bien une chappelle!',posX,posY);
         end;
    end;

  {fonction qui renvoie true si les bonheurs des colons sont tous validés}
  function getEtatAllBesoinsColons(): Boolean;
    var
      temp:Boolean;
    begin
      temp:=False;
      //si tous les besoins des colons sont satisfait
      if ( (not(getBesoinChap)) and (not(getBesoinCity)) and (not(getBesoinTissus)) and (not(getBesoinWood)) and (not(getBesoinFish)) )then
         temp:=True;
      getEtatAllBesoinsColons:=temp;
    end;

  //besoins citoyens
  {fonction qui retourne true si la quantité des batiments est inférieur ou égale à 5 }
  function getBesoinFishCitoyens(): Boolean;
    begin
      if (getBat_Prop(2, 'quantity')<5) then
         getBesoinFishCitoyens:=True
      else if (getBat_Prop(2, 'quantity')>=5) then
         getBesoinFishCitoyens:=False;
    end;

  function getBesoinBoisCitoyens(): Boolean;
    begin
      if (getBat_Prop(3, 'quantity')<6) then
         getBesoinBoisCitoyens:=True
      else if (getBat_Prop(3, 'quantity')>=6) then
         getBesoinBoisCitoyens:=False;
    end;

  function getBesoinTissusCitoyens(): Boolean;
    begin
      if (getBat_Prop(5, 'quantity')<3) then
         getBesoinTissusCitoyens:=True
      else if (getBat_Prop(5, 'quantity')>=3) then
         getBesoinTissusCitoyens:=False;
    end;

  function getBesoinChappelleCitoyens(): Boolean;
    begin
      if (getBat_Prop(6, 'quantity')<2) then
         getBesoinChappelleCitoyens:=True
      else if (getBat_Prop(6, 'quantity')>=2) then
         getBesoinChappelleCitoyens:=False;
    end;

  //function getBesoi

  {procedure qui écrit les besoins de la pop dans le menu tour suivant en posX et posY}
  procedure besoinsCitoyens(posX,posY: Integer);
    begin
      if (getNbHabCatePop(2)>0) then
           begin
              if (getBesoinFishCitoyens()) then
                 ecrireTexte('Vos citoyens vous demande plus de poissons!',posX,posY);
              if ((getBesoinBoisCitoyens()) and not(getBesoinFishCitoyens()) ) then
                 ecrireTexte('Vos citoyens vous demande plus de bois',posX,posY);
              if ((getBesoinTissusCitoyens()) and (not(getBesoinFishCitoyens)) and (not(getBesoinBoisCitoyens)) ) then
                 ecrireTexte('Vos citoyens vous demande plus de laines',posX,posY);
              if ((getBesoinChappelleCitoyens) and (not(getBesoinTissusCitoyens)) and (not(getBesoinFishCitoyens)) and (not(getBesoinBoisCitoyens))) then
                 ecrireTexte('Vos citoyens vous demande de construire plus de chapelles',posX,posY);
           end;
    end;

  {procédure qui update le niveau de bonheur des colons suivant les besoins accomplies}
  procedure updateBonheurColons();
    begin
      if (typeHabitant[1].nbPopCatego>0) then
         begin
            if ( (getBesoinChap) and (getBesoinCity) and (getBesoinTissus) and (getBesoinWood) and (getBesoinFish) )  then
               typeHabitant[1].bonheur:='malheureux';
            if ( (not(getBesoinFish)) or (not(getBesoinWood)) or (not(getBesoinTissus)) or (not(getBesoinChap)) or (not(getBesoinCity)) ) then
               typeHabitant[1].bonheur:= 'satisfait';
            if ( (not(getBesoinChap)) or (not(getBesoinCity)) or ( (not(getBesoinFish)) and (not(getBesoinWood)) and (not(getBesoinTissus)) ) ) then
               typeHabitant[1].bonheur:= 'content';
            if ( (not(getBesoinFish)) and (not(getBesoinWood)) and (not(getBesoinTissus)) and (not(getBesoinChap)) and (not(getBesoinCity)) )then
               typeHabitant[1].bonheur:= 'heureux';
         end;
    end;

  {procédure qui update le niveau de bonheur des citoyens suivant les besoins accomplies}
  procedure updateBonheurCitoyens();
    begin
      if (typeHabitant[2].nbPopCatego>0) then
         begin
           if ( (getBesoinChappelleCitoyens) and (getBesoinTissusCitoyens) and (getBesoinFishCitoyens) and (getBesoinBoisCitoyens)) then
              typeHabitant[2].bonheur := 'malheureux';
           if ( (not(getBesoinFishCitoyens)) or (not(getBesoinBoisCitoyens)) or (not(getBesoinTissusCitoyens)) or (not(getBesoinChappelleCitoyens)) ) then
              typeHabitant[2].bonheur := 'satisfait';
           if ( (not(getBesoinChappelleCitoyens)) or ( (not(getBesoinFishCitoyens)) and (not(getBesoinBoisCitoyens)) and (not(getBesoinChappelleCitoyens)) ) ) then
              typeHabitant[2].bonheur := 'content';
           if ( (not(getBesoinChappelleCitoyens)) and (not(getBesoinFishCitoyens)) and (not(getBesoinBoisCitoyens)) and (not(getBesoinChappelleCitoyens)) ) then
              typeHabitant[1].bonheur:= 'heureux';
         end;
    end;

  {procédure qui affiche le niveau de bonheur des 2 catégories d'habitants en posX et posY}
  procedure printBonheurHab(posX,posY: Integer);
    var
      texte:String;
    begin
      if (typeHabitant[1].nbPopCatego>0) then
         begin
            texte:= 'Vos colons sont ' + typeHabitant[1].bonheur;
            ecrireTexte(texte,posX,posY);
         end;
      if (typeHabitant[2].nbPopCatego>0) then
         begin
           texte:= 'Vos citoyens sont ' + typeHabitant[2].bonheur;
           ecrireTexte(texte,posX,posY+1);
         end;
    end;

end.

