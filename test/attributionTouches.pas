program attributionTouches;
uses Keyboard ;

var
  toucheClavier: TKeyEvent; //variable de type TKeyEvent qui va stocker la valeur de la touche pressée par l'user
  fin: String; //Variable de type chaine de caractère, entrée au clavier par l'user
  stopBoucle: Boolean; //variable boolean , boucle



begin
     InitKeyboard;//initialisation du module Keyboard
     stopBoucle:=False; //initialisation de stopBoucle
     while (stopBoucle<>True) do
           begin
             toucheClavier:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui reçoit les évènements du clavier
             toucheClavier:= TranslateKeyEvent(toucheClavier); //retourne la valeur ascii de la touche si elle est pressée . Variable de type int
             WriteLn(toucheClavier); //Affichage de la valeur ascii de la touche
             if (toucheClavier=33619745) then
                WriteLn('Haut')
             else if (toucheClavier=33619751) then
                  WriteLn('Bas')
             else if (toucheClavier=33619749) then
                  WriteLn('Droite')
             else if (toucheClavier=33619747) then
                  WriteLn('Gauche')
             else if (toucheClavier=283) then
                 writeln('Echap');
           end;
     WriteLn('Fin boucle');
     DoneKeyboard; //désinitialisation du module Keyboard
     readln;
end.

