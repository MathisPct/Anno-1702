{codepage utf8}
{Programme qui appelle toutes les fonctions/procédure du jeu}
program jeu;
{L'unité menuNouvellePartie sert à appeler toutes les composantes du menu de création de partie}
{L'unité initialisationEcran sert à appeler toutes les composantes qui permettent
d'initialiser l'écran (taille, couleur etc...)}
uses Keyboard, menuNouvellePartie, initialisationEcran, menuInterface,
  evenementClavier, GestionEcran, menuAccueil, bouclesJeux, menuCreationPartie;

//glossaire
var
  toucheClavier:TKeyEvent;//variable de type tkey event qui est l'évènement du clavier

  boucleJeu:Boolean; //variable de type boolean, qui est la boucle du jeu
  menuInterfaAccueil:Boolean; //variable de type boolean qui est la boucle du menuAccueil
  menuCreaPartie:Boolean; //variable de type boolean, qui est la boucle de menu de création de partie

  touche:TKeyEvent;

begin
  //initialisation de l'écran (taille,couleur...)
  initEcran();
  // initialisation du module keyboard
  InitKeyboard;//initialisation du module
  //initialisation de la variable jeu à true, au départ on démarre le jeu
  //boucleJeu:=True;
  initBoucleJeu(); //initialisation de boucleJeu à true
  while (getBoucleJeu()=True) do //tant qu'on est dans le jeu
    begin
    mainMenuAccueil(); //appel de la procédure qui lance le menuAccueil
    getBoucleJeu();
    mainMenuCreaPartie(); //appel de la procédure qui lance le menu de création de partie
    setBoucleJeu(False);//fin du jeu, on quitte la boucle du jeu
    end;
    writeln('Fin du jeu'); //Affichage du message de fin du jeu
end.

