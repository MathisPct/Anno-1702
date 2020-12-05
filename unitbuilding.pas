unit UnitBuilding;

{$mode objfpc}{$H+}

interface

  uses
    unitRessources, Classes, SysUtils, GestionEcran ;

  // initialise les batiment en début de partie
  procedure initBuilding();

  //procédure qui permet de produire des ressources suivant le nb de batiment qu'on a et les coefs de prod de ressources de chaque bat
  procedure productionBatTour();

  // retourne le nom du batiment passé en paramètre
  function getBat_Nom(sorte: String; nom: String): String;

  // retourne la quantité ou la capacité selon prop d'un batiment passé en paramètre
  function getBat_Prop(sorte: String; nom: String; prop: String): Integer;

  // retourne la valeur de cout de construction pour un item ressource donné pour la construction d'un batiment
  function getBat_Cost_Item_Value(sorte: String; nom: String; Item: Integer): Integer;

  // retourne un string concatené composé de toutes les ressources nécéssaires à l'achat du batiment passé en paramètre
  function getBat_Cost_Txt(sorte: String; nom: String): String;

  // retourne la valeur de production d'un item ressource produit ou utilisé par un batiment
  function getBat_Prod_Item_Value(sorte: String; nom: String; Item: Integer): Integer;

  // retourne l'utilisation ou la production de ressources d'un batiment ou de tout les batiments selon les paramètres entrés
  function get_Bat_Prod_Txt(sorte: String; nom: String; production: String; total: String): String;

  // permet de modifier la quantité du batiment passé en paramètre
  procedure SetBat_Quantity(sorte: String; nom: String; valeur: Integer);

  //procedure de construction d'un batiment passé en paramètre
  function Build_Batiment(sorte: String; nom: String):String;

  procedure affichageBatiment(sorte: String; nom:String; propriety: String; posX,posY:Integer);


  type Building = record
    sorte        : String;
    nom          : String;
    quantity     : Integer; // nombre de batiment de ce type
    capacity     : Integer; // nombre occupant contenu par le batiment
    construct    : Array[1..6] of Integer;
    production   : Array[1..6] of Integer;

  end;

