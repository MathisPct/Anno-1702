{codepage utf8}
{Programme qui appelle toutes les fonctions/procédure du jeu}
program jeu;
{L'unité menuNouvellePartie sert à appeler toutes les composantes du menu de création de partie}
{L'unité initialisationEcran sert à appeler toutes les composantes qui permettent
d'initialiser l'écran (taille, couleur etc...)}
uses Keyboard ,menuNouvellePartie, initialisationEcran, menuInterface, evenementClavier,GestionEcran ;

//glossaire
var
  toucheClavier:TKeyEvent;//variable de type tkey event qui est l'évènement du clavier

  boucleJeu:Boolean; //variable de type boolean, qui est la boucle du jeu
  menuAccueil:Boolean; //variable de type boolean qui est la boucle du menuAccueil
  menuCreaPartie:Boolean; //variable de type boolean, qui est la boucle de menu de création de partie

  nbTourBoucle: integer; //variable de type integer, qui est le nb de tour dans une boucle
  touche:TKeyEvent;

begin
  //initialisation de l'écran (taille,couleur...)
  initEcran();
  //initialisation de la variable jeu à true, au départ on démarre le jeu
  boucleJeu:=True;
  while (boucleJeu=True) //tant qu'on est dans le jeu
    begin
    nbTourBoucle;=0;//initialisation du nb de tour de boucle
    while (menuAccueil=True) do
      begin
        touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
        touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
        if (nbTourBoucle=0) then
           writeln('menuAccueil'); //appel du menuAccueil
        nbTourBoucle:=nbTourBoucle+1;
      end;
    while (menuCreaPartie=True) do
      begin
        if (nbTourBoucle=0) then
           writeln('menuCreaPartie');  //appel du menu de creation de partie
        nbTourBoucle:=nbTourBoucle+1;
      end;
    mainMenuInterface(); //appel du menuInterface
    boucleJeu:=False;//fin du jeu, on quitte la boucle du jeu
    end;
    writeln('fin du jeu'); //On quitte la partie
  readln()
end.

