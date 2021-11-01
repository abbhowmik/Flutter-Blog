import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/widgets/widget.dart';

class DetailedBlogPage extends StatelessWidget {
  const DetailedBlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        elevation: 0,
        title: appBar(context),
      ),
    );
  }
}
