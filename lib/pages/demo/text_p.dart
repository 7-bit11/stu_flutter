import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class TextPainterNew extends StatefulWidget {
  const TextPainterNew({super.key});

  @override
  State<TextPainterNew> createState() => _TextPainterNewState();
}

class _TextPainterNewState extends State<TextPainterNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: HollowTextPainter(),
            ),
            CustomPaint(
              painter: MyTextPainter(
                  text: "你豪啊！",
                  outlinePaintColor: Colors.blue,
                  // 默认文字样式
                  textStyle: const TextStyle(color: Colors.red, fontSize: 50)),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextPainter extends CustomPainter {
  String text;
  TextStyle textStyle;
  Color outlinePaintColor;
  MyTextPainter(
      {required this.text,
      required this.textStyle,
      this.outlinePaintColor = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    // 创建文字画笔
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);
    // 定位文字
    Offset textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    // 绘制文字轮廓
    Paint outlinePaint = Paint()
      ..color = outlinePaintColor
      ..style = PaintingStyle.stroke // 设置为描边模式
      ..strokeWidth = 10.0;

    textPainter.text = TextSpan(
        text: text,
        style: textStyle.copyWith(
          foreground: outlinePaint,
        ));
    textPainter.layout(); // 更新布局
    textPainter.paint(canvas, textOffset);

    // 绘制文字填充内容（在绘制完轮廓后，按照原始样式绘制文字填充部分）
    textPainter.text = TextSpan(text: text, style: textStyle);
    textPainter.layout();
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(MyTextPainter oldDelegate) {
    return text != oldDelegate.text || textStyle != oldDelegate.textStyle;
  }
}

class HollowTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 创建一个覆盖整个区域的黑色背景
    final paint = Paint()
      ..color = Colors.black
      ..blendMode = BlendMode.srcOver;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 使用文字擦除中间部分
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Hollow Text',
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.red, // 文字颜色无关紧要，因为会被擦除
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    // 布局文字
    textPainter.layout();

    // 计算文字位置，使其居中
    final offset = Offset(
      (size.width - textPainter.width) / 2, // 水平居中
      (size.height - textPainter.height) / 2, // 垂直居中
    );

    // 设置绘制模式为 `BlendMode.clear`，擦除中间文字区域
    final clearPaint = Paint()..blendMode = BlendMode.clear;
    textPainter.paint(canvas, offset);
    // canvas.drawPaint(clearPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
