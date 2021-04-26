{$codepage utf8}
unit personnage;

{$mode objfpc}{$H+}

interface

  uses
    Classes, SysUtils, GestionEcran, bouclesJeux;

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
      posTxtNom: coordonnees; //variable, coordonnées de placement du texte "Nom: "
      txtDescriNom: String;  //mot précédent le nom du joueur
    begin
      txtDescriNom:='Le Chef:';
      ecrireTexte(txtDescriNom,posX,posY); //ecris texte en posX et Y
      ecrireTexte(joueur.nom,posX+Length(txtDescriNom)+1,posY); //fonction de l'unité Gestion Ecran qui affiche le nom du joueur à la position pos
    end;

end.

