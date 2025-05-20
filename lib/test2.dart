import 'package:flutter/foundation.dart';
import 'package:lpinyin/lpinyin.dart';

void main() {
  print(PinyinHelper.getPinyin('你好', format: PinyinFormat.WITH_TONE_MARK));
  print(PinyinHelper.getPinyin('你好', format: PinyinFormat.WITH_TONE_NUMBER));
  print(PinyinHelper.getPinyin('你好', format: PinyinFormat.WITHOUT_TONE));
  final s1 = PinyinHelper.getPinyin(
    '你好',
    format: PinyinFormat.WITH_TONE_NUMBER,
  );

  final s2 = [
    "bing4",
    "bong1",
    "bong2",
    "bong3",
    "bong4",
    "bia",
    "bia1",
    "bia2",
    "bia3",
    "bia4",
    "bua",
    "bua1",
    "bua2",
    "bua3",
    "bua4",
    "buo",
    "buo1",
    "buo2",
    "buo3",
    "buai",
  ];
  for (var s in s2) {
    final ys = PinyinHelperX.splitPinyin(s);
    print(ys);
  }
}

extension PinyinHelperX on PinyinHelper {
  static String? convertToneNumberToMark(String pinyin) {
    //获取声母
    //获取韵母
    //获取声调
    //将声调替换为声调符号
    //返回结果
    return pinyin;
  }

  static const _xs = {
    'a': ['ā', 'á', 'ǎ', 'à', 'a'],
    'e': ['ē', 'é', 'ě', 'è', 'e'],
    'i': ['ī', 'í', 'ǐ', 'ì', 'i'],
    'o': ['ō', 'ó', 'ǒ', 'ò', 'o'],
    'u': ['ū', 'ú', 'ǔ', 'ù', 'u'],
    'ü': ['ǖ', 'ǘ', 'ǚ', 'ǜ', 'ü'],
  };
  static const _shenmu = {
    'b',
    'p',
    'm',
    'f',
    'd',
    't',
    'n',
    'l',
    'g',
    'k',
    'h',
    'j',
    'q',
    'x',
    'zh',
    'ch',
    'sh',
    'r',
    'z',
    'c',
    's',
    'y',
    'w',
  };
  static const _yunmu = {
    'a',
    'o',
    'e',
    'i',
    'u',
    'ü',
    'ai',
    'ei',
    'ui',
    'ao',
    'ou',
    'iu',
    'ie',
    'üe',
    'er',
    'an',
    'en',
    'in',
    'un',
    'ün',
    'ang',
    'eng',
    'ing',
    'ong',
  };
  static const _tones = {'1': 4, '2': 3, '3': 2, '4': 1};

  static List<String>? splitPinyin(String pinyin) {
    pinyin = pinyin.replaceFirst('v', 'ü');
    String x1 = '';
    String x2 = '';
    String x3 = '';
    if (pinyin.isEmpty) {
      return null;
    }
    if (_yunmu.contains(pinyin[0])) {
      final ys = _getYunmu(pinyin);
      if (ys == null) {
        return null;
      }
      x2 = ys[0];
      x3 = ys[1];
      return [x1, x2, x3];
    }
    if (_shenmu.contains(pinyin[0])) {
      String yun = '';
      if (pinyin[1] == 'h') {
        x1 = pinyin.substring(0, 2);
        yun = pinyin.substring(2);
      } else {
        x1 = pinyin[0];
        yun = pinyin.substring(1);
      }
      final ys = _getYunmu(yun);
      if (ys == null) {
        return [x1, x2, x3];
      }
      x2 = ys[0];
      x3 = ys[1];
      return [x1, x2, x3];
    }
    return null;
  }

  static List<String>? _getYunmu(String pinyin) {
    final tone = _tones[pinyin[pinyin.length - 1]];
    String x1 = '';
    String x2 = '';
    if (tone != null) {
      pinyin = pinyin.substring(0, pinyin.length - 1);
    }
    if (!_yunmu.contains(pinyin) && pinyin.length > 1) {
      if ((pinyin[0] == 'i' || pinyin[0] == 'u') &&
          (pinyin[1] == 'a' || pinyin[1] == 'o')) {
        x1 = pinyin[0];
        x2 = pinyin.substring(1);
      } else {
        x2 = pinyin;
      }
    }else{
      x2 = pinyin;
    }
    if (!_yunmu.contains(x2)) {
      return null;
    }
    if (tone != null) {
      x2 = _xs[x2[0]]![tone - 1] + x2.substring(1);
    }
    return [x1, x2];
  }
}
