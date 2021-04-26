{codepage utf8}
{Programme principale qui appelle tous les menus
(menu accueil, menu de création de partie, menu d’introduction, menu interface)
tant que le jeu est lancé.}
program jeu;
uses Keyboard , menuNouvellePartie , menuInterface ,
  GestionEcran , menuAccueil , bouclesJeux ,menuCreationPartie ,
  sMenuGestionBatiments , unitRessources , unitBuilding ,
  sysutils , population , sMenuMarchand , eventImpromptus , menuIntro, menuile;

//glossaire
var
  toucheClavier:TKeyEvent;//variable de type tkey event qui est l'évènement du clavier

  boucleJeu:Boolean; //variable de type boolean, qui est la boucle du jeu
  menuInterfaAccueil:Boolean; //variable de type boolean qui est la boucle du menuAccueil
  menuCreaPartie:Boolean; //variable de type boolean, qui est la boucle de menu de création de partie

  touche:TKeyEvent;

begin
  //initialisation de l'écran
  changerTailleConsole(200,60);
  // initialisation du module keyboard
  InitKeyboard;
  // initialisation du module random
  randomize;
  //Initialisation système jeu
  initRessourceDiffNormal(); //init ressources (difficulté de base = normal )
  initEImpromDiffNormal(); //init event impromptus (difficulté de base = normal)
  initBuilding(); //init du système de batiments  (difficulté de base = normal )
  initCaractPop(); //init système de population
  initTauxAppaMarchand(8); //initialisation taux apparition marchand (difficulté de base = normal )
  initBoucleJeu(); //initialisation de boucleJeu à true
  initEtatEventImpr(); {initialise etatEvent à false: au début pas d'event}
  while (getBoucleJeu()=True) do //tant qu'on est dans le jeu
    begin
      mainMenuAccueil(); //appel de la procédure qui lance le menuAccueil
      mainMenuCreaPartie(); //appel de la procédure qui lance le menu de création de partie
      mainMenuIntro(); //appel de la procédure de l'unit menuIntro qui affiche le menu intro
      mainMenuIle(); //appel de la procédure de l'unit menuIle qui affiche une description de l'ile
      mainMenuInterface(); //appel de la procédure de l'unit menuInterface qui lance l'interface de l'ile
    end;
  //fin du jeu
end.

