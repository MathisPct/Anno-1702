{$codepage utf8}
{Contient tout ce qui concerne le lancement des événements impromptus
(piraterie, covid noir, ouragan) avec une logique qui permet de faire durer
les évènements sur plusieurs tours.
}
unit eventImpromptus ;

{$mode objfpc}{$H+}

interface

  uses
    Classes , SysUtils , GestionEcran , bouclesJeux, Keyboard , population, math,UnitBuilding;

  {procédure qui initialise etatEvent à false: au début pas d'event}
  procedure initEtatEventImpr();

  {procédure setEventImpromptu}
  procedure setEventImpromptu();

  {procedure qui initialise les event en difficulté normale}
  procedure initEImpromDiffNormal();

  {procedure qui initialise les event en difficulté hard}
  procedure initEImpromDiffHard();

  {fonction qui retourne true si l'event piraterie est lancé et false s'il n'est pas lancé}
  function getEtatPiraterie():Boolean;

  {procédure qui permet de modifier la valeur de la population tant que l'event covid est actif avec un coef de morta}
  procedure epidemieCovid();        //coefMorta: Real

  {procedure event ouragan qui lance la destruction de batiment tant que l'event ouragan est actif (1 seul tour)}
  procedure eventOuragan();

  //Procédure qui affiche le message piraterie si l'event est actif}
  procedure setMessageEvent();


implementation
  const
    nbTotalEventImpromptu=3;

  type
    eventImprompt= (pirate,pesteNoir,ouragan);

    evenementsImpromptus =record
      nom: String;
      probNbTour: Integer; //proba de durée du tour de l'event
      txtScenarioPara1: String; //paragraphe1 txtScenario
      txtScenarioPara2: String; //paragraphe2 txtScenario
      txtScenarioPara3: String; //paragraphe3 txtScenario
      tourDebEvent: Integer; //tour quand commence un event
      tourFinEvent: Integer;  //tour auquel l'event va prendre fin
      nbTourNotEvent: Integer; //nb de tour avant que l'event soit redéclancher
    end;

  var
    tabEventImpromptu: array[pirate..ouragan] of evenementsImpromptus;
    probaMaxEventImpromptu: Integer; //proba max qu'un évènement impromptu survienne
    etatEvent: Boolean; //variable boolean qui est initialisé à false et passe à true si un event est actif
    tourReEvent: Integer; //tour avant que les events soit redéclancher
    seuilPopStartCovid: Integer; //variable integer qui est le nombre à partir duquel l'event covidnoir peut se lancer
    txtNbBatDestroyOuragan : String; // texte qui permet d'afficher combien de batiment ont été détruit par l'ouragan

  {procédure qui initialise la proba à une valeur qu'un event impromptu survienne}
  procedure initProbMaxEventImprompt(valeur: Integer);
    begin
      probaMaxEventImpromptu:=valeur;
    end;

  {procédure qui initialise tourReInitEvent}
  procedure initTourReEvent();
    begin
      tourReEvent:=-1;
    end;

  {procédure qui permet de déclarer à quel tour les event pourront être redéclencher}
  procedure setTourReEvent(tourMinimum,valeurProbaMax: Integer);
    begin
      tourReEvent:= getNbTour() + valeurProbaMax//+ 10 + random(valeurProbaMax); //tour actuel + 10 à valeurProbaMax qu'un event resurvienne
    end;

  {fonction qui renvoie la valeur de tourReEvent}
  function getTourReEvent():Integer;
    begin
      getTourReEvent:=tourReEvent;
    end;

  {procedure qui permet d'initialiser le seuil de population à partir duquelle l'event covid noire peut être lancé}
  procedure seuilStartEpidemie(valeur:Integer);
    begin
      seuilPopStartCovid:=valeur;
    end;

  {procédure qui initialise les textes des évènements impromptus}
  procedure initEImpromptyTxt();
    begin
      tabEventImpromptu[pirate].nom:='pirate';
      tabEventImpromptu[pesteNoir].nom:='peste noir';
      tabEventImpromptu[ouragan].nom:='ouragan';
    end;

  {procedure qui initialie les events impromptus : commun à toutes les difficultés }
  procedure initEImprompGeneral();
    begin
      initEImpromptyTxt(); //init txt
      initTourReEvent(); {procédure qui initialise tourReInitEvent}
      tabEventImpromptu[pirate].nbTourNotEvent:=-1;  //init du numéro de tour où l'event pourra être réactivé
      tabEventImpromptu[ouragan].nbTourNotEvent:=-1; //init du numéro de tour où l'event pourra être réactivé
      tabEventImpromptu[pirate].tourDebEvent:=-1;  //init not event tour
      tabEventImpromptu[pesteNoir].tourDebEvent:=-1;  //init not event tour
      tabEventImpromptu[ouragan].tourDebEvent:=-1;  //init not event tour
      tabEventImpromptu[pirate].tourFinEvent:= -1; //initialisation tour fin event
      tabEventImpromptu[pesteNoir].tourFinEvent:= -1; //initialisation tour fin event
      tabEventImpromptu[ouragan].tourFinEvent:= -1; //initialisation tour fin event
      seuilStartEpidemie(10);
    end;

  {procedure qui initialise les event en difficulté normale}
  procedure initEImpromDiffNormal();
    begin
      initEImprompGeneral(); {procedure qui initialie les events impromptus : commun à toutes les difficultés }
      initProbMaxEventImprompt(6); //initialisation apparition d'un event impromptu
      tabEventImpromptu[pirate].tourFinEvent:= -1; //initialisation tour fin event
      tabEventImpromptu[pirate].probNbTour:=5; //l'event peu durer entre 1 à 5 tours
      tabEventImpromptu[pesteNoir].probNbTour:=3; //l'event peu durer entre 1 à 5 tours
      tabEventImpromptu[ouragan].probNbTour:=1; //l'event peu durer entre 1 à 5 tours
    end;

  {procedure qui initialise les event en difficulté hard}
  procedure initEImpromDiffHard();
    begin
      initEImprompGeneral(); {procedure qui initialie les events impromptus : commun à toutes les difficultés }
      initProbMaxEventImprompt(6); //initialisation apparition d'un event impromptu
      tabEventImpromptu[pirate].tourFinEvent:= -1; //initialisation tour fin event
      tabEventImpromptu[pirate].probNbTour:=8; //l'event peu durer entre 1 à 8 tours
      tabEventImpromptu[pesteNoir].probNbTour:=5; //l'event peu durer entre 1 à 5 tours
      tabEventImpromptu[ouragan].probNbTour:=1; //l'event peu durer entre 1 à 5 tours
    end;

  {procédure qui initialise etatEvent à false: au début pas d'event}
  procedure initEtatEventImpr();
    begin
      etatEvent:=False;
    end;

  {fonction qui renvoie si un event est actif et false si il est pas actif }
  function getEtatEvent():Boolean;
    begin
      getEtatEvent:=etatEvent;
    end;

  {fonction qui retourne true si l'event piraterie est lancé et false s'il n'est pas lancé}
  function getEtatPiraterie():Boolean;
    begin
      if (getNbTour()<=tabEventImpromptu[pirate].tourFinEvent) then
        begin
          getEtatPiraterie:=True;
        end
      else
        begin
         getEtatPiraterie:=False;
        end;
    end;

  {procédure qui permet de modifier la valeur de la population tant que l'event covid est actif (avec un coef de morta)}
  procedure epidemieCovid(); //coefMorta: Real
    var
      nbMort: Integer;
      coefMort: Real;
      tabCoefMort:array [1..6] of Real= (0.05,0.08,0.1,0.2,0.25,0.3);
    begin
      //si l'event est lancé
      if (getNbTour()<=tabEventImpromptu[pesteNoir].tourFinEvent) then
        begin
           if ((getNbHabCatePop(1)>5) and (getNbHabCatePop(1)<=10)) then
             begin
              nbMort := Round(0.05*getNbHabCatePop(1));
             end;
           if ((getNbHabCatePop(1)>10) and (getNbHabCatePop(1)<20)) then
             begin
              coefMort:= tabCoefMort[RandomRange(1,5)];
              nbMort:= Round(coefMort*getNbHabCatePop(1));
             end;
           if ((getNbHabCatePop(1)>=20)) then
             begin
              coefMort:= tabCoefMort[RandomRange(2,7)];
              nbMort:= Round(coefMort*getNbHabCatePop(1));
             end;
           setNbMortCatego(1,nbMort); //procédure qui modifie le nb d'une catégorie de pop
        end;
    end;

  {procedure event ouragan qui lance la destruction de batiment tant que l'event ouragan est actif (1 seul tour)}
  procedure eventOuragan();
    begin
      if (getNbTour()<=tabEventImpromptu[ouragan].tourFinEvent) then
         txtNbBatDestroyOuragan := ouraganBatDestroy()
      else
         txtNbBatDestroyOuragan := '';
    end;

  {Procédure qui affiche le message de l'evenement si il existe}
  procedure printMessageEvent(texteEvent:String);
    var
      txtDescription: String;
    begin
      //si un évènement est présent
      if texteEvent<>'' then
        begin
          txtDescription:= 'Evénement ' + texteEvent + ' en cours!';
          ecrireTexte(txtDescription,10,5);
        end;
    end;

  {Procédure qui affiche le message piraterie si l'event est actif}
  procedure setMessageEvent();
    begin
      if (getNbTour()<=tabEventImpromptu[pirate].tourFinEvent) then //si le tour est inférieur à la fin du tour de l'event on affiche le msg
        printMessageEvent(tabEventImpromptu[pirate].nom) //affiche le message d'évènement
      else if (getNbTour()<=tabEventImpromptu[ouragan].tourFinEvent) then
        ecrireTexte(txtNbBatDestroyOuragan,10,5)
      else if (getNbTour()<=tabEventImpromptu[pesteNoir].tourFinEvent) then
        printMessageEvent(tabEventImpromptu[pesteNoir].nom);
    end;

  {procedure qui affiche le txt scénarisé de l'event piraterie s'il vient d'être activé}
  procedure printTxtScenarioPirates();
    var
      text: String;
      paragraphe: String;
    begin
      //si l'event vient d'être lancé
      if (tabEventImpromptu[pirate].tourDebEvent=getNbTour() ) then
        begin
             effacerEcran(); //efface ecran pour affiche txt scenario
             paragraphe:='La piraterie n''est jamais fini !'#13#10'(Camarades), vos marchands se font attaqués par des pirates sans pitié...'#13#10'Vous êtes désormais dans l''incapacité de faire appel à eux mais soyez patient ils finiront bien par revenir...';
             ecrireTexte(paragraphe,5,5);
             ecrireTexte(text,5,10);
        end;
    end;

  //procédure qui affiche le txt scénarisé de l'event ouragan s'il vient d'être activé
  procedure printTxtScenarioOuragan();
    var
      text: String;
      paragraphe: String;
    begin
      //si l'event vient d'être lancé
      if (tabEventImpromptu[ouragan].tourDebEvent=getNbTour() ) then
        begin
             effacerEcran(); //mise à jour affichage
             paragraphe:='Ouragan dévastateur !'#13#10'Prenez garde ! Un terrible ouragan a frappé votre ville ! Vos bâtiments sont en périls...';
             ecrireTexte(paragraphe,5,10);
        end;
    end;

  procedure printTxtScenarioCovidNoir();
    var
      paragraphe: String;
    begin
      //si l'event vient d'être lancé
      if (tabEventImpromptu[pesteNoir].tourDebEvent=getNbTour() ) then
         begin
              effacerEcran(); //mise à jour affichage
              paragraphe:= 'Un affreux virus a fait son apparition sur l''île, il s''agit du puissant Corona noir !'#13#10'Malheureusement de nombreux colons et habitants se sont fait contaminés...' ;
              ecrireTexte(paragraphe,5,10);
         end;
    end;

  {procédure setEventImpromptu}
  procedure setEventImpromptu();
    var
      nbAleatoire:integer;
    begin
      randomize;
      //si le nombre de tour qu'a fait le joueur est >=10 et le nb aleatoire entre 1 et probaMaxEventImpromptu=1 et que les events sont activés alors faire un choix entre les 3 event
      if ((random(probaMaxEventImpromptu)=1) and (getNbTour()>=10) and (getNbTour()>getTourReEvent()) ) then
        begin
             randomize;
             nbAleatoire:=RandomRange(1,4); //random entre 1 à 3
             case (nbAleatoire) of
                   1:
                     begin
                         //writeln('pirate');
                         //attendre(1000);
                         setTourReEvent(10,10); //les events seronts redéclancher dans 10 à 20 tours
                         tabEventImpromptu[pirate].tourDebEvent:=getNbTour();  //init de début du tour quand commence l'event
                         tabEventImpromptu[pirate].tourFinEvent:= getNbTour()+5+random(tabEventImpromptu[pirate].probNbTour); //init durée tour event entre 5 à 5+probNbTour
                         tabEventImpromptu[pirate].nbTourNotEvent:= getTourReEvent()+10; //init pas d'event pirate pendant 10 tours après la fin de getTournotevent
                         writeln(' L''event pourra être réactivé au tour ',IntToStr(getTourReEvent()));
                         DoneKeyboard; //pas d'event clavier
                         printTxtScenarioPirates();
                         readln; //attente event user
                         InitKeyboard;//retour event clavier}
                     end;
                   2:
                     begin
                         //writeln('ouragan');
                         //attendre(1000);
                         setTourReEvent(10,10); //les events seronts redéclancher dans 10 à 20 tours
                         tabEventImpromptu[ouragan].nbTourNotEvent:=getTourReEvent()+10; //init pas d'event pirate pendant 10 tours après la fin de getTournotevent
                         tabEventImpromptu[ouragan].tourDebEvent:=getNbTour();  //init de début du tour quand commence l'event
                         tabEventImpromptu[ouragan].tourFinEvent:= getNbTour(); //l'event dure 1 tour
                         writeln('Events réactivés dans: ',getTourReEvent()) ;
                         DoneKeyboard;
                         printTxtScenarioOuragan();
                         readln; //attente event user
                         InitKeyboard; //retour event clavier
                     end;

                   3:
                      begin
                        //si assez d'hab pour que l'epidemie se developpe
                        if (getNbTotalPop>seuilPopStartCovid) then
                          begin
                            //writeln('covid noire');
                            //attendre(1000);
                            setTourReEvent(10,10); //les events seronts redéclancher dans 10 à 20 tours
                            tabEventImpromptu[pesteNoir].nbTourNotEvent:=getTourReEvent()+10;//init pas d'event peste noire pendant 10 tours après la fin de getTournotevent
                            tabEventImpromptu[pesteNoir].tourDebEvent:=getNbTour();  //init de début du tour quand commence l'event
                            tabEventImpromptu[pesteNoir].tourFinEvent:= getNbTour()+1+random(2); //l'event peut durer de 1 à 3 tours
                            writeln('Events réactivés dans: ',getTourReEvent()) ;
                            DoneKeyboard; //pas d'event clavier
                            printTxtScenarioCovidNoir(); //affichage texte scénario
                            readln(); //attente event user
                            InitKeyboard;
                          end;
                     end;
             end;
        end;
    end;

end.

