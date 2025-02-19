import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'elvale.db');
    return await openDatabase(
      path,
      version: 2, // Increment this number
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add missing columns
      await db.execute('ALTER TABLE establecimiento ADD COLUMN telefono TEXT');
      await db.execute('ALTER TABLE establecimiento ADD COLUMN estado TEXT');
      await db.execute('ALTER TABLE establecimiento ADD COLUMN usuarioGestor TEXT');
      await db.execute('ALTER TABLE establecimiento ADD COLUMN fechaGestion TEXT');
      await db.execute('ALTER TABLE establecimiento ADD COLUMN usuarioAprobador TEXT');
      await db.execute('ALTER TABLE establecimiento ADD COLUMN fechaAprobacion TEXT');
    }
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE establecimiento(
        id TEXT PRIMARY KEY,
        razonSocial TEXT,
        nit TEXT,
        descripcion TEXT,
        observaciones TEXT,
        direccion TEXT,
        telefono TEXT,
        estado TEXT,
        usuarioGestor TEXT,
        fechaGestion TEXT,
        usuarioAprobador TEXT,
        fechaAprobacion TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE usuario_actual(
        uid TEXT PRIMARY KEY,
        establecimiento_id TEXT,
        nombres TEXT,
        apellidos TEXT,
        email TEXT,
        rol TEXT,
        FOREIGN KEY (establecimiento_id) REFERENCES establecimiento (id)
      )
    ''');
  }

  Future<void> guardarEstablecimientoYUsuario({
    required Map<String, dynamic> establecimiento,
    required Map<String, dynamic> usuario,
  }) async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.insert(
        'establecimiento',
        establecimiento,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await txn.insert(
        'usuario_actual',
        usuario,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<Map<String, dynamic>?> obtenerEstablecimientoActual() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('establecimiento');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> obtenerUsuarioActual() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('usuario_actual');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<void> limpiarDatos() async {
    final Database db = await database;
    await db.delete('usuario_actual');
    await db.delete('establecimiento');
  }
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'elvale.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
