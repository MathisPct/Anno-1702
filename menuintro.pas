{$codepage utf8}
unit menuIntro ;

{$mode objfpc}{$H+}

interface

uses
  Classes , SysUtils, GestionEcran, Keyboard ;

  //procédure qui affiche le menu intro
  procedure mainMenuIntro();

implementation
  //procédure qui affiche une illustration d'un bateau
  procedure bateau();
    begin
      deplacerCurseurXY(2,2);
      write('                                       ###        ##');
      deplacerCurseurXY(2,3);
      write('                                       #################');
      deplacerCurseurXY(2,4);
      write('                                       ################');
      deplacerCurseurXY(2,5);
      write('                                       ############');
      deplacerCurseurXY(2,6);
      write('                                       #########');
      deplacerCurseurXY(2,7);
      write('                                        ###');
      deplacerCurseurXY(2,8);
      write('                                        ###');
      deplacerCurseurXY(2,9);
      write('                              ######################           ########');
      deplacerCurseurXY(2,10);
      write('                              #######################          #############');
      deplacerCurseurXY(2,11);
      write('               #######         ########################        ############');
      deplacerCurseurXY(2,12);
      write('               ############     #######################        ####');
      deplacerCurseurXY(2,13);
      write('               ###########       #######################      ######');
      deplacerCurseurXY(2,14);
      write('               #####             #######################      #######');
      deplacerCurseurXY(2,15);
      write('            #########            ########################       #######');
      deplacerCurseurXY(2,16);
      write('           ###########           ########################       #########');
      deplacerCurseurXY(2,17);
      write('           ###########           #######################        ##########');
      deplacerCurseurXY(2,18);
      write('           ##########            #######################        ###########');
      deplacerCurseurXY(2,19);
      write('            #########           #######################         ###########');
      deplacerCurseurXY(2,20);
      write('            #########         ##########################        ###########');
      deplacerCurseurXY(2,21);
      write('               ###            ###########################      ############');
      deplacerCurseurXY(2,22);
      write('          ###  ####            ############################    ############');
      deplacerCurseurXY(2,23);
      write('          #########             ############################ ################');
      deplacerCurseurXY(2,24);
      write('           ##########           ############################ #################');
      deplacerCurseurXY(2,25);
      write('              ###########        ############################  #################');
      deplacerCurseurXY(2,26);
      write('               #############     ############################  #################');
      deplacerCurseurXY(2,27);
      write('              ################## ############################   #################');
      deplacerCurseurXY(2,28);
      write('             #################################################  ##################');
      deplacerCurseurXY(2,29);
      write('            ##################################################   #################');
      deplacerCurseurXY(2,30);
      write('           #############        #############################    #################');
      deplacerCurseurXY(2,31);
      write('          #################       ###########################    #################');
      deplacerCurseurXY(2,32);
      write('         ######################  ############################    #################              ####');
      deplacerCurseurXY(2,33);
      write('         ####################### ###########################     #################        ##########');
      deplacerCurseurXY(2,34);
      write('        #####################################################   ################     #############');
      deplacerCurseurXY(2,35);
      write('        #################################################      ###############################');
      deplacerCurseurXY(2,36);
      write('         ###############################   ####            ##############################');
      deplacerCurseurXY(2,37);
      write('          ###############################  ####           ###########################');
      deplacerCurseurXY(2,38);
      write('          #####################################         #########################');
      deplacerCurseurXY(2,39);
      write('           ###################################################################');
      deplacerCurseurXY(2,40);
      write('           ###################################################################');
      deplacerCurseurXY(2,41);
      write('            #################################################################');
      deplacerCurseurXY(2,42);
      write('                ############################################################');
      deplacerCurseurXY(2,43);
      write('                ###########################################################');
      deplacerCurseurXY(2,44);
      write('                 #########################################################');
      deplacerCurseurXY(2,45);
      write('                  ######################################################');
      deplacerCurseurXY(2,46);
      write('                   ###################################################');
      deplacerCurseurXY(2,47);
      write('                     ###############################################');
      deplacerCurseurXY(2,48);
      write('                       ###########################################');
      deplacerCurseurXY(2,49);
      write('                          ####################################');
      deplacerCurseurXY(2,50);
      write('                               ##########################');
    end;

  //procédure qui affiche la description du jeu
  procedure description();
    begin
      deplacerCurseurXY(110,15);
      write('Bienvenu sur Anno 1702 !');
      deplacerCurseurXY(110,17);
      write('Prenez le large et découvrez de nouvelles terres. ');
      deplacerCurseurXY(110,18);
      write('Armez-vous de vos meilleurs hommes et de vos meilleurs équipements.');
      deplacerCurseurXY(110,19);
      write('Partez à l''aventure vers le soleil couchant jusqu''à l''épuisement. ');
      deplacerCurseurXY(110,20);
      write('Une île pleine de surprise vous attend ! Ce sera parfois dur,');
      deplacerCurseurXY(110,21);
      write('mais n''abandonnez pas car la récompense à la clef vous rendra pur.');
      deplacerCurseurXY(110,22);
      write('A la manière d''un vrai pirate vous répondrez avec foi aux');
      deplacerCurseurXY(110,23);
      write('exigences de votre peuplade. Répandez le bonheur autour de vous,');
      deplacerCurseurXY(110,24);
      write('et faites y flotter les couleurs de votre royaume!');
      deplacerCurseurXY(110,28);
      write('Parez à mouiller, à virer ! Il est temps d''accoster !');
    end;

  //procédure qui affiche le menu intro
  procedure mainMenuIntro();
    begin
      effacerEcran;
      DoneKeyboard;
      bateau();
      description();
      readln; //attente d'un event user
      InitKeyboard;
    end;

end.

