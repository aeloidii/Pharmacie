class stock {
  static const String Item1 = 'Categories';
  static const String Item2 = 'Articles';
  static const String Item3 = 'Achats';
  static const String Item4 = 'Ventes';
  static const String Item5 = 'Achats retournés';
  static const String Item6 = 'Ventes retournées';

  static const List<String> choices = <String>[
          Item1,
          Item2,
          Item3,
          Item4,
          Item5,
          Item6,


  ];
}

class suppliers {
  static const String Item1 = 'Fournisseurs';
  // static const String Item2 = 'Crédits';
  static const String Item3 = 'Versements';


  static const List<String> choices = <String>[
    Item1,
    // Item2,
    Item3,


  ];
}
class POS {
  static const String Item1 = 'Demande de Prix';
  static const String Item2 = 'Bon de Commande';
  static const String Item3 = 'Devis';
  static const String Item4 = 'Bon de Livraison';
  static const String Item5 = 'Facture';


  static const List<String> choices = <String>[
    Item1,
    Item2,
    Item3,
    Item4,
    Item5,


  ];
}


class DSS {
  static const String Item1 = 'Delivery Slip';
  static const String Item2 = 'View list';


  static const List<String> choices = <String>[
    Item1,
    Item2,


  ];
}

class returnedmerchandise {
  static const String Item1 = 'Return articles';
  static const String Item2 = 'View list';


  static const List<String> choices = <String>[
    Item1,
    Item2,


  ];
}


class clients {
  static const String Item1 = 'Clients';
  static const String Item2 = 'Paiement reçu';
  // static const String Item4 = 'Credits';


  static const List<String> choices = <String>[
    Item1,
    Item2,
    // Item4,


  ];
}

class charges {
  static const String Item1 = 'Types';
  static const String Item2 = 'Charges';


  static const List<String> choices = <String>[
    Item1,
    Item2,


  ];
}


class users {
  static const String Item1 = 'Add user';
  static const String Item2 = 'View list';


  static const List<String> choices = <String>[
    Item1,
    Item2,


  ];
}