// 1차 참조 : 재즐보프 블로그 https://blog.naver.com/isc0304/221841891070
// 2차 참조 : https://flutter-ko.dev/docs/cookbook/persistence/sqlite

// 데이터 베이스의 table에 저장될 정보
// Memo 클래스에 'toMap' 메소드 추가
class Memo{
  // 변수 선언
  // final 변수 선언 관련 문서
  // https://advenoh.tistory.com/13
  // final과 static final 차이
  // https://blog.naver.com/goddlaek/220889229659

  // 원소 타입으로 final이 사용되어 각 변수는 상수가 된다.
  final int id; // 번호
  final String title; // 제목
  final String text; // 문서
  final String createTime; // 생성 시간
  final String editTime; // 편집 시간

  Memo({this.id, this.title, this.text, this.createTime, this.editTime});

  // Memo(객체)를 Map(Json 스트)으로 변환
  // key는 데이터베이스의 컬럼 명과 동일해야 함
  // Map자료형인 json 데이터는 <키, 값>으로 구분되어있으며
  // key는 반드시 String, 값는 자료형이 정해져있지 않아 dynamic으로 선언
  // https://bebesoft.tistory.com/11
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'createTime': createTime,
      'editTime': editTime,
    };
  }

  // 각 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현
  @override
  String toString() {
    return 'Map{id: $id, title: $title, text: $text, createTime: $createTime, editTime: $editTime}';
  }
}