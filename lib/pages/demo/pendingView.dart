import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [TextField()],
      ),
    );
  }

  void _showCopyMenu(String text) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: Text('复制'),
          value: 'copy',
        ),
      ],
    ).then((value) {
      if (value == 'copy') {
        // 处理复制逻辑
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已复制到剪贴板')),
        );
      }
    });
  }
}
