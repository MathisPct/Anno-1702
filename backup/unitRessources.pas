{$codepage utf8}
unit unitRessources;

{$mode objfpc}{$H+}

interface
  uses
    Classes, SysUtils , GestionEcran ,bouclesJeux  ;

  type
   ressources=record
     nom:String;
     quantite: Integer;
     prixVente: Integer; //prix de vente et d'achat en or d'une ressource
     quantiteTPrecedent:Integer; //quantité de ressources du tour précédent
   end;

   enumRessources=(gold,wood,fish,laine,tissu,tool); //énumération des différentes ressources

  //Cette fonction initialise les variables (au début de la partie par exemple)
  procedure initRessource();
  //Cette fonction renvoie la valeur de la variable Or
  function getGold() : Integer;
  //Cette procedure modifie la valeur de la variable Or
  procedure setGold(valeur : integer);
  //Cette fonction renvoie la valeur de la variable Bois

  //renvoie variable Bois
  function getWood() : Integer;
  //modifie variable bois
  procedure setWood(valeur : integer);
  //renvoie variable poisson
  function getFish() : integer;
  //cette procedure modifie la valeur de la variable poisson
  procedure setFish(valeur : integer);
  //cette fonction renvoie la valeur de la variable laine
  function getLaine() : integer;
  //cette procedure modifie la valeur de la variable laine
  procedure setLaine(valeur : integer);
  //cette fonction renvoie la valeur de la variable tool
  function getTool() : integer;
  //cette procedure modifie la valeur de la variable tool
  procedure setTool(valeur : integer);
  //renvoie la variable tissu
  function getTissu() : integer;
  //modifie la variable tissu
  procedure setTissu(valeur : integer);

  function GetRessourcesValue(item:Integer):integer;

  function GetRessourcesTxt(item:Integer):String;

  function GetRessourcesTxtValue(item:Integer):String;

  function GetTotalItemRessources():Integer;

  // modifie une ressource passée en paramètre / utile pour la construction de batiment
  procedure setRessource(item: Integer; valeur: Integer);

  //fonction qui retourne le prix d'un item
  function getPriceRessource(nomRessource: enumRessources):Integer;

  //procedure qui affiche toutes les ressources gagnées durant le tour
  procedure printAllRessQuantityGagne(posX,posYPremierItem,espacement:Integer);

  //procédure qui initialise toutes les quantités des ressources au début d'un tour
  procedure quantityAllRessTPrec();



