unit evenementClavier;

{$mode objfpc}{$H+}

interface

//appel des unités
uses
  Keyboard; //module Keyboard qui permet de récupérer les évènements du clavier

  //partie visibles pour les programmes qui appelle l'unité

  {fonction qui retourne entree, echap, haut, bas , si elle est pressée}
  function toucheClavier():String;

implementation
  //déclaration des variables connues de toute l'unité
  var
    touche: TKeyEvent; //variable de type TKeyEvent qui va stocker la valeur de la touche pressée par l'user

  {fonction qui retourne entree, echap, haut, bas , si elle est pressée}
  function toucheClavier():String;
    begin
      InitKeyboard;//initialisation du mondule
      touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
      touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
      if (touche=33619745) then
         toucheClavier:='haut' //retounement de la valeur 'haut' par la fonction
      else if (touche=33619751) then
         toucheClavier:='bas' //retounement de la valeur 'bas' par la fonction
      else if (touche=283) then
          toucheClavier:='echap' //retounement de la valeur 'echap' par la fonction
      else if (touche=7181) then
          toucheClavier:='entree' //retounement de la valeur 'entree' par la fonction
      else
          toucheClavier:=''; //sinon pas d'autres touches
    end;

end.

