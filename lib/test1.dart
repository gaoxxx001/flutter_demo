
import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.outlined(
              onPressed: () => print('语音按钮被点击'), 
              icon: const Icon(Icons.mic,size: 150,),
              tooltip: '语音输入',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text('Test2'),
                Text('Test3'),
                Text('Test4'),
                Text('Test5'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
