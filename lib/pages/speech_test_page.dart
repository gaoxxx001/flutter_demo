import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SpeechTestPage extends StatefulWidget {
  const SpeechTestPage({super.key});

  @override
  State<SpeechTestPage> createState() => _SpeechTestPageState();
}

class _SpeechTestPageState extends State<SpeechTestPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _text = '点击麦克风按钮开始语音输入';
  bool _isSupported = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    if (kIsWeb) {
      setState(() {
        _text = 'Web 平台暂不支持语音输入功能';
        _isSupported = false;
      });
      return;
    }

    // 请求麦克风权限
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      try {
        _isSupported = await _speechToText.initialize(
          onStatus: (status) => print('Speech status: $status'),
          onError: (error) => print('Speech error: $error'),
        );
        if (!_isSupported) {
          setState(() {
            _text = '设备不支持语音识别功能';
          });
        }
      } catch (e) {
        setState(() {
          _text = '初始化语音识别失败: $e';
          _isSupported = false;
        });
      }
    } else {
      setState(() {
        _text = '未获得麦克风权限，请在设置中授予权限';
        _isSupported = false;
      });
    }
  }

  Future<void> _startListening() async {
    if (!_isListening && _isSupported) {
      try {
        setState(() {
          _isListening = true;
          _text = '正在聆听...';
        });
        await _speechToText.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
          localeId: 'zh_CN', // 设置为中文
        );
      } catch (e) {
        setState(() {
          _text = '启动语音识别失败: $e';
          _isListening = false;
        });
      }
    }
  }

  Future<void> _stopListening() async {
    if (_isListening) {
      try {
        await _speechToText.stop();
        setState(() {
          _isListening = false;
        });
      } catch (e) {
        setState(() {
          _text = '停止语音识别失败: $e';
          _isListening = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('语音输入测试'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _text,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (_isSupported)
              FloatingActionButton(
                onPressed: _isListening ? _stopListening : _startListening,
                child: Icon(_isListening ? Icons.mic_off : Icons.mic),
              ),
          ],
        ),
      ),
    );
  }
} 