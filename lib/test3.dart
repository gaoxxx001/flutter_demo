import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:animations/animations.dart';

class ListenAndPickQuestion {
  final String answer;
  final String audio;
  final List<String> options;

  const ListenAndPickQuestion({
    required this.answer,
    required this.audio,
    required this.options,
  });
}

class ListenAndPickController extends GetxController {
  final RxList<ListenAndPickQuestion> questions = <ListenAndPickQuestion>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxString selectedOption = ''.obs;
  final RxBool isPlaying = false.obs;
  final RxList<bool?> answerResults = <bool?>[].obs;

  final AudioPlayer _audioPlayer = AudioPlayer();

  ListenAndPickQuestion get currentQuestion => questions[currentIndex.value];

  void loadQuestions(List<ListenAndPickQuestion> data) {
    questions.assignAll(data);
    currentIndex.value = 0;
    selectedOption.value = '';
    answerResults.assignAll(List<bool?>.filled(data.length, null));
    if (questions.isNotEmpty) {
      playAudio(currentQuestion.audio);
    }
  }

  void selectOption(String option) {
    selectedOption.value = option;
    if (answerResults[currentIndex.value] == null) {
      answerResults[currentIndex.value] = option == currentQuestion.answer;
    }
  }

  bool get isAnswerCorrect =>
      selectedOption.value.isNotEmpty &&
      selectedOption.value == currentQuestion.answer;

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      selectedOption.value = '';
    }
  }

  void prevQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      selectedOption.value = '';
    }
  }

  Future<void> playAudio(String path) async {
    isPlaying.value = true;
    print('playAudio: $path');
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
    });
    ever(currentIndex, (idx) {
      print(idx);
      playAudio(currentQuestion.audio);
    });
    // 在这里加载题库
    loadQuestions([
      ListenAndPickQuestion(
        answer: 'nǐ hǎo',
        audio: 'audio/zhengti_rendu/yun2.mp3',
        options: ['nǐ hǎo', 'nǐ hào', 'ní hǎo', 'ní hào'],
      ),
      ListenAndPickQuestion(
        answer: 'zài jiàn',
        audio: 'audio/shengmu/ch.mp3',
        options: ['zài jiàn', 'zāi jiàn', 'zài jiān', 'zāi jiān'],
      ),
    ]);
  }

  @override
  void onReady() {
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

class AudioButton extends StatefulWidget {
  final RxBool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onStop;

  const AudioButton({
    super.key,
    required this.isPlaying,
    required this.onPlay,
    required this.onStop,
  });

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    widget.isPlaying.listen((playing) {
      if (playing) {
        animationController.repeat();
      } else {
        animationController.reset();
        animationController.stop();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isPlaying = widget.isPlaying.value;
      return TextButton(
        onPressed: isPlaying ? widget.onStop : widget.onPlay,
        child: SizedBox(
          width: 150,
          height: 96,
          child: SpinKitWave(
            color: Colors.blue,
            type: SpinKitWaveType.center,
            controller: animationController,
          ),
        ),
      );
    });
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    Color? backgroundColor;
    Color? foregroundColor = isSelected ? Colors.white : null;

    if (isAnswered && isSelected) {
      borderColor = isCorrect ? Colors.green : Colors.red;
      backgroundColor = (isCorrect ? Colors.green : Colors.red).withOpacity(0.2);
    } else if (isSelected) {
      backgroundColor = Colors.blue;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          minimumSize: const Size(120, 48),
          side: BorderSide(
            color: borderColor ?? Colors.grey,
            width: 2,
          ),
        ),
        onPressed: onTap,
        child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

class QuestionProgressBar extends StatelessWidget {
  final int total;
  final int currentIndex;
  final List<bool?> answerResults;

  const QuestionProgressBar({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.answerResults,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final isCurrent = currentIndex == i;
        final result = answerResults[i];
        Color borderColor = isCurrent ? Colors.blue : Colors.grey;
        Color fillColor = Colors.white;
        Widget? icon;
        if (result == true) {
          fillColor = Colors.green.withOpacity(0.2);
          icon = const Icon(Icons.check, color: Colors.green, size: 18);
        } else if (result == false) {
          fillColor = Colors.red.withOpacity(0.2);
          icon = const Icon(Icons.close, color: Colors.red, size: 18);
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: icon),
        );
      }),
    );
  }
}

class ListenAndPickPage extends StatelessWidget {
  ListenAndPickPage({super.key});

  final ListenAndPickController controller = Get.put(ListenAndPickController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('听音选拼音')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => QuestionProgressBar(
                total: controller.questions.length,
                currentIndex: controller.currentIndex.value,
                answerResults: controller.answerResults,
              )),
              const SizedBox(height: 24),
              AudioButton(
                isPlaying: controller.isPlaying,
                onPlay: () => controller.playAudio(controller.currentQuestion.audio),
                onStop: controller.stopAudio,
              ),
              const SizedBox(height: 24),
              Obx(() {
                final question = controller.currentQuestion;
                final options = question.options;
                final selected = controller.selectedOption.value;
                final isCorrect = controller.isAnswerCorrect;
                final isAnswered = selected.isNotEmpty;

                return PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 400),
                  reverse: false,
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child,
                    );
                  },
                  child: Column(
                    key: ValueKey(controller.currentIndex.value),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (i) {
                          final option = options[i];
                          return OptionButton(
                            text: option,
                            isSelected: selected == option,
                            isAnswered: isAnswered,
                            isCorrect: isCorrect,
                            onTap: () => controller.selectOption(option),
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (i) {
                          final option = options[i + 2];
                          return OptionButton(
                            text: option,
                            isSelected: selected == option,
                            isAnswered: isAnswered,
                            isCorrect: isCorrect,
                            onTap: () => controller.selectOption(option),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              Obx(() {
                final canPrev = controller.currentIndex.value > 0;
                final canNext = controller.currentIndex.value < controller.questions.length - 1;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 32),
                      tooltip: '前一题',
                      onPressed: canPrev ? controller.prevQuestion : null,
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward, size: 32),
                      tooltip: '下一题',
                      onPressed: canNext ? controller.nextQuestion : null,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '听音选拼音 Demo', home: ListenAndPickPage());
  }
}
