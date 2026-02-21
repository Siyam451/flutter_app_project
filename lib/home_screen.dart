import 'package:flutter/material.dart';
import 'webview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onToggleTheme, required this.themeMode});
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  final List<Map<String, String>> newspapers = const [
    {
      "name": "Prothom Alo",
      "url": "https://www.prothomalo.com",
      "logo": "https://www.prothomalo.com/favicon-32x32.png",
    },
    {
      "name": "BBC Bangla",
      "url": "https://www.bbc.com/bengali",
      "logo": "https://static.files.bbci.co.uk/ws/simorgh-assets/public/bengali/images/favicon.ico",
    },
    {
      "name": "Kaler Kantho",
      "url": "https://www.kalerkantho.com",
      "logo": "https://www.kalerkantho.com/assets/images/favicon.png",
    },
    {
      "name": "Jugantor",
      "url": "https://www.jugantor.com",
      "logo": "https://www.jugantor.com/favicon.ico",
    },
    {
      "name": "Daily Star",
      "url": "https://www.thedailystar.net",
      "logo": "https://www.thedailystar.net/sites/default/files/favicon.ico",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Newspaper App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: newspapers.length,
        itemBuilder: (context, index) {
          final paper = newspapers[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  paper["logo"]!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.newspaper, size: 40);
                  },
                ),
              ),
              title: Text(
                paper["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebviewScreen(
                      url: paper["url"]!,
                      title: paper["name"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
