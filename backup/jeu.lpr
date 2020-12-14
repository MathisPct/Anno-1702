{codepage utf8}
{Programme qui appelle toutes les fonctions/procédure du jeu}
program jeu;
{L'unité menuNouvellePartie sert à appeler toutes les composantes du menu de création de partie}
{L'unité initialisationEcran sert à appeler toutes les composantes qui permettent
d'initialiser l'écran (taille, couleur etc...)}
uses Keyboard , menuNouvellePartie , initialisationEcran , menuInterface ,
  evenementClavier , GestionEcran , menuAccueil , bouclesJeux ,
  menuCreationPartie , sMenuGestionBatiments , unitRessources , unitBuilding ,
  sysutils , population , sMenuMarchand , eventImpromptus;

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
  // initialisation du module random
  randomize;
  //Initialisation système jeu
  initRessourceDiffNormal(); //init ressources (difficulté de base = normal )
  initEImpromDiffNormal(); //init event impromptus (difficulté de base = normal)
  initBuilding(); //init du système de batiments  (difficulté de base = normal )
  initCaractPop(); //init système de population
  initTauxAppaMarchand(5); //initialisation taux apparition marchand (difficulté de base = normal )
  initBoucleJeu(); //initialisation de boucleJeu à true
  initEtatEventImpr(); {initialise etatEvent à false: au début pas d'event}
  writeln(getBat_Cost_Txt(1));
  writeln(getBat_Cost_Item_Value(1,3));
  readln;
  while (getBoucleJeu()=True) do //tant qu'on est dans le jeu
    begin
      mainMenuAccueil(); //appel de la procédure qui lance le menuAccueil
      mainMenuCreaPartie(); //appel de la procédure qui lance le menu de création de partie
      mainMenuInterface(); //appel du menuInterface
    end;
end.

