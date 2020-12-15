unit UnitBuilding;

{$mode objfpc}{$H+}

interface

  uses
    unitRessources, Classes, SysUtils, GestionEcran, bouclesJeux;

  // initialise les batiment en début de partie
  procedure initBuilding();

  //procédure product de ressources suivant le nb de batiment qu'on a et suivant les coefs de prod de ressources de chaque batiment
  procedure productionIndustrieTour();

  //procedure qui affiche les msg d'erreurs des production de chaine contenu dans le tableau msgErreursProdChaine
  procedure afficheMessageProdChaine(posX,pos1eY,espacement: Integer);

  // retourne la quantité ou la capacité selon prop d'un batiment passé en paramètre
  function getBat_Prop(numBat:Integer; prop: String): Integer;

  //retourne la valeur de cout de construction pour un item ressource donné pour la construction d'un batiment
  function getBat_Cost_Item_Value(numBat,numRessource:Integer): Integer;

  // retourne un string concatené composé de toutes les ressources nécéssaires à l'achat du batiment passé en paramètre
  function getBat_Cost_Txt(numBat:Integer): String;

  // retourne la valeur de production d'un item ressource produit ou utilisé par un batiment
  function getBat_Prod_Item_Value(numBat,numRessource: Integer): Integer;

  // retourne l'utilisation ou la production de ressources d'un batiment ou de tout les batiments selon les paramètres entrés
  function get_Bat_Prod_Txt(numBat:Integer; production: String; total: String): String;

  // permet de modifier la quantité du batiment passé en paramètre
  procedure SetBat_Quantity(numBat,valeur: Integer);

  {fonction qui renvoie le nb de maisons au début du tour}
  function getMaisonGagne():Integer;

  {fonction qui renvoie le nb de villa au début du tour}
  function getVIllaGagne(): Integer;

  {procedure qui récupère la quantité de logement de chaque catégorie de pop en début de tour}
  procedure setLogementDebTour();

  //procedure de construction d'un batiment passé en paramètre
  function Build_Batiment(numBat:Integer;etatBesoinsColons:Boolean):String;

  procedure affichageBatiment(numBat:Integer; propriety: String; posX,posY:Integer);

  //procédure initialise les batiments en difficulté NORMAL
  procedure initBuildingDiffFacile();

  //procédure initialise les batiments en difficulté HARD
  procedure initBuildingDiffHard();

  // fonction qui détruit des batiments quand l'ouragan se produit et qui retourne un string correspondant au nombre de batiment detruits
  function ouraganBatDestroy():String;


  type Building = record
    sorte        : String;
    nom          : String;
    quantity     : Integer; // nombre de batiment de ce type
    capacity     : Integer; // nombre occupant contenu par le batiment
    construct    : Array[1..6] of Integer;
    production   : Array[1..6] of Integer;

  end;

