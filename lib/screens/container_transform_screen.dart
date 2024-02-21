import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformScreen extends StatefulWidget {
  static String routeName = "containertrans";
  static String routeURL = "containertrans";
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Container Transform"),
          actions: [
            IconButton(onPressed: _toggleGrid, icon: const Icon(Icons.grid_4x4))
          ],
        ),
        body: _isGrid
            ? GridView.builder(
                itemCount: 13,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) => OpenContainer(
                  transitionDuration: const Duration(milliseconds: 400),
                  closedBuilder: (context, action) => Column(
                    children: [
                      Image.asset(
                        "assets/movies/${index + 1}.jpg",
                        width: 120,
                      ),
                      const Text("MovieName")
                    ],
                  ),
                  openBuilder: (context, action) =>
                      DetailScreen(imgIndex: index),
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => OpenContainer(
                      closedElevation: 0,
                      openElevation: 0,
                      transitionDuration: const Duration(milliseconds: 700),
                      openBuilder: (context, action) =>
                          DetailScreen(imgIndex: index),
                      closedBuilder: (context, action) => ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/movies/${index + 1}.jpg"))),
                        ),
                        title: const Text("MovieName"),
                        subtitle: const Text("2024.02.21"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: 13));
  }
}

class DetailScreen extends StatelessWidget {
  final int imgIndex;
  const DetailScreen({super.key, required this.imgIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset("assets/movies/${imgIndex + 1}.jpg"),
          const Text(
            "MovieName",
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
