import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İzmir Tarihi 3D Modeller',
      debugShowCheckedModeBanner: false, // Debug banner'ı kaldırır
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ModelListScreen(),
    );
  }
}

// Model sınıfı - const constructor eklendi
class Model3D {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String modelUrl;

  const Model3D({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.modelUrl,
  });
}

// Model listesi
class ModelListScreen extends StatelessWidget {
  const ModelListScreen({super.key});

  // Model listesini tanımla
  final List<Model3D> models = const [
    Model3D(
      id: '8e08d58c032d4860b4bf0c412a88b0ec',
      title: 'Eski Smyrna',
      description: 'İzmir\'in tarihi kalıntılarından Eski Smyrna\'nın 3 boyutlu modeli. Arkeolojik kazılarda ortaya çıkarılan yapılar ve kent planı detaylı olarak modellenmiştir.',
      imageUrl: 'https://i.imgur.com/SgP9Flk.jpg', // Varsayılan bir görsel ekleyin
      modelUrl: 'https://sketchfab.com/models/8e08d58c032d4860b4bf0c412a88b0ec/embed',
    ),
    Model3D(
      id: '05a01756ec16414eac2e5d2e0997b490',
      title: 'Smyrna Antik Kent Tiyatrosu',
      description: 'İzmir\'in tarihi kalıntılarından Antik Kent Tiyatrosu\'nun 3 boyutlu modeli. Roma döneminden kalan bu görkemli yapı, dönemin mimari özelliklerini yansıtmaktadır.',
      imageUrl: 'https://i.imgur.com/nV1o3DB.jpg', // Varsayılan bir görsel ekleyin
      modelUrl: 'https://sketchfab.com/models/05a01756ec16414eac2e5d2e0997b490/embed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İzmir Tarihi 3D Modeller'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarihi Modeller',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'İzmir\'in tarihi yapılarının 3D modellerini keşfedin',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: models.length,
                itemBuilder: (context, index) {
                  final model = models[index];
                  return ModelCard(model: model);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model kartı widget'ı
class ModelCard extends StatelessWidget {
  final Model3D model;

  const ModelCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModelDetailScreen(model: model),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Model görseli
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    // NetworkImage kullanarak doğrudan internetten resim yükleme
                    image: NetworkImage(model.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
              ),
            ),
            // Model başlığı
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '3D Model',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model detay sayfası
class ModelDetailScreen extends StatelessWidget {
  final Model3D model;

  const ModelDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Model resmi
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  // NetworkImage kullanarak doğrudan internetten resim yükleme
                  image: NetworkImage(model.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Model başlığı
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Model açıklaması
            Text(
              model.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            // 3D Model görüntüleme butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModelViewerScreen(model: model),
                    ),
                  );
                },
                icon: const Icon(Icons.view_in_ar),
                label: const Text('3D Modeli Görüntüle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3D Model görüntüleme sayfası
class ModelViewerScreen extends StatefulWidget {
  final Model3D model;

  const ModelViewerScreen({super.key, required this.model});

  @override
  State<ModelViewerScreen> createState() => _ModelViewerScreenState();
}

class _ModelViewerScreenState extends State<ModelViewerScreen> {
  bool _isLoading = true;
  late WebViewController _controller;
  
  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }
  
  void _initializeWebView() {
    // Özel HTML içeriği oluştur
    final String htmlContent = '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            body {
              margin: 0;
              padding: 0;
              overflow: hidden;
              width: 100vw;
              height: 100vh;
              background-color: #f8f8f8;
            }
            .container {
              width: 100%;
              height: 100%;
              display: flex;
              flex-direction: column;
            }
            .model-container {
              flex: 1;
              width: 100%;
              height: 100%;
            }
            iframe {
              width: 100%;
              height: 100%;
              border: none;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="model-container">
              <iframe 
                title="${widget.model.title}" 
                frameborder="0" 
                allowfullscreen 
                mozallowfullscreen="true" 
                webkitallowfullscreen="true" 
                allow="autoplay; fullscreen; xr-spatial-tracking" 
                xr-spatial-tracking 
                execution-while-out-of-viewport 
                execution-while-not-rendered 
                web-share 
                src="${widget.model.modelUrl}?autospin=0&ui_infos=0&ui_controls=1&ui_stop=0&ui_watermark=0&ui_watermark_link=0">
              </iframe>
            </div>
          </div>
        </body>
      </html>
    ''';
    
    // WebViewController oluştur
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Sayfa yüklenmesi başladığında
          },
          onPageFinished: (String url) {
            // Sayfa yüklenmesi tamamlandığında
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // Hata durumunda
            print('WebView error: ${error.description}');
          },
        ),
      )
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: _controller),
          
          // Yükleme göstergesi
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      '${widget.model.title} yükleniyor...',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}