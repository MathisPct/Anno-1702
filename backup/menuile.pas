{$codepage utf8}
unit menuIle ;

{$mode objfpc}{$H+}

interface

uses
  Classes , SysUtils, GestionEcran, Keyboard ;

  //procédure qui affiche le menu intro
  procedure mainMenuIle();

implementation

  procedure description();
    const
      txtX = 50;
      txtY = 15;
    begin
      deplacerCurseurXY(txtX+35,txtY);
      write('Arrivée sur l''île Esolenne');
      deplacerCurseurXY(txtX,txtY+2);
      write('Cette île est un véritable paradis sur Terre, elle présente des paysages surprenants et');
      deplacerCurseurXY(txtX,txtY+3);
      write('la poésie virevoltante de sa faune aérienne lui confère un charme tout particulier.');
      deplacerCurseurXY(txtX,txtY+4);
      write('La configuration de ses côtes est propice à une pêche facile où le poisson semble inépuisable.');
      deplacerCurseurXY(txtX,txtY+6);
      write('La Flore y prospère partout même sur les massifs escarpés qui surplombent fièrement l''océan pacifique.');
      deplacerCurseurXY(txtX,txtY+7);
      write('De plus, ces roches offrent généreusement leur minerai précieux, utile pour forger d''indispensables outils.');
      deplacerCurseurXY(txtX,txtY+9);
      write('Cette île fera surement le bonheur de nombreux Européens en quête de nouveaux mondes, ');
      deplacerCurseurXY(txtX,txtY+10);
      write('elle regorge de ruisseaux à l''eau pure et de tapis gonflés d''argile. Elle dessine ');
      deplacerCurseurXY(txtX,txtY+11);
      write('de verdoyantes prairies sauvages où pourra paitre le mouton, pousser le blé et la canne à sucre.');
      deplacerCurseurXY(txtX,txtY+13);
      write('Méfiez-vous toutefois des terribles ouragans de cette région ainsi que des pirates');
      deplacerCurseurXY(txtX,txtY+14);
      write('pilleurs de navires marchands au large! Soyez toujours près à ces éventualités,');
      deplacerCurseurXY(txtX,txtY+15);
      write('pour le bien de votre communauté...');
      deplacerCurseurXY(txtX+35,txtY+18);
      write('A vous de jouer!');
    end;

  //procédure qui affiche le menu intro
  procedure mainMenuIle();
    begin
      effacerEcran;
      DoneKeyboard;
      description();
      readln; //attente d'un event user
      InitKeyboard;
    end;

end.

