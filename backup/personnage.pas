unit personnage;

{$mode objfpc}{$H+}

interface

  uses
    Classes, SysUtils, GestionEcran;

  type perso = record
    nom:String;
  end;

  //Fonction créant un nouveau personnage dont le nom est donné en paramètre
  function nouveauPerso(sonNom : String) : perso;

  //fonction qui demande le nom du joueur
  function demandeNom():String;

  //fonction qui retourne le nom du joueur
  function getNomJoueur ():String;

  //procédure qui affiche le nom du joueur en position X et Y
  procedure afficheNomJoueur(posX,posY:Integer);

implementation
  var
    joueur: perso; //variable de type perso

  //Fonction créant un nouveau personnage dont le nom est donné en paramètre
  function nouveauPerso(sonNom : String) : perso;
    begin
      joueur.nom := sonNom; //nom du personnage = sonNom passé en paramètre
    end;

  //fonction qui demande le nom du joueur
  function demandeNom():String;
    var
      nom:String;
    begin
      readln(nom);
      demandeNom:=nom;
    end;

  //fonction qui retourne le nom du joueur
  function getNomJoueur():String;
    begin
      getNomJoueur:=joueur.nom;
    end;

  //procédure qui affiche le nom du joueur en position X et Y
  procedure afficheNomJoueur(posX,posY:Integer);
  var
      pos: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
      posTxtNom: coordonnees; //variable, coordonnées de placement du texte "Nom: "
  begin
    pos.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
    pos.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
    posTxtNom.x:= posX-5;
    posTxtNom.y:= posY;
    ecrireEnPosition(posTxtNom,'Nom: ');
    ecrireEnPosition(pos,joueur.nom); //fonction de l'unité Gestion Ecran qui affiche le nom du joueur à la position pos
  end;

  end.

