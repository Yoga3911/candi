import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color(0xFF066163),
      ),
      body: ListView(
        children: [
          Hero(
            tag: title,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text(
              description,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
