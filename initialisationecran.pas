unit initialisationEcran;

{$mode objfpc}{$H+}  {$codepage utf8}

interface
//appel des unités
uses GestionEcran;

{procédure qui initialise les paramètre de l'écran de jeu}
procedure initEcran();

//Glossaire
//déclaration des constantes
const
  largeur=200; //largeur de la fenêtre de jeu
  hauteur=60; //hauteur de la fenêtre de jeu

implementation
  {procédure qui initialise les paramètre de l'écran de jeu}
  procedure initEcran();
    begin
    changerTailleConsole(largeur,hauteur);
    end;

end.

