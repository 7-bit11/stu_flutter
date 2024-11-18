// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:study_demo/widget/appbar.dart';
import 'package:async/async.dart' show AsyncMemoizer;

//name：zhangyu
//date：2023-7-21
//introduce：FutureBuilder-异步构建
class FutureBuilderPage extends StatefulWidget {
  const FutureBuilderPage({super.key});

  @override
  State<FutureBuilderPage> createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  Future<dynamic> initData() async {
    await Future.delayed(const Duration(seconds: 3), () {
      //throw "错误";
      return "assets/images/2.png";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<String>? get1() async {
    return _memoizer.runOnce(() async {
      print("+++++");
      await Future.delayed(const Duration(seconds: 2));
      return "assets/images/dao.jpg";
    });
  }

  final AsyncMemoizer<String> _memoizer = AsyncMemoizer();
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyAppBar.MyAppBar("FutureBuilder", context),
      floatingActionButton:
          FloatingActionButton(onPressed: () => setState(() {})),
      body: Center(
        child: FutureBuilder<String>(
          future: get1(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Image.asset(
                snapshot.data ?? "assets/images/dao.jpg",
                fit: BoxFit.cover,
              );
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            // }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
