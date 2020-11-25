{codepage utf8}
{Programme qui appelle toutes les fonctions/procédure du jeu}
program jeu;
{L'unité menuNouvellePartie sert à appeler toutes les composantes du menu de création de partie}
{L'unité initialisationEcran sert à appeler toutes les composantes qui permettent
d'initialiser l'écran (taille, couleur etc...)}
uses Keyboard ,menuNouvellePartie, initialisationEcran, menuInterface, evenementClavier;

//glossaire
var
  toucheClavier:TKeyEvent;//variable de type tkey event qui est l'évènement du clavier
  boucleJeu:Boolean; //variable de type boolean, qui est la boucle du jeu

begin
  //initialisation de l'écran (taille,couleur...)
  initEcran();
  //initialisation de la variable jeu à true, au départ on démarre le jeu
  boucleJeu:=True;
  //appel de la procédure qui affiche tous les éléments du menuNouvellePartie
  //affichageMenuCreaPartie();
  mainMenuInterface();
end.