implementation

  const
    totalBatiment = 7; //nombre total de batiment
  var
     batiment : array[1..totalBatiment] of Building; //permet de créer des variations du record building et ainsi de décrire tout les batiments du jeu

  // initialise les batiment en début de partie
  procedure initBuilding();
    const
      // sorte HABITAT
      B_Maison      = 1;

      // sorte INDUSTRIE
      B_Fisher      = 2;
      B_Bucheron    = 3;
      B_Bergerie    = 4;
      B_Tisserand   = 5;

      // sorte SOCIAL
      B_Chapelle    = 6;
      B_CentreVille = 7;

    begin

    /////////////////////////////////////// H-A-B-I-T-A-T/////////////////////////////////////////

       //------------------------------------------------------------------------- M A I S O N
       batiment[B_Maison].sorte           := 'HABITAT';
       batiment[B_Maison].nom             := 'Maison de Colon';
       batiment[B_Maison].quantity        := 0;
       batiment[B_Maison].capacity        := 4;
       //Cout de construction
       batiment[B_Maison].construct[1]    := 5; // cout GOLD
       batiment[B_Maison].construct[2]    := 5; // cout BOIS
       batiment[B_Maison].construct[3]    := 0; // cout Poisson
       batiment[B_Maison].construct[4]    := 0; // cout Laine
       batiment[B_Maison].construct[5]    := 0; // cout Tissu
       batiment[B_Maison].construct[6]    := 0; // cout Outils
       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Maison].production[1]   := 0;   // Gold
       batiment[B_Maison].production[2]   := 0;   // Wood
       batiment[B_Maison].production[3]   := 0;   // Fish
       batiment[B_Maison].production[4]   := 0;   // Laine
       batiment[B_Maison].production[5]   := -5;   // Tissu
       batiment[B_Maison].production[6]   := 4;   // Outils

  /////////////////////////////////////// S-O-C-I-A-L /////////////////////////////////////////

       //------------------------------------------------------------------------- C H A P E L L E
       batiment[B_Chapelle].sorte           := 'SOCIAL';
       batiment[B_Chapelle].nom             := 'Chapelle';
       batiment[B_Chapelle].quantity        := 0;
       batiment[B_Chapelle].capacity        := 0;
       //Cout de construction
       batiment[B_Chapelle].construct[1]    := 3000; // cout GOLD
       batiment[B_Chapelle].construct[2]    := 200; // cout BOIS
       batiment[B_Chapelle].construct[3]    := 0; // cout Poisson
       batiment[B_Chapelle].construct[4]    := 0; // cout Laine
       batiment[B_Chapelle].construct[5]    := 50; // cout Tissu
       batiment[B_Chapelle].construct[6]    := 1; // cout Outils
       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Chapelle].production[1]   := 0;   // Gold
       batiment[B_Chapelle].production[2]   := -5;  // Wood
       batiment[B_Chapelle].production[3]   := 0;   // Fish
       batiment[B_Chapelle].production[4]   := 0;   // Laine
       batiment[B_Chapelle].production[5]   := 0;   // Tissu
       batiment[B_Chapelle].production[6]   := -5; // Outils

       //------------------------------------------------------------------------- Centre-Ville
       batiment[B_CentreVille].sorte           := 'SOCIAL';
       batiment[B_CentreVille].nom             := 'Centre-Ville';
       batiment[B_CentreVille].quantity        := 0;
       batiment[B_CentreVille].capacity        := 0;
       //Cout de construction
       batiment[B_CentreVille].construct[1]    := 500; // cout GOLD
       batiment[B_CentreVille].construct[2]    := 100; // cout BOIS
       batiment[B_CentreVille].construct[3]    := 0; // cout Poisson
       batiment[B_CentreVille].construct[4]    := 0; // cout Laine
       batiment[B_CentreVille].construct[5]    := 0; // cout Tissu
       batiment[B_CentreVille].construct[6]    := 15; // cout Outils
       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_CentreVille].production[1]   := 0;   // Gold
       batiment[B_CentreVille].production[2]   := 0;  // Wood
       batiment[B_CentreVille].production[3]   := 0;   // Fish
       batiment[B_CentreVille].production[4]   := 0;   // Laine
       batiment[B_CentreVille].production[5]   := 0;   // Tissu
       batiment[B_CentreVille].production[6]   := -2; // Outils

  ///////////////////////////////////////I-N-D-U-S-T-R-I-E////////////////////////////////////////////

       //-------------------------------------------------------- C A B A N E   D E   P E C H E U R
       batiment[B_Fisher].sorte           := 'INDUSTRIE';
       batiment[B_Fisher].nom             := 'Cabane de Pecheur';
       batiment[B_Fisher].quantity        := 0;
       batiment[B_Fisher].capacity        := 0;
       // COUT DE CONSTRUCTION [update l'unité ressources seulement à l'achat]
       batiment[B_Fisher].construct[1]    := 15;  // coute Gold
       batiment[B_Fisher].construct[2]    := 3;   // coute Wood
       batiment[B_Fisher].construct[3]    := 0;   // coute Fish
       batiment[B_Fisher].construct[4]    := 0;   // coute Laine
       batiment[B_Fisher].construct[5]    := 0;   // coute Tissu
       batiment[B_Fisher].construct[6]    := 0;   // coute Outils

       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Fisher].production[1]   := 0;   // Gold
       batiment[B_Fisher].production[2]   := 0;   // Wood
       batiment[B_Fisher].production[3]   := 1;   // Fish
       batiment[B_Fisher].production[4]   := 0;   // Laine
       batiment[B_Fisher].production[5]   := 0;   // Tissu
       batiment[B_Fisher].production[6]   := 0;   // Outils

       //----------------------------------------------------------C A B A N E   D E   B U C H E R O N ----------------------------------
       batiment[B_Bucheron].sorte           := 'INDUSTRIE';
       batiment[B_Bucheron].nom             := 'Cabane de Bucheron';
       batiment[B_Bucheron].quantity        := 0;
       batiment[B_Bucheron].capacity        := 0;
       // COUT DE CONSTRUCTION [update l'unité ressources seulement à l'achat]
       batiment[B_Bucheron].construct[1]    := 25;  // coute Gold
       batiment[B_Bucheron].construct[2]    := 5;   // coute Wood
       batiment[B_Bucheron].construct[2]    := 7;   // coute Fish
       batiment[B_Bucheron].construct[4]    := 0;   // coute Laine
       batiment[B_Bucheron].construct[5]    := 0;   // coute Tissu
       batiment[B_Bucheron].construct[6]    := 0;   // coute Outils
       // PRODUIT / NECESSITE ressources [update l'unité ressources chaque tour]
       batiment[B_Bucheron].production[1]   := 0;   // Gold
       batiment[B_Bucheron].production[2]   := 1;   // Wood
       batiment[B_Bucheron].production[3]   := 0;   // Fish
       batiment[B_Bucheron].production[4]   := 0;   // Laine
       batiment[B_Bucheron].production[5]   := 0;   // Tissu
       batiment[B_Bucheron].production[6]   := 0;   // Outils


       //---------------------------------------------------------- B E R G E R I E ----------------------------------
       batiment[B_Bergerie].sorte           := 'INDUSTRIE';
       batiment[B_Bergerie].nom             := 'Bergerie';
       batiment[B_Bergerie].quantity        := 0;
       batiment[B_Bergerie].capacity        := 1;
       //Cout de construction
       batiment[B_Bergerie].construct[1]    := 25;  // coute Gold
       batiment[B_Bergerie].construct[2]    := 10;  // coute Wood
       batiment[B_Bergerie].construct[2]    := 0;   // coute Fish
       batiment[B_Bergerie].construct[4]    := 0;   // coute Laine
       batiment[B_Bergerie].construct[5]    := 0;   // coute Tissu
       batiment[B_Bergerie].construct[6]    := 0;   // coute Outils
       // production de ressources
       batiment[B_Bergerie].production[1]   := 0;   // Gold
       batiment[B_Bergerie].production[2]   := 0;   // Wood
       batiment[B_Bergerie].production[3]   := 0;   // Fish
       batiment[B_Bergerie].production[4]   := 5;   // Laine
       batiment[B_Bergerie].production[5]   := 0;   // Tissu
       batiment[B_Bergerie].production[6]   := 0;   // Outils


       //---------------------------------------------------------- T I S S E R A N D ----------------------------------
       batiment[B_Tisserand].sorte           := 'INDUSTRIE';
       batiment[B_Tisserand].nom             := 'Atelier de Tisserand';
       batiment[B_Tisserand].quantity        := 0;
       batiment[B_Tisserand].capacity        := 1;
       //Cout de construction
       batiment[B_Tisserand].construct[1]    := 35;  // coute Gold
       batiment[B_Tisserand].construct[2]    := 10;  // coute Wood
       batiment[B_Tisserand].construct[2]    := 0;   // coute Fish
       batiment[B_Tisserand].construct[4]    := 10;  // coute Laine
       batiment[B_Tisserand].construct[5]    := 0;   // coute Tissu
       batiment[B_Tisserand].construct[6]    := 0;   // coute Outils
       // production de ressources
       batiment[B_Tisserand].production[1]   := 0;   // Gold
       batiment[B_Tisserand].production[2]   := 0;   // Wood
       batiment[B_Tisserand].production[3]   := 0;   // Fish
       batiment[B_Tisserand].production[4]   := -1; // nécéssite de la Laine pour produire
       batiment[B_Tisserand].production[5]   := 3;   // Tissu
       batiment[B_Tisserand].production[6]   := 0;   // Outils
  end;

  //procédure qui permet de produire des ressources suivant le nb de batiment qu'on a et suivant les coefs de prod de ressources de chaque batiment
  procedure productionBatTour();
    var
       boisProduit: Integer; //var int = nb de bois produit durant le tour affecté à la valeur du bois
       poissonsProduit: Integer; //var int = nb de poissons produit durant le tour affecté à la valeur du poissons
       laineProduites: Integer; //var int = nb de laines produit durant le tour affecté à la valeur du laine
       tissusProduit: Integer; //var int = nb de tissus produit durant le tour. Enlève de la laine quand il est produit
       laineEnMoins: Integer; //var int = nb de laines en moins si l'user a des cabanes de tisserand
    begin
       boisProduit:= batiment[3].quantity * batiment[3].production[2]; //quantité de bois produit= quantité de cabanes bucherons * coef prod bois /cabane
       setWood(boisProduit); //ajoute nb bois produit
       poissonsProduit:= batiment[2].quantity*batiment[2].production[3];
       setFish(poissonsProduit); //ajoute nb poissons produit
       laineProduites:= batiment[4].quantity * batiment[4].production[4];
       setLaine(laineProduites);
       //si assez de laine alors productions de tissus
       if (getLaine() + batiment[5].production[4]>0 ) then
         tissusProduit := batiment[5].quantity * batiment[5].production[5]; //quantité de bat tisserands * coef de prod de tissus
         laineEnMoins :=  batiment[5].quantity * batiment[5].production[4]; //quantité de bat tisserands * coef de laines perdues
         setTissu(tissusProduit);
         setLaine(laineEnMoins);
       //else sinon gestion des erreurs

    end;

  // retourne le nom du batiment passé en paramètre
  function getBat_Nom(sorte: String; nom: String): String;
    var
       x: Integer;        // compteur pour parcourir les batiments
       nomBat: String;    // nom bat à retourner en habitant du batiment à retourner
    begin
         for x:=1 to totalBatiment do  // on parcourt tout les batiments declarés
             begin
                  if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
                     begin
                       nomBat:= batiment[x].nom; // affecte le nom  du batiment passé en paramètre
                     end;
             end;
         getBat_Nom:=nomBat;
    end;

  // retourne la quantité ou la capacité selon prop d'un batiment passé en paramètre
  function getBat_Prop(sorte: String; nom: String; prop: String): Integer;
    var
       x: Integer;                                        // compteur pour parcourir les batiments
       propChoice: Integer;                               // capacité en habitant du batiment à retourner
       capacity, quantity: Integer;
    begin
         propChoice:=0;

         for x:=1 to totalBatiment do             // on parcourt tout les batiments declarés
           begin
               if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
                   begin
                     capacity:= batiment[x].capacity; // affecte la CAPACITE du batiment passé en paramètre
                     quantity:= batiment[x].quantity; // affecte la QUANTITE du batiment passé en paramètre
                   end;
           end;

         case prop of                                 // retourne soit la QUANTITE soit la CAPACITE selon le propChoice passé en commentaire
           'quantity' : propChoice := quantity;
           'capacity' : propChoice := capacity;
         end;
         getBat_Prop:=propChoice;
    end;

  // retourne la valeur de production d'un item ressource produit ou utilisé par un batiment
  function getBat_Prod_Item_Value(sorte: String; nom: String; Item: Integer): Integer;
    var
       x: Integer;                                       // compteur pour parcourir les batiments
       tempInt: Integer;
    begin
        for x:=1 to totalBatiment do             // on parcourt tout les batiments declarés
          begin
               if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
                 begin
                      tempInt:= batiment[x].production[Item];
                 end;
          end;
        getBat_Prod_Item_Value:=tempInt;
    end;

  // retourne l'utilisation ou la production de ressources d'un batiment ou de tout les batiments selon les paramètres entrés
  function get_Bat_Prod_Txt(sorte: String; nom: String; production: String; total: String): String;
    var
       x: Integer;      // compteur pour parcourir les batiments
       i: Integer;      // compteur qui sert à parcourir les tableaux de ressources de construction

       TempTxt: String; // string qui stocke le texte de la production à renvoyer
       Item: Integer;
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
         Item:= GetTotalItemRessources();

         case total of
             'total'  : coef := getBat_Prop(sorte, nom, 'quantity');
             'unique' : coef := 1;
         end;

         for x:=1 to totalBatiment do // on parcourt toutes les batiments declarés
           begin
             if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
             case production of
               'produit' :
                           begin
                               for i:= 1 to Item do
                                 begin
                                     if (batiment[x].production[i]) > 0 then                   // on va retourner seulement le nombre de ressources produites par tour
                                       TempTxt:= TempTxt + GetRessourcesTxt(i) + IntToStr(getBat_Prod_Item_Value(sorte, nom, i)*coef) + '  ';
                                 end;
                           end;
               'necessite':
                           begin
                               for i:= 1 to Item do
                                 begin
                                     if (batiment[x].production[i]) < 0 then                   // on va retourner seulement le nombre de ressources produites par tour
                                       TempTxt:= TempTxt + GetRessourcesTxt(i) + IntToStr(getBat_Prod_Item_Value(sorte, nom, i)*coef) + '  ';
                                 end;
                           end;

                 end;
           end;
         get_Bat_Prod_Txt:=Temptxt;
    end;

  // retourne la valeur de cout de construction pour un item ressource donné pour la construction d'un batiment
  function getBat_Cost_Item_Value(sorte: String; nom: String; Item: Integer): Integer;
    var
       x: Integer;                                       // compteur pour parcourir les batiments
       tempInt: Integer;
    begin
        for x:=1 to totalBatiment do             // on parcourt tout les batiments declarés
          begin
               if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
                 begin
                      tempInt:= batiment[x].construct[Item];
                 end;
          end;
        getBat_Cost_Item_Value:=tempInt;
    end;

  // retourne un string concatené composé de toutes les ressources nécéssaires à l'achat du batiment passé en paramètre
  function getBat_Cost_Txt(sorte: String; nom: String): String;
    var
       x: Integer;                                                             // compteur pour parcourir les batiments
       i: Integer;                                                             // compteur qui sert à parcourir les tableaux de ressources de construction
       TempTxt: String;                                                        // string qui stocke le texte du prix de construction à renvoyer
       Item: Integer;
    begin
       TempTxt:='';
       Item:= GetTotalItemRessources();
       for x:=1 to totalBatiment do // on parcourt toutes les batiments declarés
           if ((batiment[x].sorte = sorte) AND (batiment[x].nom = nom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
             begin
                 for i:= 1 to Item do
                   begin
                      if (batiment[x].construct[i]) > 0 then                   // on va retourner seulement les items necessaires à la construction
                         begin
                           TempTxt:= TempTxt + GetRessourcesTxt(i) + IntToStr(getBat_Cost_Item_Value(sorte, nom, i)) + '    ';
                         end;
                   end;
                 getBat_Cost_Txt:=Temptxt;
             end;
    end;

  // permet de modifier la quantité du batiment passé en paramètre
  procedure SetBat_Quantity(sorte: String; nom: String; valeur: Integer);
    var
       x          : Integer;        // compteur pour parcourir les batiments
       TempSorte  : String;
       TempNom    : String;

    begin
       TempSorte  := sorte;
       TempNom    := nom;
       for x:=1 to totalBatiment do // on parcourt toutes les batiments declarés
         begin
             if ((batiment[x].sorte = TempSorte) AND (batiment[x].nom = TempNom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
               begin
                    batiment[x].quantity := batiment[x].quantity + valeur;                   // on ajoute la valeur passé en paramètre au nombre de batiment de ce nom et cette sorte
               end;
         end;
    end;

  //procedure de construction d'un batiment passé en paramètre
  function Build_Batiment(sorte: String; nom: String):String;
    var
       x              : Integer;  // compteur pour parcourir les batiments
       i              : Integer;  // compteur qui sert à parcourir les tableaux de ressources de construction
       Item           : Integer;  // correspond au nombre total d'item ressource
       RessourcesCount: Integer;
       TempTxtEchec   : String;
       TempTxtReussite: String;
       TempSorte      : String;
       TempNom        : String;

    begin
         TempSorte  := sorte;
         TempNom    := nom;
         Build_Batiment := '';
         RessourcesCount:= 0;
         TempTxtEchec:= 'ressources insuffisantes !';
         TempTxtReussite:= 'Nouveau batiment ';
         Item:= GetTotalItemRessources();

         for x:=1 to totalBatiment do // on parcourt toutes les batiments declarés
           begin
             if ((batiment[x].sorte = TempSorte) AND (batiment[x].nom = TempNom)) then // si le batiment trouvé est de la sorte et du nom passé en paramètre alors
               begin
                   for i:= 1 to Item do
                     begin
                        if (GetRessourcesValue(i) >= batiment[x].construct[i]) then                   // on va retourner seulement les items necessaires à la construction
                           begin
                                RessourcesCount:= RessourcesCount + 1;
                           end
                        else
                            TempTxtEchec:=TempTxtEchec + GetRessourcesTxt(i);
                     end;
               end;
           end;

         if (RessourcesCount = GetTotalItemRessources()) then
            begin
                 SetBat_Quantity(TempSorte, TempNom, 1);
                 for i:= 1 to Item do
                   begin
                        setRessource(i, getBat_Cost_Item_Value(TempSorte, TempNom, i));
                   end;
                 Build_Batiment:= TempTxtReussite + TempNom
            end
         else
             Build_Batiment:=TempTxtEchec;
    end;


  procedure affichageBatiment(sorte: String; nom:String; propriety: String; posX,posY:Integer);
    var
      posItem: coordonnees; //variable, coordonnées de placement d'un item avec sa position en x et en y
      //marge: Integer;
      txtToDisplay: String;
    begin
      //marge:= 3;
      case propriety of
           'nom'              : txtToDisplay:= getBat_Nom(sorte,nom);
           'quantity'         : txtToDisplay:= 'Nombre : ' + IntToStr(getBat_Prop(sorte,nom,'quantity'));
           'nom_quantity'     : txtToDisplay:=  getBat_Nom(sorte,nom) + ' : ' + IntToStr(getBat_Prop(sorte,nom,'quantity'));
           'construct'        : txtToDisplay:= '[Cout de construction] '  + getBat_Cost_Txt(sorte,nom) + ']';
           'production'       : txtToDisplay:= '[Production de ressources]  ' + get_Bat_Prod_Txt(sorte,nom,'produit','total');
           'necessite'        : txtToDisplay:= '[Utilisation de ressources] ' +get_Bat_Prod_Txt(sorte,nom,'necessite','total');
           'productionUnique' : txtToDisplay:= '[Produit] ' + get_Bat_Prod_Txt(sorte,nom,'produit','unique');
           'necessiteUnique'  : txtToDisplay:= '[Utilise] ' +get_Bat_Prod_Txt(sorte,nom,'necessite','unique');
      end;
           posItem.x:=posX; //initialisation du placement en x de l'item (permet de placer l'item en tout point x passé en paramètre)
           posItem.y:=posY; //initialisation du placement en y de l'item (permet de placer l'item en tout point y passé en paramètre)
           ecrireEnPosition(posItem,txtToDisplay); //fonction de l'unité Gestion Ecran qui affiche l'item du menu à la position PosItem

    end;


end.

