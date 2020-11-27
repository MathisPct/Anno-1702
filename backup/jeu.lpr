{codepage utf8}
{Programme qui appelle toutes les fonctions/procédure du jeu}
program jeu;
{L'unité menuNouvellePartie sert à appeler toutes les composantes du menu de création de partie}
{L'unité initialisationEcran sert à appeler toutes les composantes qui permettent
d'initialiser l'écran (taille, couleur etc...)}
uses Keyboard, menuNouvellePartie, initialisationEcran, menuInterface,
  evenementClavier, GestionEcran, menuAccueil, bouclesJeux ;

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
  boucleJeu:=True;
  while (boucleJeu=True) do //tant qu'on est dans le jeu
    begin
    initiaNbTourBoucle(); //initialisation du nb de tour de boucle
    menuInterfaAccueil:=True; //initialisation de la boucle du menuAccueil à true (quand on arrive sur le jeu)
    mainMenuAccueil(); //appel de la procédure qui lance le menuAccueil
    menuCreaPartie;
    while (menuCreaPartie=True) do
      begin
        if (getNbTourBoucle=0) then
           begin
           effacerEcran; //raffraichissement de l'écran car on est passé sur un autre menu
           writeln('menuCreaPartie');  //appel du menu de creation de partie
           end;
        touche:= GetKeyEvent; //GetKeyEvent est une fonction de l'unité Keyboard qui renvoit les évènements du clavier
        touche:= TranslateKeyEvent(touche); //retourne la valeur unicode de la touche si elle est pressée . Variable de type int
        if (touche=7181) then  //on sort du menu si la touche 'Entree' est pressée
           menuCreaPartie:=False;  //boucle à False donc on passe à l'autre boucle
        incrementaNbTourBoucle(); //incrémentation de nb tour boucle
      end;
    mainMenuInterface(); //appel du menuInterface
    boucleJeu:=False;//fin du jeu, on quitte la boucle du jeu
    end;
    writeln('fin du jeu'); //On quitte la partie
  readln()
end.

