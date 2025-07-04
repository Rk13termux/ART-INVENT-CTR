class AppConstants {
  // App Info
  static const String appName = 'ATR Inventory Control';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'atr_inventory.db';
  static const int databaseVersion = 1;
  
  // Product Types
  static const List<String> agriculturalProducts = [
    'Arracacha',
    'Ahuyama',
    'Frijol',
    'Tomate de Árbol',
    'Pepino de Guiso',
    'Curuba',
    'Otros',
  ];
  
  // Units of Measure
  static const List<String> saleUnits = [
    'Bulto',
    'Canastilla',
    'Kilos',
    'Libras',
    'Octavos',
    'Cuartos',
    'Medios',
  ];
  
  // Product Unit Weights (in kilos)
  static const Map<String, Map<String, double>> productWeights = {
    'Arracacha': {
      'octavo': 12.5,
      'cuarto': 25.0,
      'medio': 50.0,
      'bulto': 100.0,
      'canastilla': 25.0,
    },
    'Ahuyama': {
      'octavo': 15.0,
      'cuarto': 30.0,
      'medio': 60.0,
      'bulto': 120.0,
      'canastilla': 30.0,
    },
    'Frijol': {
      'octavo': 6.25,
      'cuarto': 12.5,
      'medio': 25.0,
      'bulto': 50.0,
      'canastilla': 12.5,
    },
    'Tomate de Árbol': {
      'octavo': 10.0,
      'cuarto': 20.0,
      'medio': 40.0,
      'bulto': 80.0,
      'canastilla': 20.0,
    },
    'Pepino de Guiso': {
      'octavo': 8.0,
      'cuarto': 16.0,
      'medio': 32.0,
      'bulto': 64.0,
      'canastilla': 16.0,
    },
    'Curuba': {
      'octavo': 5.0,
      'cuarto': 10.0,
      'medio': 20.0,
      'bulto': 40.0,
      'canastilla': 10.0,
    },
  };
  
  // Quality Control Settings
  static const int freshnessDays = 7;
  static const int warningDays = 5;
  static const int criticalDays = 2;
  
  // File Paths
  static const String reportsPath = '/storage/emulated/0/Download/ATR_Reports';
  
  // Colors
  static const String primaryColorHex = '#2E7D32';
  static const String secondaryColorHex = '#4CAF50';
  static const String accentColorHex = '#FF6F00';
  static const String errorColorHex = '#D32F2F';
  static const String warningColorHex = '#F57C00';
  static const String successColorHex = '#388E3C';
}

class DatabaseTables {
  static const String products = 'products';
  static const String inventory = 'inventory';
  static const String sales = 'sales';
  static const String saleItems = 'sale_items';
  static const String clients = 'clients';
  static const String mermas = 'mermas';
  static const String qualityChecks = 'quality_checks';
}

class ProductStatus {
  static const String fresh = 'fresh';
  static const String warning = 'warning';
  static const String critical = 'critical';
  static const String expired = 'expired';
}

class SaleStatus {
  static const String completed = 'completed';
  static const String pending = 'pending';
  static const String credit = 'credit';
  static const String cancelled = 'cancelled';
}
