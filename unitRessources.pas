{$codepage utf8}
unit unitRessources;

{$mode objfpc}{$H+}

interface
  uses
    Classes, SysUtils , GestionEcran ,bouclesJeux;

  type
   ressources=record
     nom:String;
     quantite: Integer;
     prixVente: Integer; //prix de vente et d'achat en or d'une ressource
     quantiteTPrecedent:Integer; //quantité de ressources du tour précédent
   end;

   enumRessources=(gold,wood,fish,laine,tissu,tool,ble,pain,canne,rhum, argile, brique, minerai, metal); //énumération des différentes ressources

  //Cette procédure initialise les variables (au début de la partie)
  procedure initRessourceDiffFacile();

  //Cette procédure initialise les quantités et les prix de vente des ress en difficulté normal
  procedure initRessourceDiffNormal();

  //Cette procédure initialise les quantités et les prix de vente des ress en difficulté hard
  procedure initRessourceDiffHard();

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
  //renvoie variable blé
  function getBle() : integer;
  //modifie variable blé
  procedure setBle(valeur : integer);
  //renvoie variable pain
  function getPain() : integer;
  //modifie variable pain
  procedure setPain(valeur : integer);
  //renvoie variable canne
  function getCanne() : integer;
  //modifie variable canne
  procedure setCanne(valeur : integer);
  //renvoie variable rhum
  function getRhum() : integer;
  //modifie variable rhum
  procedure setRhum(valeur : integer);
  //renvoie variable argile
  function getArgile() : integer;
  //modifie variable argile
  procedure setArgile(valeur : integer);
  //renvoie variable brique
  function getBrique() : integer;
  //modifie variable brique
  procedure setBrique(valeur : integer);
  //renvoie variable minerai
  function getMinerai() : integer;
  //modifie variable minerai
  procedure setMinerai(valeur : integer);
  //renvoie variable metal
  function getMetal() : integer;
  //modifie variable metal
  procedure setMetal(valeur : integer);

  //procedure qui remplace la quantité des ressources
  procedure replaceRessourcesValue(numRessource:Integer;valeur:Integer);

  function GetRessourcesValue(item:Integer):integer;

  function GetRessourcesTxt(item:Integer):String;

  function GetRessourcesTxtValue(item:Integer):String;

  function GetTotalItemRessources():Integer;

  // modifie une ressource passée en paramètre / utile pour la construction de batiment
  procedure setRessource(numRessource: Integer; valeur: Integer);

  //procedure qui reset les valeurs des ressources à la capacité des entrepots si elle les dépasse
  procedure resetRessourcesEntrepots(capaciteEntrepot: Integer);

  //fonction qui retourne le prix d'un item
  function getPriceRessource(numRessource: Integer):Integer;

  //procedure qui affiche toutes les ressources gagnées durant le tour
  procedure printAllRessQuantityGagne(posX,posYPremierItem,espacement:Integer);

  //procédure qui initialise toutes les quantités des ressources au début d'un tour
  procedure quantityAllRessTPrec();