implementation
  //Ces variables sont connues de toute l'unité mais pas à l'extérieur
  const
    totalItemsRess= 6;

    texteGold = 'Pieces Or :';
    texteBois = 'Bois :';
    texteFish = 'Poisson :';
    texteLaine ='Laine :';
    texteTissu ='Tissu :';
    texteTool = 'Outils :';

  type
    menuRess = array[1..totalItemsRess] of String;

    //déclaration type qui sert à contenir les coordonnées du placement des txt des ressources
   tabCoordXItemRessources= array[1..totalItemsRess] of Integer;
   tabCoordYItemRessources = array[1..totalItemsRess] of Integer;


  var
     typeRessouce: array[gold..tool] of ressources;

  //Cette fonction initialise les variables (au début de la partie par exemple)
  procedure initRessource();
    begin
       typeRessouce[gold].nom:='gold';
       typeRessouce[wood].nom:='wood';
       typeRessouce[fish].nom:='fish';
       typeRessouce[laine].nom:='laine';
       typeRessouce[tissu].nom:='tissu';
       typeRessouce[tool].nom:='tool';

       typeRessouce[gold].quantite:=4000;
       typeRessouce[wood].quantite:=100;
       typeRessouce[fish].quantite:=200;
       typeRessouce[laine].quantite:=100;
       typeRessouce[tissu].quantite:=0;
       typeRessouce[tool].quantite:=0;

       typeRessouce[gold].prixVente:=5;
       typeRessouce[wood].prixVente:=10;
       typeRessouce[fish].prixVente:=5;
       typeRessouce[laine].prixVente:=5;
       typeRessouce[tissu].prixVente:=5;
       typeRessouce[tool].prixVente:=5;
    end;

  procedure ecrireTexte(nom:String; x:Integer; y:Integer);
    var
      posTexte: coordonnees; //variable, coordonnées de placement du texte nom en paramètre
    begin
      posTexte.x:=x; //initialisation placement en x passé en paramètre
      posTexte.y:=y; //initialisation placement en y du nom passé en paramètre
      ecrireEnPosition(posTexte,nom); //fonction de l'unité Gestion Ecran qui affiche le nom à la position posNomMenu
    end;

  function GetRessourcesValue(item:Integer):integer;
  var
     TabTemp: Array[1..totalItemsRess] of Integer;
  begin
    TabTemp[1]:= getGold;
    TabTemp[2]:= getWood;
    TabTemp[3]:= getFish;
    TabTemp[4]:= getLaine;
    TabTemp[5]:= getTissu;
    TabTemp[6]:= getTool;

    GetRessourcesValue:=TabTemp[item];
  end;

  function GetRessourcesTxt(item:Integer):String;
    var
       TabTemp: menuRess;
    begin
      TabTemp[1]:= texteGold;
      TabTemp[2]:= texteBois;
      TabTemp[3]:= texteFish;
      TabTemp[4]:= texteLaine;
      TabTemp[5]:= texteTissu;
      TabTemp[6]:= texteTool;
      GetRessourcesTxt:=TabTemp[item];
    end;

  function GetRessourcesTxtValue(item:Integer):String;
    var
       TabTemp: menuRess;
    begin
      TabTemp[1]:= (texteGold+(IntToStr(getGold)));
      TabTemp[2]:= (texteBois+(IntToStr(getWood)));
      TabTemp[3]:= (texteFish+(IntToStr(getFish)));
      TabTemp[4]:= (texteLaine+(IntToStr(getLaine)));
      TabTemp[5]:= (texteTissu+(IntToStr(getTissu)));
      TabTemp[6]:= (texteTool+(IntToStr(getTool)));
      GetRessourcesTxtValue:=TabTemp[item];
    end;

  function GetTotalItemRessources():Integer;
    begin
      GetTotalItemRessources := totalItemsRess;
    end;

  function getPriceRessource(nomRessource: enumRessources):Integer;
    begin
      getPriceRessource:=typeRessouce[nomRessource].prixVente;
    end;

  //Cette fonction renvoie la valeur de la variable Gold
  function getGold() : Integer;
    begin
         getGold:=typeRessouce[gold].quantite;
    end;

  //Cette procedure modifie la valeur de la variable Or
  procedure setGold(valeur : integer);
    begin
         typeRessouce[gold].quantite := typeRessouce[gold].quantite+valeur ;
    end;

  //Cette fonction renvoie la valeur de la variable Bois
  function getWood() : Integer;
    begin
         getWood:=typeRessouce[wood].quantite;
    end;

  //Cette procedure modifie la valeur de la variable bois
  procedure setWood(valeur : integer);
    begin
         typeRessouce[wood].quantite := typeRessouce[wood].quantite+valeur ;
    end;

  //renvoie la variable fish
  function getFish() : integer;
    begin
         getFish:=typeRessouce[fish].quantite;
    end;

  //modifie la variable fish
  procedure setFish(valeur : integer);
    begin
         typeRessouce[fish].quantite := typeRessouce[fish].quantite+valeur ;
    end;

  //renvoie variable laine
  function getLaine() : integer;
    begin
         getLaine:=typeRessouce[laine].quantite;
    end;

  //modifie variable laine
  procedure setLaine(valeur : integer);
    begin
         typeRessouce[laine].quantite := typeRessouce[laine].quantite+valeur ;
    end;

  //renvooie variable tissu
  function getTissu() : integer;
    begin
         getTissu:=typeRessouce[tissu].quantite;
    end;

  //modifie varable tissu
  procedure setTissu(valeur : integer);
  begin
       typeRessouce[tissu].quantite := typeRessouce[tissu].quantite+valeur ;
  end;

  //renvoie varaible tool
  function getTool() : integer;
    begin
         //getTool := tool;
         getTool := typeRessouce[tool].quantite;
    end;

  //modifie variable tool
  procedure setTool(valeur : integer);
    begin
         typeRessouce[tool].quantite := typeRessouce[tool].quantite+valeur ;
    end;

  //procédure qui initialise la quantité d'un type de ressource au début d'un tour(sert à calculer les ressources gagnées lors du tour de jeu)
  procedure quantityTPrecedent(nom:enumRessources);
    begin
       typeRessouce[nom].quantiteTPrecedent:=typeRessouce[nom].quantite; //init quantiteTPrecedent du type de ressource passée en paramètre
    end;

  //procédure qui initialise toutes les quantités des ressources au début d'un tour
  procedure quantityAllRessTPrec();
    var
       ressource: enumRessources; //variable de type enumRessources compteur
    begin
       for ressource:=gold to tool do
          begin
            typeRessouce[ressource].quantiteTPrecedent:=typeRessouce[ressource].quantite; //init quantiteTPrecedent de chaque type de ressource
          end;
    end;

  //fonction qui retourne la quantité de ressource gagné lors du tour
  function quantityRessWinTour(nom:enumRessources):Integer;
    begin
       quantityRessWinTour:=typeRessouce[nom].quantite-typeRessouce[nom].quantiteTPrecedent; //calcul de la quantité gagné en ressource
    end;

  //procedure qui affiche toutes les ressources gagnées durant le tour à une position du 1er item y et un espacement entre chaque item
  procedure printAllRessQuantityGagne(posX,posYPremierItem,espacement:Integer);
    var
       ressource: enumRessources; //variable de type enumRessources;
       txtAfficheRess: String;
    begin
       for ressource:=gold to tool do
          begin
            txtAfficheRess:= 'Quantité de '+ typeRessouce[ressource].nom+' gagné ou perdues :'+IntToStr(quantityRessWinTour(ressource));  //concaténation de plusieurs str le text description avec la quantité gagné de chaque item
            ecrireTexte(txtAfficheRess,posX,posYPremierItem); //ecrit le txt description avec la quantité de ress gagné
            posYPremierItem:=posYPremierItem+espacement; //incrément de la posY de l'item suivant
          end;
    end;

  // modifie une ressource passée en paramètre / utile pour la construction de batiment
  procedure setRessource(item: Integer; valeur: Integer);
    var
       coef: Integer; // sert à multiplier valeur par moins 1 plus proprement
    begin
         coef:= -1;
         case item of
         1: setGold(coef*valeur);
         2: setWood(coef*valeur);
         3: setFish(coef*valeur);
         4: setLaine(coef*valeur);
         5: setTissu(coef*valeur);
         6: setTool(coef*valeur);
         end;
    end;


  end.
