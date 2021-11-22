// 1차 참조 : 재즐보프 블로그 https://blog.naver.com/isc0304/221841891070
// 2차 참조 : https://flutter-ko.dev/docs/cookbook/persistence/sqlite

// 데이터베이스 파일을 열고 CRUD하는 기능을 구현
// Create(생성), Read(읽기), Update(갱신), Delete(삭제)
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:clone_noteapp/database/memo.dart';

// tabel 이름은 memos로 구현
final String TableName = 'memos';

class DBHelper{
  var _db;
  // var 변수 선언 - 중복 선언 가능

  // Future : 지금은 없지만 미래에 요청한 데이터를 받을 수 있음용
  // 따로 수행할 수 있는 상자가 주어짐
  // async : 비동기식 처리짐
  // 본 수행을 요청 후 응답을 기다리지 않고 다음 절차로 넘어감
  // https://velog.io/@jintak0401/FlutterDart-에서의-Future-asyncawait

  // 미래에 Database 형태의 자료가 반환될 것
  // 'Database'를 요청할 때마다 '_db'로 돌려줌
  Future<Database> get database async {
    // _db가 비어있다면 그대로 return
    if ( _db != null ) return _db;
    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다.
      // 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      // getDatabasesPath()가 실행될 때까지 기다림

      // await : 결과가 돌아올 때까지 기다림, then의 역할을 대신
      // await과 then의 차이
      // https://velog.io/@juni416/Future-then-vs-await-async-비교-및-쓰는-법
      join(await getDatabasesPath(), 'memos.db'),
      // 데이터베이스가 처음 생성될 때, memo를 저장하기 위한 테이블을 생성
      onCreate: (db, version) {
        // 데이터베이스에 CREATE TABLE 수행
        return db.execute(
          "CREATE TABLE memos(id TEXT PRIMARY KEY, title TEXT, text TEXT, createTime TEXT, editTime TEXT)",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );
    return _db;
  }

  // Flutter Docs의 경우 메인 코드에 넣었지만
  // 재즐보프에서는 DBHelper class에 넣음
  Future<void> insertMemo(Memo memo) async {
    final db = await database;

    // Memo를 올바른 테이블에 추가하세요.
    // 동일한 memo가 두번 추가되는 경우를 처리하기 위해 `conflictAlgorithm`을 명시
    // 만약 동일한 memo가 여러번 추가되면, 이전 데이터를 갱신 (덮어씀)
    await db.insert(
      TableName,
      memo.toMap(),
      // 동일한 memo가 중복되는 것을 방지하기 위해 ConflictAlgorithm 사
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Memo>> memos() async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos');

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        createTime: maps[i]['createTime'],
        editTime: maps[i]['editTime'],
      );
    });
  }

  Future<void> updateMemo(Memo memo) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableName,
      memo.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteMemo(String id) async {
    final db = await database;

    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      TableName,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }

  Future<List<Memo>> findMemo(String id) async {
    final db = await database;

    // 모든 Memo를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('memos', where: 'id = ?', whereArgs: [id]);

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return Memo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        createTime: maps[i]['createTime'],
        editTime: maps[i]['editTime'],
      );
    });
  }
}