implementation
  type
    enumRessources=(gold,wood,fish,laine,tissu,tool); //énumération des différentes ressources
  const
    totalBatiment = 8; //nombre total de batiment

    // sorte HABITAT
    B_Maison      = 1; //maison des colons
    B_Villa       =8; //maison des citoyens

    // sorte INDUSTRIE
    B_Fisher      = 2;
    B_Bucheron    = 3;
    B_Bergerie    = 4;
    B_Tisserand   = 5;

    // sorte SOCIAL
    B_Chapelle    = 6;
    B_CentreVille = 7;

    nbMsg = 3;

  var
     batiment : array[1..totalBatiment] of Building; //permet de créer des variations du record building et ainsi de décrire tout les batiments du jeu
     nbMaisonDebTour: Integer; //variable int, pour calculer le nb de maisons gagné durant le tour
     nbVillaDebTour: Integer; //variable int, pour calculer le nb de villas gagné en début de tour

     msgErreursProdChaine: Array[1..nbMsg] of String;

  // initialise les batiment en début de partie
  procedure initBuilding();
    begin
    /////////////////////////////////////// H-A-B-I-T-A-T/////////////////////////////////////////
       //------------------------------------------------------------------------- M A I S O N
       batiment[B_Maison].sorte           := 'HABITAT';
       batiment[B_Maison].nom             := 'Maison de Colon';
       batiment[B_Maison].quantity        := 4;
       batiment[B_Maison].capacity        := 4;
       //Cout de construction
       batiment[B_Maison].construct[1]    := 5; // cout GOLD
       batiment[B_Maison].construct[2]    := 5; // cout BOIS

      batiment[B_Villa].sorte  := 'HABITAT';
      batiment[B_Villa].nom    := 'Villa de citoyen';
      batiment[B_Villa].quantity  := 1;
      batiment[B_Villa].capacity  := 5;
      //cout de construction
      batiment[B_Villa].construct[1] := 50; //cout gold
      batiment[B_Villa].construct[2] := 50; //cout bois


  /////////////////////////////////////// S-O-C-I-A-L /////////////////////////////////////////

       //------------------------------------------------------------------------- C H A P E L L E
       batiment[B_Chapelle].sorte           := 'SOCIAL';
       batiment[B_Chapelle].nom             := 'Chapelle';
       batiment[B_Chapelle].quantity        := 0;
       batiment[B_Chapelle].capacity        := 0;
       //Cout de construction
       batiment[B_Chapelle].construct[1]    := 1000; // cout GOLD
       batiment[B_Chapelle].construct[2]    := 100; // cout BOIS
       batiment[B_Chapelle].construct[3]    := 0; // cout Poisson
       batiment[B_Chapelle].construct[4]    := 0; // cout Laine
       batiment[B_Chapelle].construct[5]    := 5; // cout Tissu
       batiment[B_Chapelle].construct[6]    := 0; // cout Outils

       //------------------------------------------------------------------------- Centre-Ville
       batiment[B_CentreVille].sorte           := 'SOCIAL';
       batiment[B_CentreVille].nom             := 'Centre-Ville';
       batiment[B_CentreVille].quantity        := 0;
       batiment[B_CentreVille].capacity        := 0;
       //Cout de construction
       batiment[B_CentreVille].construct[1]    := 500; // cout GOLD
       batiment[B_CentreVille].construct[2]    := 100; // cout BOIS

  ///////////////////////////////////////I-N-D-U-S-T-R-I-E////////////////////////////////////////////

       //-------------------------------------------------------- C A B A N E   D E   P E C H E U R
       batiment[B_Fisher].sorte           := 'INDUSTRIE';
       batiment[B_Fisher].nom             := 'Cabane de Pecheur';
       batiment[B_Fisher].quantity        := 0;
       batiment[B_Fisher].capacity        := 0;
       // COUT DE CONSTRUCTION [update l'unité ressources seulement à l'achat]
       batiment[B_Fisher].construct[1]    := 15;  // coute Gold
       batiment[B_Fisher].construct[2]    := 3;   // coute Wood

       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Fisher].production[3]   := 1;   // Fish

       //----------------------------------------------------------C A B A N E   D E   B U C H E R O N ----------------------------------
       batiment[B_Bucheron].sorte           := 'INDUSTRIE';
       batiment[B_Bucheron].nom             := 'Cabane de Bucheron';
       batiment[B_Bucheron].quantity        := 0;
       batiment[B_Bucheron].capacity        := 3;
       // COUT DE CONSTRUCTION [update l'unité ressources seulement à l'achat]
       batiment[B_Bucheron].construct[1]    := 25;  // coute Gold
       batiment[B_Bucheron].construct[2]    := 5;   // coute Wood
       batiment[B_Bucheron].construct[2]    := 7;   // coute Fish

       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Bucheron].production[2]   := 3;   // production de wood

       //---------------------------------------------------------- B E R G E R I E ----------------------------------
       batiment[B_Bergerie].sorte           := 'INDUSTRIE';
       batiment[B_Bergerie].nom             := 'Bergerie';
       batiment[B_Bergerie].quantity        := 0;
       batiment[B_Bergerie].capacity        := 1;
       //Cout de construction
       batiment[B_Bergerie].construct[1]    := 25;  // coute Gold
       batiment[B_Bergerie].construct[2]    := 10;  // coute Wood

       // production de ressources
       batiment[B_Bergerie].production[4]   := 5;   // production de Laine
       //---------------------------------------------------------- T I S S E R A N D ----------------------------------
       batiment[B_Tisserand].sorte           := 'INDUSTRIE';
       batiment[B_Tisserand].nom             := 'Atelier de Tisserand';
       batiment[B_Tisserand].quantity        := 1;
       batiment[B_Tisserand].capacity        := 1;
       //Cout de construction
       batiment[B_Tisserand].construct[1]    := 35;  // coute Gold
       batiment[B_Tisserand].construct[2]    := 10;  // coute Wood
       batiment[B_Tisserand].construct[4]    := 10;  // coute Laine

       // production de ressources
       batiment[B_Tisserand].production[4]   := -1; // nécéssite de la Laine pour produire
       batiment[B_Tisserand].production[5]   := 3;   // produit du Tissu
  end;

  //procédure initialise les batiments en difficulté normal
  procedure initBuildingDiffFacile();
    begin
      batiment[B_Maison].quantity := 2; //2maisons de base
      batiment[B_Maison].capacity := 4;
    end;

  //procédure initialise les batiments en difficulté normal
  procedure initBuildingDiffHard();
    begin
      batiment[B_Maison].quantity := 0;
      batiment[B_Maison].capacity := 2; //capacité limité= prog plus lente de la pop
      batiment[B_Maison].production[5] := -5;   // -5 de Tissu en moins par maison
    end;

  //procédure product de ressources suivant le nb de batiment qu'on a et suivant les coefs de prod de ressources de chaque batiment
  procedure productionIndustrieTour();
    begin
       setFish(batiment[B_Fisher].quantity     * batiment[B_Fisher].production[3]); //prod de poissons par la cabane de pêcheur
       setWood(batiment[B_Bucheron].quantity   * batiment[B_Bucheron].production[2]); //prod de bois par la cabane de bucherons
       setLaine(batiment[B_Bergerie].quantity  * batiment[B_Bergerie].production[4]); //prod de laine par la cabane de bucherons

       //Chaine de productions
       //si un batiment TISSERAND est construit et si assez de laine alors productions de tissus
       if ( (batiment[B_Tisserand].quantity>0) and (getLaine() + batiment[B_Tisserand].production[4]>=0) ) then
         begin
            setTissu(batiment[B_Tisserand].quantity * batiment[B_Tisserand].production[5] );
            msgErreursProdChaine[1]:=''; //init du msg erreur (pas de msg d'erreurs)
         end
       //sinon si pas assez de laine alors msg erreur
       else if ( (batiment[B_Tisserand].quantity>0) and (getLaine() + batiment[B_Tisserand].production[4]<0) ) then
            msgErreursProdChaine[1]:='Vous n''avez pas assez de laines pour produire du tissus'; //init du msg d'erreur =>erreur



    end;

  //procedure qui affiche les msg d'erreurs des production de chaine contenu dans le tableau msgErreursProdChaine
  procedure afficheMessageProdChaine(posX,pos1eY,espacement: Integer);
    var
       numMsg: Integer;
       posY: Integer;
    begin
       posY:=pos1eY;
      //on parcourt le tableau pour afficher les messages d'erreurs s'ils existent
      for numMsg := Low(msgErreursProdChaine) to High(msgErreursProdChaine) do
        begin
           if msgErreursProdChaine[numMsg]<>'' then
             begin
              ecrireTexte(msgErreursProdChaine[numMsg],posX,posY);
              posY:=posY+espacement; //si le msg erreur existe alors rajouté espacement sinon non
             end;
        end;
    end;

  // retourne la quantité ou la capacité selon prop d'un batiment passé en paramètre
  function getBat_Prop(numBat:Integer; prop: String): Integer;
    var
       propChoice: Integer;                               // capacité en habitant du batiment à retourner
       capacity, quantity: Integer;
    begin
         propChoice:=0;
         capacity:= batiment[numBat].capacity; // affecte la CAPACITE du batiment passé en paramètre
         quantity:= batiment[numBat].quantity; // affecte la QUANTITE du batiment passé en paramètre
         case prop of                                 // retourne soit la QUANTITE soit la CAPACITE selon le propChoice passé en commentaire
           'quantity' : propChoice := quantity;
           'capacity' : propChoice := capacity;
         end;
         getBat_Prop:=propChoice;
    end;

  // retourne la valeur de production d'un item ressource produit ou utilisé par un batiment
  function getBat_Prod_Item_Value(numBat,numRessource: Integer): Integer;
    var
       tempInt: Integer;
    begin
     tempInt:= batiment[numBat].production[numRessource];
     getBat_Prod_Item_Value:=tempInt;
    end;

  // retourne la production de ressources d'un batiment ou de tout les batiments selon les paramètres entrés
  function get_Bat_Prod_Txt(numBat:Integer; production: String; total: String): String;
    var
       numRessource: Integer;      // compteur qui sert à parcourir les tableaux de ressources de construction

       TempTxt: String; // string qui stocke le texte de la production à renvoyer
       coef: Integer;

       {cette fonction retourne la production ou l'utilisation en ressources d'un batiment
       si production est passée avec 'produit' alors on recupère les ressources produites consommée par la batiment
       si production est passée avec 'necessite' alors on recupère les ressources consommées par le batiment
       la paramètre total est un coefficient, si il est passé en tant que 'total',
       on multiplie la valeur de la ressources par la quantité de batiment du même nom
       si le paramètre total est rentré en tant que 'unique', la fonction retourne
       la production/utilisation de resosurce d'un seul batiment}

    begin
         TempTxt:='';
         case total of
             'total'  : coef := getBat_Prop(numBat, 'quantity');
             'unique' : coef := 1;
         end;
         case production of
           'produit' :
                       begin
                           for numRessource:= 1 to GetTotalItemRessources() do
                             begin
                                 if (batiment[numBat].production[numRessource]) > 0 then                   // on va retourner seulement le nombre de ressources produites par tour
                                   TempTxt:= TempTxt + GetRessourcesTxt(numRessource) + IntToStr(getBat_Prod_Item_Value(numBat, numRessource)*coef) + '  ';
                             end;
                       end;
           'necessite':
                       begin
                           for numRessource:= 1 to GetTotalItemRessources() do
                             begin
                                 if (batiment[numBat].production[numRessource]) < 0 then                   // on va retourner seulement le nombre de ressources produites par tour
                                   TempTxt:= TempTxt + GetRessourcesTxt(numRessource) + IntToStr(batiment[numBat].production[numRessource]*coef) + '  ';
                             end;
                       end;
             end;
         get_Bat_Prod_Txt:=Temptxt;
    end;

  // retourne la valeur de cout de construction pour un item ressource donné pour la construction d'un batiment
  function getBat_Cost_Item_Value(numBat,numRessource:Integer): Integer;
    var
       x: Integer;                                       // compteur pour parcourir les batiments
       tempInt: Integer;
    begin
       // on parcourt tout les batiments declarés
        for x:=1 to totalBatiment do
            tempInt:= batiment[numBat].construct[numRessource];
        getBat_Cost_Item_Value:=tempInt;
    end;

  // retourne un string concatené composé de toutes les ressources nécéssaires à l'achat du batiment passé en paramètre
  function getBat_Cost_Txt(numBat:Integer): String;
    var
       numRessource: Integer;  // compteur qui sert à parcourir les tableaux de ressources de construction
       TempTxt: String;  // string qui stocke le texte du prix de construction à renvoyer
    begin
       TempTxt:='';
       for numRessource:= 1 to GetTotalItemRessources() do
         begin
            if ( (batiment[numBat].construct[numRessource]) > 0 ) then   // on va retourner seulement les items necessaires à la construction
                 TempTxt:= txtIndentation(TempTxt + GetRessourcesTxt(numRessource)+': ' + IntToStr(getBat_Cost_Item_Value(numBat,numRessource)),15)+'  ';
         end;
       getBat_Cost_Txt:=TempTxt;
    end;

  // permet de modifier la quantité du batiment passé en paramètre
  procedure SetBat_Quantity(numBat,valeur: Integer);
    begin
       batiment[numBat].quantity:= batiment[numBat].quantity+ valeur;
    end;

  {procedure qui récupère la quantité des logements en début de tour}
  procedure setLogementDebTour();
    begin
       nbMaisonDebTour:= batiment[B_Maison].quantity;
       nbVillaDebTour:= batiment[B_Villa].quantity;
    end;

  {fonction qui renvoie le nb de maisons au début du tour}
  function getMaisonGagne():Integer;
    begin
      getMaisonGagne:= batiment[B_Maison].quantity-nbMaisonDebTour;
    end;

  {fonction qui renvoie le nb de villa au début du tour}
  function getVIllaGagne(): Integer;
    begin
      getVIllaGagne:= batiment[B_Villa].quantity-nbVillaDebTour;
    end;

  //procedure de construction d'un batiment passé en paramètre
  function Build_Batiment(numBat:Integer;etatBesoinsColons:Boolean):String;
    var
         numRessource: Integer;  // compteur qui sert à parcourir les tableaux de ressources de construction
         RessourcesCount: Integer;
         TempTxtEchec,txtEchecVilla: String;
         TempTxtReussite: String;
         txtEchec: String;

    begin
         RessourcesCount:= 0; //variable entière
         TempTxtEchec:= '';
         TempTxtReussite:= 'Nouveau batiment ';
         txtEchecVilla := 'Besoins colons non satisfait';
         txtEchec := '';

         for numRessource:= 1 to GetTotalItemRessources() do
           begin
              //si ressources de notre inventaire suffisante ou que le batiment choisie et la villa de colons et que les besoins des colons sont satisfait
              if ( ( (GetRessourcesValue(numRessource) >= ((batiment[numBat].construct[numRessource]))) and (numBat<>B_Villa)) or ( (numBat=B_Villa) and (etatBesoinsColons) and (GetRessourcesValue(numRessource) >= ( (batiment[numBat].construct[numRessource]))) ) ) then
                  RessourcesCount:= RessourcesCount + 1
              //sinon si ressources insuffisante ou que le bat choisi est villa de citoyen et que les besoins des colons sont satisfait
              else
                  begin
                    TempTxtEchec:='ressources insuffisantes';
                    TempTxtEchec:= TempTxtEchec + GetRessourcesTxt(numRessource);
                  end;
              //si bat choisie = B_Villales besoins des colons ne sont pas satisfait => construction de villa impossible
              if ( (numBat=B_Villa) and (not(etatBesoinsColons)) ) then
                  begin
                     TempTxtEchec:='';
                     TempTxtEchec:=txtEchecVilla;
                  end;
            end;

         //si on a toutes les ressources suffisantes
         if (RessourcesCount=GetTotalItemRessources()) then
           begin
              SetBat_Quantity(numBat,1);
              for numRessource:=1 to GetTotalItemRessources() do
                  setRessource(numRessource,getBat_Cost_Item_Value(numBat,numRessource));
              Build_Batiment:=TempTxtReussite+batiment[numBat].nom;
           end
         //sinon si on a pas toutes les ressources suffisantes
         else
           Build_Batiment:=TempTxtEchec;
    end;

  procedure affichageBatiment(numBat:Integer;propriety: String; posX,posY:Integer);
    var
      posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
      //marge: Integer;
      txtToDisplay: String;
    begin
      case propriety of
           'nom'              : txtToDisplay:=  batiment[numBat].nom;//getBat_Nom(sorte,nom);
           'quantity'         : txtToDisplay:= 'Nombre : ' + IntToStr(batiment[numBat].quantity);//IntToStr(getBat_Prop(sorte,nom,'quantity'));
           'nom_quantity'     : txtToDisplay:=  batiment[numBat].nom + ' : ' + IntToStr(getBat_Prop(numBat,'quantity'));
           'construct'        : txtToDisplay:= '[Cout de construction] '  + getBat_Cost_Txt(numBat) + ']';
           'production'       : txtToDisplay:= '[Production de ressources]  ' + get_Bat_Prod_Txt(numBat,'produit','total');
            //'necessite'        : txtToDisplay:= '[Utilisation de ressources] ' +get_Bat_Prod_Txt(numBat,'necessite','total');
           'productionUnique' : txtToDisplay:= '[Produit] ' + get_Bat_Prod_Txt(numBat,'produit','unique');
           //'necessiteUnique'  : txtToDisplay:= '[Utilise] ' +get_Bat_Prod_Txt(numBat,'necessite','unique');
      end;
      posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
      posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
      ecrireEnPosition(posItem,txtToDisplay); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem
    end;

  // fonction qui détruit des batiments quand l'ouragan se produit et qui retourne un string correspondant au nombre de batiment detruits
  function ouraganBatDestroy():String;
    var
      numBat       : Integer;  // compteur pour parcourir les batiments
      randInteger  : Integer;
      cptBatDestroyed : Integer; // compteur de batiment détruits
      resistanceBat : Integer;   // coefficient utile pour proteger les batiments sociaux (plus solide et surtout plus cher à racheter)

    begin
           randInteger      := 0;
           cptBatDestroyed  := 0;
           resistanceBat    := 0;

           for numBat:=1 to totalBatiment do
           begin
                if batiment[numBat].sorte = 'SOCIAL' then
                resistanceBat := 2
                else
                resistanceBat := 1;

                randInteger := (random(getBat_Prop(numBat, 'quantity')) DIV resistanceBat);
                SetBat_Quantity(numBat, randInteger*-1); // déstruction aléatoir de batiment avec coefficient special pour les batiments sociaux
                cptBatDestroyed := cptBatDestroyed + randInteger;
           end;
      ouraganBatDestroy := IntToStr(cptBatDestroyed) + ' batiments ont ' + chr(0233)+ 't' + chr(0233) + ' d' + chr(0233) + 'truits par l''ouragan...';
    end;


end.

