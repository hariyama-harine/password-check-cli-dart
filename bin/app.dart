import 'package:prompts/prompts.dart' as prompts;

void main() {
  const _passwordLength = 6;
  final _password = prompts.get('パスワードを設定してください', conceal: true);

  final _canStartAnalysis = prompts.getBool('設定したパスワードの解析を始めますか?');

  if (!_canStartAnalysis) {
    print('解析をキャンセルします。');
    return;
  }

  final _startTime = DateTime.now().millisecondsSinceEpoch;
  print('解析中...!');

  const _characters = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ];
  String _foundPassword;

  List<String> _make(List<String> listA, List<String> listB) {
    final _indexMax = listA.length * listB.length;
    List<String> _wordList = []..length = _indexMax;

    int _count = 0;
    for (int i = 0; i < listA.length; i++) {
      if (_foundPassword != null) {
        break;
      }

      for (int j = 0; j < listB.length; j++) {
        if (_foundPassword != null) {
          break;
        }

        final _currentInput = listA[i] + listB[j];
        if (_currentInput.length == _passwordLength) {
          print('解析中… $_currentInput');
        }

        if (_password == _currentInput) {
          _foundPassword = _currentInput;
        } else {
          _wordList[_count] = _currentInput;
          _count++;
        }
      }
    }

    return _wordList;
  }


  void _check(List<String> list, int repeat) {
    var _res = list;
    for (var i = 1; i < repeat; i++) {
      if (_foundPassword == null) {
        _res = _make(_res, list);
      }
    }
  }

  _check(_characters, _passwordLength);
  if (_foundPassword == null) {
    print('パスワードの解析に失敗しました');
    return;
  }

  final _endedTime = DateTime.now().millisecondsSinceEpoch;
  final _duration = (_endedTime - _startTime) * 0.001;
  final _seconds = (_duration % 60).toStringAsFixed(2);
  final _minutes = (_duration / 60).floor();

  print('発見しました！');
  print('入力されたパスワード: $_foundPassword');
  print('かかった時間: $_minutes分$_seconds秒');
}