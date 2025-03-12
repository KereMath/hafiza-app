import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 3D Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ModelViewerScreen(),
    );
  }
}

class ModelViewerScreen extends StatelessWidget {
  const ModelViewerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 3D'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yalı Cami',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: Flutter3DViewer(
                  src: 'assets/3d/arli.glb',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
