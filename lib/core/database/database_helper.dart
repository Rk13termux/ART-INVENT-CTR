import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../constants/app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Products table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.products} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        image_url TEXT,
        unit_weights TEXT NOT NULL,
        base_price REAL NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Inventory table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.inventory} (
        id TEXT PRIMARY KEY,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        weight_kilos REAL NOT NULL,
        purchase_price REAL NOT NULL,
        selling_price REAL NOT NULL,
        supplier TEXT NOT NULL,
        purchase_date TEXT NOT NULL,
        expiry_date TEXT NOT NULL,
        batch_number TEXT NOT NULL,
        location TEXT NOT NULL,
        status TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES ${DatabaseTables.products} (id)
      )
    ''');

    // Clients table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.clients} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        address TEXT,
        identification TEXT,
        client_type TEXT NOT NULL DEFAULT 'regular',
        credit_limit REAL NOT NULL DEFAULT 0.0,
        current_debt REAL NOT NULL DEFAULT 0.0,
        is_active INTEGER NOT NULL DEFAULT 1,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Sales table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.sales} (
        id TEXT PRIMARY KEY,
        client_id TEXT,
        client_name TEXT,
        total_amount REAL NOT NULL,
        paid_amount REAL NOT NULL,
        remaining_amount REAL NOT NULL,
        sale_type TEXT NOT NULL,
        payment_method TEXT NOT NULL,
        status TEXT NOT NULL,
        notes TEXT,
        sale_date TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (client_id) REFERENCES ${DatabaseTables.clients} (id)
      )
    ''');

    // Sale Items table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.saleItems} (
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        inventory_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        unit_price REAL NOT NULL,
        total_price REAL NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (sale_id) REFERENCES ${DatabaseTables.sales} (id),
        FOREIGN KEY (inventory_id) REFERENCES ${DatabaseTables.inventory} (id),
        FOREIGN KEY (product_id) REFERENCES ${DatabaseTables.products} (id)
      )
    ''');

    // Mermas table (waste/losses)
    await db.execute('''
      CREATE TABLE ${DatabaseTables.mermas} (
        id TEXT PRIMARY KEY,
        inventory_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        reason TEXT NOT NULL,
        loss_type TEXT NOT NULL,
        estimated_value REAL NOT NULL,
        notes TEXT,
        reported_date TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (inventory_id) REFERENCES ${DatabaseTables.inventory} (id),
        FOREIGN KEY (product_id) REFERENCES ${DatabaseTables.products} (id)
      )
    ''');

    // Quality Checks table
    await db.execute('''
      CREATE TABLE ${DatabaseTables.qualityChecks} (
        id TEXT PRIMARY KEY,
        inventory_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        check_date TEXT NOT NULL,
        quality_score INTEGER NOT NULL,
        freshness_level TEXT NOT NULL,
        visual_condition TEXT,
        notes TEXT,
        checked_by TEXT NOT NULL,
        next_check_date TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (inventory_id) REFERENCES ${DatabaseTables.inventory} (id),
        FOREIGN KEY (product_id) REFERENCES ${DatabaseTables.products} (id)
      )
    ''');

    // Create indexes for better performance
    await db.execute('CREATE INDEX idx_inventory_product_id ON ${DatabaseTables.inventory}(product_id)');
    await db.execute('CREATE INDEX idx_inventory_status ON ${DatabaseTables.inventory}(status)');
    await db.execute('CREATE INDEX idx_inventory_expiry_date ON ${DatabaseTables.inventory}(expiry_date)');
    await db.execute('CREATE INDEX idx_sales_client_id ON ${DatabaseTables.sales}(client_id)');
    await db.execute('CREATE INDEX idx_sales_date ON ${DatabaseTables.sales}(sale_date)');
    await db.execute('CREATE INDEX idx_sale_items_sale_id ON ${DatabaseTables.saleItems}(sale_id)');
    await db.execute('CREATE INDEX idx_quality_checks_inventory_id ON ${DatabaseTables.qualityChecks}(inventory_id)');
    
    // Insert default agricultural products
    await _insertDefaultProducts(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    // For now, we'll just recreate the database
    if (oldVersion < newVersion) {
      // Drop all tables
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.qualityChecks}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.mermas}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.saleItems}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.sales}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.clients}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.inventory}');
      await db.execute('DROP TABLE IF EXISTS ${DatabaseTables.products}');
      
      // Recreate
      await _onCreate(db, newVersion);
    }
  }

  Future<void> _insertDefaultProducts(Database db) async {
    final defaultProducts = AppConstants.agriculturalProducts;
    final now = DateTime.now().toIso8601String();
    
    for (String productName in defaultProducts) {
      if (productName != 'Otros') {
        final weights = AppConstants.productWeights[productName] ?? {};
        await db.insert(DatabaseTables.products, {
          'id': 'default_${productName.toLowerCase().replaceAll(' ', '_')}',
          'name': productName,
          'category': 'Agricola',
          'description': 'Producto agrícola - $productName',
          'unit_weights': weights.toString(),
          'base_price': 5000.0, // Default price
          'is_active': 1,
          'created_at': now,
          'updated_at': now,
        });
      }
    }
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
