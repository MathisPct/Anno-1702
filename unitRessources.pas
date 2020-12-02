unit unitRessources;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils;
//Cette fonction initialise les variables (au début de la partie par exemple)
procedure initialisationRess();
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

function GetRessources(item:Integer):String;

function GetTotalItemRessources():Integer;



implementation
//Ces variables sont connues de toute l'unité mais pas à l'extérieur
const
  totalItemsRess=6;
  texteGold = 'Pieces Or         : ';
  texteBois = 'Quantite Bois     : ';
  texteFish = 'Quantite poisson  : ';
  texteLaine ='Quantite laine    : ';
  texteTissu ='Quantite tissu    : ';
  texteTool = 'Quantite outils   : ';

type
  menuRess = array[1..totalItemsRess] of String;

var
   gold : integer;
   wood : integer;
   fish : integer;
   laine : integer;
   tissu : integer;
   tool : integer;
   //TabRessource: Array[1..2] of string;

//Cette fonction initialise les variables (au début de la partie par exemple)
procedure initialisationRess();
begin

     gold := 4000;
     wood := 100;
     fish := 200;
     laine := 0;
     tissu := 0;
     tool := 0;
end;

function GetRessources(item:Integer):String;
var
   TabTemp: menuRess;
begin
  TabTemp[1]:= (texteGold+(IntToStr(getGold)));
  TabTemp[2]:= (texteBois+(IntToStr(getWood)));
  TabTemp[3]:= (texteFish+(IntToStr(getFish)));
  TabTemp[4]:= (texteLaine+(IntToStr(getLaine)));
  TabTemp[5]:= (texteTissu+(IntToStr(getTissu)));
  TabTemp[6]:= (texteTool+(IntToStr(getTool)));
  GetRessources:=TabTemp[item];
end;

function GetTotalItemRessources():Integer;
begin
  GetTotalItemRessources := totalItemsRess;
end;

//Cette fonction renvoie la valeur de la variable Gold
function getGold() : Integer;
begin
     getGold := gold;
end;

//Cette procedure modifie la valeur de la variable Or
procedure setGold(valeur : integer);
begin
     gold := gold+valeur;
end;

//Cette fonction renvoie la valeur de la variable Bois
function getWood() : Integer;
begin
     getWood := wood;
end;

//Cette procedure modifie la valeur de la variable bois
procedure setWood(valeur : integer);
begin
     wood := wood+valeur;
end;

//renvoie la variable fish
function getFish() : integer;
begin
     getFish := fish;
end;

//modifie la variable fish
procedure setFish(valeur : integer);
begin
     fish := fish+valeur;
end;

//renvoie variable laine
function getLaine() : integer;
begin
     getLaine := laine;
end;

//modifie variable laine
procedure setLaine(valeur : integer);
begin
     laine := laine+valeur;
end;

//renvooie variable tissu
function getTissu() : integer;
begin
     getTissu := tissu;
end;

//modifie varable tissu
procedure setTissu(valeur : integer);
begin
     tissu := tissu+valeur;
end;

//renvoie varaible tool
function getTool() : integer;
begin
     getTool := tool
end;

//modifie variable tool
procedure setTool(valeur : integer);
begin
     tool := tool+valeur;
end;

end.
