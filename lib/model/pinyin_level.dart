import 'data.dart';
sealed class PinyinLevel {
  List<String> get shengmuList;
  List<String> get yunmuList;
  int get level;
}

class PinyinLevel1 extends PinyinLevel {
  @override
  List<String> get shengmuList => [];

  @override
  List<String> get yunmuList => danYunmuList;

  @override
  int get level => 1;
}

class PinyinLevel2 extends PinyinLevel {
  @override
  List<String> get shengmuList => shengMuList;

  @override
  List<String> get yunmuList => [];

  @override
  int get level => 2;
}

class PinyinLevel3 extends PinyinLevel {
  @override
  List<String> get shengmuList => [];

  @override
  List<String> get yunmuList => [];

  @override
  int get level => 3;
}

class PinyinLevel4 extends PinyinLevel {
  @override
  List<String> get shengmuList => [];

  @override
  List<String> get yunmuList => fuYunmuList;

  @override
  int get level => 4;
}

class PinyinLevel5 extends PinyinLevel {
  @override
  List<String> get shengmuList => [];

  @override
  List<String> get yunmuList => qianBiYunmuList;
  
  @override
  int get level => 5;
}

class PinyinLevel6 extends PinyinLevel {
  @override
  List<String> get shengmuList => [];

  @override
  List<String> get yunmuList => houBiYunmuList;

  @override
  int get level => 6;
}


