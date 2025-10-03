import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/constants/app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  
  DatabaseHelper._internal();
  
  factory DatabaseHelper() {
    return _instance;
  }
  
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
    // Create users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT,
        phone_number TEXT,
        profile_image_path TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        is_biometric_enabled INTEGER DEFAULT 0
      )
    ''');
    
    // Create loans table
    await db.execute('''
      CREATE TABLE loans (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        principal_amount REAL NOT NULL,
        interest_rate REAL NOT NULL,
        loan_type TEXT NOT NULL,
        payment_frequency TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        lender_name TEXT NOT NULL,
        lender_contact TEXT,
        status TEXT NOT NULL,
        currency TEXT NOT NULL,
        notes TEXT,
        document_paths TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Create payments table
    await db.execute('''
      CREATE TABLE payments (
        id TEXT PRIMARY KEY,
        loan_id TEXT NOT NULL,
        amount REAL NOT NULL,
        payment_date TEXT NOT NULL,
        payment_method TEXT NOT NULL,
        status TEXT NOT NULL,
        receipt_path TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (loan_id) REFERENCES loans (id)
      )
    ''');
    
    // Create notifications table
    await db.execute('''
      CREATE TABLE notifications (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        type TEXT NOT NULL,
        is_read INTEGER DEFAULT 0,
        scheduled_date TEXT NOT NULL,
        sent_date TEXT,
        loan_id TEXT,
        payment_id TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (loan_id) REFERENCES loans (id),
        FOREIGN KEY (payment_id) REFERENCES payments (id)
      )
    ''');
    
    // Create indexes for better performance
    await db.execute('CREATE INDEX idx_loans_user_id ON loans(user_id)');
    await db.execute('CREATE INDEX idx_loans_status ON loans(status)');
    await db.execute('CREATE INDEX idx_payments_loan_id ON payments(loan_id)');
    await db.execute('CREATE INDEX idx_payments_status ON payments(status)');
    await db.execute('CREATE INDEX idx_notifications_scheduled_date ON notifications(scheduled_date)');
  }
  
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    // For now, we'll just recreate the tables
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS notifications');
      await db.execute('DROP TABLE IF EXISTS payments');
      await db.execute('DROP TABLE IF EXISTS loans');
      await db.execute('DROP TABLE IF EXISTS users');
      await _onCreate(db, newVersion);
    }
  }
  
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
  
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