implementation
  //Ces variables sont connues de toute l'unité mais pas à l'extérieur
  const
    totalItemsRess= 14;

    texteGold    = 'Pieces d''Or';
    texteBois    = 'Bois';
    texteFish    = 'Poisson';
    texteLaine   = 'Laine';
    texteTissu   = 'Tissu';
    texteTool    = 'Outils';
    texteble     = 'Blé';
    textePain    = 'Pain';
    texteCanne   = 'Sucre de Canne';
    texteRhum    = 'Rhum';
    texteArgile  = 'Argile';
    texteBrique  = 'Briques';
    texteMinerai = 'Minerai';
    texteMetal   = 'Metal';


  type
    menuRess = array[1..totalItemsRess] of String;

    //déclaration type qui sert à contenir les coordonnées du placement des txt des ressources
   tabCoordXItemRessources= array[1..totalItemsRess] of Integer;
   tabCoordYItemRessources = array[1..totalItemsRess] of Integer;


  var
     typeRessouce: array[1..totalItemsRess] of ressources;

  //Cette procédure initialise tous les noms des ressources
  procedure initRessourceTxt();
    begin
       typeRessouce[1].nom:=texteGold;
       typeRessouce[2].nom:=texteBois;
       typeRessouce[3].nom:=texteFish;
       typeRessouce[4].nom:=texteLaine;
       typeRessouce[5].nom:=texteTissu;
       typeRessouce[6].nom:=texteTool;
       typeRessouce[7].nom:=texteble;
       typeRessouce[8].nom:=textePain;
       typeRessouce[9].nom:=texteCanne;
       typeRessouce[10].nom:=texteRhum;
       typeRessouce[11].nom:=texteArgile;
       typeRessouce[12].nom:=texteBrique;
       typeRessouce[13].nom:=texteMinerai;
       typeRessouce[14].nom:=texteMetal;

    end;

  //Cette procédure initialise les variables (au début de la partie)
  procedure initRessourceDiffFacile();
    begin
       initRessourceTxt();//Cette procédure initialise tous les noms des ressources

       typeRessouce[1].quantite:=10000;
       typeRessouce[2].quantite:=150;
       typeRessouce[3].quantite:=150;
       typeRessouce[4].quantite:=150;
       typeRessouce[5].quantite:=0;
       typeRessouce[6].quantite:=0;

       typeRessouce[1].prixVente:=10;
       typeRessouce[2].prixVente:=10;
       typeRessouce[3].prixVente:=10;
       typeRessouce[4].prixVente:=10;
       typeRessouce[5].prixVente:=10;
       typeRessouce[6].prixVente:=10;
    end;

  //Cette procédure initialise les quantités et les prix de vente des ress en difficulté normal
  procedure initRessourceDiffNormal();
    begin
       initRessourceTxt();//Cette procédure initialise tous les noms des ressources
       typeRessouce[1].quantite:=5000;
       typeRessouce[2].quantite:=100;
       typeRessouce[3].quantite:=100;
       typeRessouce[4].quantite:=0;
       typeRessouce[5].quantite:=0;
       typeRessouce[6].quantite:=0;

       typeRessouce[1].prixVente:=5;
       typeRessouce[2].prixVente:=5;
       typeRessouce[3].prixVente:=5;
       typeRessouce[4].prixVente:=5;
       typeRessouce[5].prixVente:=5;
       typeRessouce[6].prixVente:=5;
    end;

    //Cette procédure initialise les quantités et les prix de vente des ress en difficulté hard
  procedure initRessourceDiffHard();
    begin
       initRessourceTxt();//Cette procédure initialise tous les noms des ressources

       typeRessouce[1].quantite:=2000;
       typeRessouce[2].quantite:=50;
       typeRessouce[3].quantite:=50;
       typeRessouce[4].quantite:=0;
       typeRessouce[5].quantite:=0;
       typeRessouce[6].quantite:=0;

       typeRessouce[1].prixVente:=3;
       typeRessouce[2].prixVente:=3;
       typeRessouce[3].prixVente:=3;
       typeRessouce[4].prixVente:=3;
       typeRessouce[5].prixVente:=3;
       typeRessouce[6].prixVente:=3;
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
    TabTemp[7]:= getBle;
    TabTemp[8]:= getPain;
    TabTemp[9]:= getCanne;
    TabTemp[10]:= getRhum;
    TabTemp[11]:= getArgile;
    TabTemp[12]:= getBrique;
    TabTemp[13]:= getMinerai;
    TabTemp[14]:= getMetal;
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
      TabTemp[7]:= texteBle;
      TabTemp[8]:= textePain;
      TabTemp[9]:= texteCanne;
      TabTemp[10]:= texteRhum;
      TabTemp[11]:= texteArgile;
      TabTemp[12]:= texteBrique;
      TabTemp[13]:= texteMinerai;
      TabTemp[14]:= texteMetal;

      GetRessourcesTxt:=TabTemp[item];
    end;

  function GetRessourcesTxtValue(item:Integer):String;
  var
     TabTemp: menuRess;
     longueurIndent: Integer;
     separation: String; // charactère qui sépare les textes de ressources et leur valeur
  begin
    longueurIndent:= 18;
    separation:= ': ';
    TabTemp[1]:= (txtIndentation(texteGold,longueurIndent)+separation+(IntToStr(getGold)));
    TabTemp[2]:= (txtIndentation(texteBois,longueurIndent)+separation+(IntToStr(getWood)));
    TabTemp[3]:= (txtIndentation(texteFish,longueurIndent)+separation+(IntToStr(getFish)));
    TabTemp[4]:= (txtIndentation(texteLaine,longueurIndent)+separation+(IntToStr(getLaine)));
    TabTemp[5]:= (txtIndentation(texteTissu,longueurIndent)+separation+(IntToStr(getTissu)));
    TabTemp[6]:= (txtIndentation(texteTool,longueurIndent)+separation+(IntToStr(getTool)));
    TabTemp[7]:= (txtIndentation(texteBle,longueurIndent)+separation+(IntToStr(getBle)));
    TabTemp[8]:= (txtIndentation(textePain,longueurIndent)+separation+(IntToStr(getPain)));
    TabTemp[9]:= (txtIndentation(texteCanne,longueurIndent)+separation+(IntToStr(getCanne)));
    TabTemp[10]:= (txtIndentation(texteRhum,longueurIndent)+separation+(IntToStr(getRhum)));
    TabTemp[11]:= (txtIndentation(texteArgile,longueurIndent)+separation+(IntToStr(getArgile)));
    TabTemp[12]:= (txtIndentation(texteBrique,longueurIndent)+separation+(IntToStr(getBrique)));
    TabTemp[13]:= (txtIndentation(texteMinerai,longueurIndent)+separation+(IntToStr(getMinerai)));
    TabTemp[14]:= (txtIndentation(texteMetal,longueurIndent)+separation+(IntToStr(getMetal)));

    GetRessourcesTxtValue:=TabTemp[item];
  end;

  function GetTotalItemRessources():Integer;
    begin
       GetTotalItemRessources := totalItemsRess;
    end;

  function getPriceRessource(numRessource: Integer):Integer;
    begin
       getPriceRessource:=typeRessouce[numRessource].prixVente;
    end;

  //Cette fonction renvoie la valeur de la variable Gold
  function getGold() : Integer;
    begin
       getGold:=typeRessouce[1].quantite;
    end;

  //Cette procedure modifie la valeur de la variable Or
  procedure setGold(valeur : integer);
    begin
       typeRessouce[1].quantite := typeRessouce[1].quantite+valeur ;
    end;

  //Cette fonction renvoie la valeur de la variable Bois
  function getWood() : Integer;
    begin
       getWood:=typeRessouce[2].quantite;
    end;

  //Cette procedure modifie la valeur de la variable bois
  procedure setWood(valeur : integer);
    begin
       typeRessouce[2].quantite := typeRessouce[2].quantite+valeur ;
    end;

  //renvoie la variable fish
  function getFish() : integer;
    begin
       getFish:=typeRessouce[3].quantite;
    end;

  //modifie la variable fish
  procedure setFish(valeur : integer);
    begin
       typeRessouce[3].quantite := typeRessouce[3].quantite+valeur ;
    end;

  //renvoie variable laine
  function getLaine() : integer;
    begin
       getLaine:=typeRessouce[4].quantite;
    end;

  //modifie variable laine
  procedure setLaine(valeur : integer);
    begin
       typeRessouce[4].quantite := typeRessouce[4].quantite+valeur ;
    end;

  //renvooie variable tissu
  function getTissu() : integer;
    begin
       getTissu:=typeRessouce[5].quantite;
    end;

  //modifie varable tissu
  procedure setTissu(valeur : integer);
  begin
       typeRessouce[5].quantite := typeRessouce[5].quantite+valeur ;
  end;

  //renvoie varaible tool
  function getTool() : integer;
    begin
       getTool := typeRessouce[6].quantite;
    end;

  //modifie variable tool
  procedure setTool(valeur : integer);
    begin
       typeRessouce[6].quantite := typeRessouce[6].quantite+valeur ;
    end;

  //renvoie variable blé
  function getBle() : integer;
    begin
       getBle := typeRessouce[7].quantite;
    end;

  //modifie variable blé
  procedure setBle(valeur : integer);
    begin
       typeRessouce[7].quantite := typeRessouce[7].quantite+valeur ;
    end;

  //renvoie variable pain
  function getPain() : integer;
    begin
       getPain := typeRessouce[8].quantite;
    end;

  //modifie variable pain
  procedure setPain(valeur : integer);
    begin
       typeRessouce[8].quantite := typeRessouce[8].quantite+valeur ;
    end;

  //renvoie variable canne
  function getCanne() : integer;
    begin
       getCanne := typeRessouce[9].quantite;
    end;

  //modifie variable canne
  procedure setCanne(valeur : integer);
    begin
       typeRessouce[9].quantite := typeRessouce[9].quantite+valeur ;
    end;

  //renvoie variable rhum
  function getRhum() : integer;
    begin
       getRhum := typeRessouce[10].quantite;
    end;

  //modifie variable rhum
  procedure setRhum(valeur : integer);
    begin
       typeRessouce[10].quantite := typeRessouce[10].quantite+valeur ;
    end;

  //renvoie variable argile
  function getArgile() : integer;
    begin
       getArgile := typeRessouce[11].quantite;
    end;

  //modifie variable argile
  procedure setArgile(valeur : integer);
    begin
       typeRessouce[11].quantite := typeRessouce[11].quantite+valeur ;
    end;

    //renvoie variable brique
  function getBrique() : integer;
    begin
       getBrique := typeRessouce[12].quantite;
    end;

  //modifie variable brique
  procedure setBrique(valeur : integer);
    begin
       typeRessouce[12].quantite := typeRessouce[12].quantite+valeur ;
    end;

  //renvoie variable minerai
  function getMinerai() : integer;
    begin
      getMinerai := typeRessouce[13].quantite;
    end;

  //modifie variable minerai
  procedure setMinerai(valeur : integer);
    begin
      typeRessouce[13].quantite := typeRessouce[13].quantite+valeur ;
    end;

  //renvoie variable metal
  function getMetal(): integer;
    begin
       getMetal := typeRessouce[14].quantite;
    end;

  //modifie variable metal
  procedure setMetal(valeur : integer);
    begin
       typeRessouce[14].quantite := typeRessouce[14].quantite+valeur ;
    end;

  //procédure qui initialise la quantité d'un type de ressource au début d'un tour(sert à calculer les ressources gagnées lors du tour de jeu)
  procedure quantityTPrecedent(numRessource:Integer);
    begin
       typeRessouce[numRessource].quantiteTPrecedent:=typeRessouce[numRessource].quantite; //init quantiteTPrecedent du type de ressource passée en paramètre
    end;

  //procedure qui remplace la quantité des ressources
  procedure replaceRessourcesValue(numRessource:Integer;valeur:Integer);
    begin
      typeRessouce[numRessource].quantite:=valeur;
    end;

  //procedure qui reset les valeurs des ressources à la capacité des entrepots si elle les dépasse et à 0 si les ressources sont négatives
  procedure resetRessourcesEntrepots(capaciteEntrepot: Integer);
    var
       numRessource: Integer; //variable de type Int compteur boucle
    begin
       for numRessource:=2 to totalItemsRess do
          if (GetRessourcesValue(numRessource)>capaciteEntrepot) then
             replaceRessourcesValue(numRessource,capaciteEntrepot);
    end;

  //procédure qui initialise toutes les quantités des ressources au début d'un tour
  procedure quantityAllRessTPrec();
    var
       ressource: Integer; //variable de type enumRessources compteur
    begin
       //initialisation de la quantité au tour precedent de toutes les ressources
       for ressource:=1 to totalItemsRess do
          begin
            typeRessouce[ressource].quantiteTPrecedent:=typeRessouce[ressource].quantite; //init quantiteTPrecedent de chaque type de ressource
          end;
    end;

  //fonction qui retourne la quantité de ressource gagné lors du tour
  function quantityRessWinTour(numRessource:Integer):Integer;
    begin
       quantityRessWinTour:=typeRessouce[numRessource].quantite-typeRessouce[numRessource].quantiteTPrecedent; //calcul de la quantité gagné en ressource
    end;

  //procedure qui affiche toutes les ressources gagnées durant le tour à une position du 1er item y et un espacement entre chaque item
  procedure printAllRessQuantityGagne(posX,posYPremierItem,espacement:Integer);
    var
       ressource: Integer; //variable de type enumRessources;
       txtAfficheRess: String;
    begin
       for ressource:=1 to totalItemsRess do
          begin
            txtAfficheRess:= txtIndentation('Quantité de '+ typeRessouce[ressource].nom+' gagné ou perdues',45)+': '+IntToStr(quantityRessWinTour(ressource));  //concaténation de plusieurs str le text description avec la quantité gagné de chaque item
            ecrireTexte(txtAfficheRess,posX,posYPremierItem); //ecrit le txt description avec la quantité de ress gagné
            posYPremierItem:=posYPremierItem+espacement; //incrément de la posY de l'item suivant
          end;
    end;

  // modifie une ressource passée en paramètre / utile pour la construction de batiment
  procedure setRessource(numRessource: Integer; valeur: Integer);
    var
       coef: Integer; // sert à multiplier valeur par moins 1 plus proprement
    begin
         coef:= -1;
         case numRessource of
         1: setGold(coef*valeur);
         2: setWood(coef*valeur);
         3: setFish(coef*valeur);
         4: setLaine(coef*valeur);
         5: setTissu(coef*valeur);
         6: setTool(coef*valeur);
         7: setBle(coef*valeur);
         8: setPain(coef*valeur);
         9: setCanne(coef*valeur);
         10: setRhum(coef*valeur);
         11: setArgile(coef*valeur);
         12: setBrique(coef*valeur);
         13: setMinerai(coef*valeur);
         14: setMetal(coef*valeur);
         end;
    end;

  end.

