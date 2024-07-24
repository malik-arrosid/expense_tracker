import 'package:expense_tracker/models/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();

  ExpenseDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const sql = '''
      CREATE TABLE $tableExpenses (
        ${ExpenseFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExpenseFields.amount} TEXT NOT NULL,
        ${ExpenseFields.paymentMethod} TEXT NOT NULL,
        ${ExpenseFields.category} TEXT NOT NULL,
        ${ExpenseFields.items} TEXT NOT NULL,
        ${ExpenseFields.time} TEXT NOT NULL
      )
    ''';

    await db.execute(sql);
  }

  Future<Expense> create(Expense expense) async {
    final db = await instance.database;
    final id = await db.insert(tableExpenses, expense.toJson());
    return expense.copy(id: id);
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await instance.database;
    final result = await db.query(tableExpenses);
    return result.map((json) => Expense.fromJson(json)).toList();
  }

  Future<Expense> getExpenseById(int id) async {
    final db = await instance.database;
    final result = await db
        .query(tableExpenses, where: '${ExpenseFields.id} = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Expense.fromJson(result.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> deleteExpenseById(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableExpenses,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateExpense(Expense expense) async {
    final db = await instance.database;
    return await db.update(
      tableExpenses,
      expense.toJson(),
      where: '${ExpenseFields.id} = ?',
      whereArgs: [expense.id],
    );
  }
}
