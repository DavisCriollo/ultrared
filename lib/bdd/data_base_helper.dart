import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'actas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE actas (
         actaId INTEGER PRIMARY KEY,
         actaIdCliente INTEGER,
         actaIdPersonaEntrega INTEGER,
         actaIdVendedor INTEGER,
         actaFecha TEXT,
         actaFechaInstalacion TEXT,
         actaOpcion TEXT,
         actaEstado TEXT,
         actaDetalleEstado TEXT,
         actaTipo TEXT,
         actaSeEncuentraCliente TEXT,
         actaServiciosVisita TEXT,
         actaRedWifi TEXT,
         actaClave TEXT,
         actaClienteRegulador TEXT,
         actaConfigRouter TEXT,
         actaValorRouter TEXT,
         actaCambioPatch TEXT,
         actaValorPatch TEXT,
         actaCalidadIns TEXT,
         actaSolucionReq TEXT,
         actaRecNombre TEXT,
         actaRecFirma TEXT,
         actaEntFirma TEXT,
         actaUser TEXT,
         correo_nuevo_registro TEXT,
         actaEmpresa TEXT,
         actaIdPlanInternet INTEGER,
         actaCiudad TEXT,
         actaFecReg TEXT,
         actaFecUpd TEXT,
         actaDocCliente TEXT,
         actaNombreCliente TEXT,
         actaDireccionCliente TEXT,
         actaEntDoc TEXT,
         actaEntNombre TEXT,
         actaDocVendedor TEXT,
         actaNombreVendedor TEXT,
         planNombreInternet TEXT,
         planValorInternet TEXT,
         planMegasInternet TEXT,
         actaFotos TEXT,
         actaUbicacion TEXT,
         actaEquiposInstalados TEXT,
         actaCargosAdicionales TEXT,
         actaTelCliente TEXT,
         actaEmailCliente TEXT,
         actaSector TEXT
       )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Realiza migraciones aquí si cambias el esquema
      await db.execute('ALTER TABLE actas ADD COLUMN actaEntDoc TEXT');
    }
  }

  // Listar todos los registros de la tabla 'actas'
  Future<List<Map<String, dynamic>>> getAllActas() async {
    final db = await database;
    return await db.query('actas');
  }

  // Actualizar un registro en la tabla 'actas'
  Future<int> updateActa(int actaId, String nuevoEstado) async {
    final db = await database;
    return await db.update(
      'actas',
      {'actaEstado': nuevoEstado},  // Campos a actualizar
      where: 'actaId = ?',  // Condición de búsqueda
      whereArgs: [actaId],  // Argumentos para la condición
    );
  }

  // Eliminar un registro de la tabla 'actas'
  Future<int> deleteActa(int actaId) async {
    final db = await database;
    return await db.delete(
      'actas',
      where: 'actaId = ?',
      whereArgs: [actaId],
    );
  }
}
