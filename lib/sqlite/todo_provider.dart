import 'package:sqflite/sqflite.dart';
import 'todo.dart';

/**
   * sql基本语句 https://github.com/tekartik/sqflite/blob/master/sqflite/doc/sql.md
   * 创建表
   * await db.execute('CREATE TABLE my_table (id INTEGER PRIMARY KEY AUTO INCREMENT, name TEXT, type TEXT)');
   * 
   * insert用于将数据插入到表中。它返回记录的内部id(一个整数)。
   * int recordId = await db.insert('my_table', {'name': 'my_name', 'type': 'my_type'});
   * 
   * 查询用于读取表内容。它返回一个映射列表。
   * var list = await db.query('my_table', columns: ['name', 'type']);
   * 
   * delete用于删除表中的内容。它返回被删除的行数。
   * var count = await db.delete('my_table', where: 'name = ?', whereArgs: ['cat']);
   * 
   * update用于更新表中的内容。它返回更新的行数。
   * var count = await db.update('my_table', {'name': 'new cat name'}, where: 'name = ?', whereArgs: ['cat']);
   * 
   * 事务处理“全有或全无”场景。如果一个命令失败，所有其他命令将被恢复。
   * await db.transaction((txn) async {
  await db.insert('my_table', {'name': 'my_name'});
  await db.delete('my_table', where: 'name = ?', whereArgs: ['cat']);
});
   * 
   * 在提供原始SQL语句时，不应该尝试“清理”任何值。相反，您应该使用标准的SQLite绑定语法:
   * 
   * // good
int recordId = await db.rawInsert('INSERT INTO my_table(name, year) VALUES (?, ?)', ['my_name', 2019]);
   * 
   * // bad
int recordId = await db.rawInsert("INSERT INTO my_table(name, year) VALUES ('my_name', 2019)");
   * 
   * 
   * 特别是，不支持列表(除了blob内容之外)。一个常见的错误是期望使用IN(?)并给出一个值列表。这行不通。相反，你应该一个一个地列出每个参数:
   * var list = await db.rawQuery('SELECT * FROM my_table WHERE name IN (?, ?, ?)', ['cat', 'dog', 'fish']);
   * 
   * NULL是一个特殊值。在查询中测试空值时，不应该使用“WHERE my_col = ?”，而是使用“WHERE my_col IS null”。
   * var list = await db.query('my_table', columns: ['name'], where: 'type IS NULL');
   * 
   */
class TodoProvider {
  Database db;

  ///打开数据库
  ///[path]按给定路径打开数据库
  ///[version]指定数据库的模式版本,这是用来决定是否调用[onCreate]， [onUpgrade]，和[onDowngrade]
  ///[onConfigure]是打开数据库时调用的第一个回调。它允许您执行数据库初始化，例如启用外键,或写前日志
  ///如果指定了[version],[onCreate],[onUpgrade]和[onDowngrade] 可以调用， 这些函数是互斥的；它们中只有
  ///一个可以互斥根据上下文调用，尽管可以将他们都指定为覆盖多个场景
  ///[onCreate] 如果在调用之前数据库不存在着调用[onCreate]
  /// [onUpgrade]在满足以下条件时调用:
  ///1:没有指定[onCreate]
  ///2:数据库已经存在，并且[版本]比上一个版本高
  ///在第一个没有指定[onCreate]的情况下，调用[onUpgrade]
  ///其[oldVersion]参数为' 0 '。在第二种情况下，您可以执行
  ///处理不同模式的必要迁移过程
  /// [onDowngrade]只在[version]低于最后一个数据库时调用
  ///的版本。这是一种罕见的情况，只有更新版本的
  ///您的代码创建了一个数据库，然后由老年人与之交互
  ///你的代码版本。你应该尽量避免这种情况
  ///[onOpen]是最后一个要调用的可选回调。它被称为
  ///数据库版本已经设置好，在[openDatabase]返回之前
  ///当[readOnly](默认为false)为真时，其他所有参数都为真
  ///忽略，数据库按原样打开
  ///如果[singleInstance]为真(默认值)，则单个数据库实例为真
  ///返回给定路径。的后续调用[openDatabase]
  ///相同的路径将返回相同的实例，并将丢弃所有其他的实例
  ///参数，如该调用的回调。
  Future open(String path) async {
    db = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        await db.execute('''
         create table $tableTodo (
           $columnId integer primary key autoincrement,
           $columnTitle text not null,
           $columnDone integer not null)
         ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        //dosth for migration（迁移）
        print('数据库版本更新 db当前数据库，oldVersion是用户手机的版本 newVersion是新版本');
        print('old:$oldVersion new:$newVersion');
        switch (oldVersion) {
          case 1:
            db.execute('alter table todo add age integer');
            break;
          default:
        }
      },
      version: 2,
    );
  }

  ///插入数据    ConflictAlgorithm插入冲突策略 replace后着替换前者
  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return todo;
  }

  // 查找所有书籍信息
  Future<List<Todo>> queryAll() async {
    List<Map> maps = await db.query(tableTodo, columns: [
      columnId,
      columnTitle,
      columnDone,
    ]);
    print('maps:->$maps');
    if (maps == null || maps.length == 0) {
      return null;
    }

    List<Todo> todos = [];
    for (int i = 0; i < maps.length; i++) {
      todos.add(Todo.fromMap(maps[i]));
    }
    return todos;
  }

  ///通过id获取某条指定的数据
  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  //删除指定id数据
  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

//通过数据id修改数据
  Future<int> updata(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

//记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
  }
}
