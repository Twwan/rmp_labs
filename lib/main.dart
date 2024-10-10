import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Неборский Мирон Евгеньевич'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://www.osh.by/wp-content/uploads/2023/12/1041436899_0_206_2905_1840_1920x0_80_0_0_c7022893b761781d76fe592010d14bd2.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGmBfMXwJHZon6-ylzQHnJwOkBWx0I9CouYg&s',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGmBfMXwJHZon6-ylzQHnJwOkBWx0I9CouYg&s',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://pikuco.ru/upload/test_stable/4c9/4c9a3fe1f0c864ec5845c9589cfed559.webp',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://i.pinimg.com/736x/e3/d0/bd/e3d0bdda0b65d2af85a25c4e25e6b25e.jpg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://pikuco.ru/upload/test_stable/4c9/4c9a3fe1f0c864ec5845c9589cfed559.webp',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
