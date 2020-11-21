{$codepage utf8}
{$mode objfpc}{$H+}
program appelMenuV3;

uses menuV3,SysUtils, Windows,GestionEcran,Keyboard;

var
  toucheClavier: TKeyEvent;

begin
  while True do
    begin
      afficherMenu();
      elementMenuActuelPixel();
      colorierElementActuel();
      toucheClavier:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui reçoit les évènements du clavier
      toucheClavier:= TranslateKeyEvent(toucheClavier); //retourne la valeur ascii de la touche si elle est pressée . Variable de type int
      navigationTabMenu(toucheClavier);
      effacerEcran;   //permet de mettre à jour l'élément séléctionné
    end;

  readln;
end.

