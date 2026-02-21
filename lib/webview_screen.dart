import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late InAppWebViewController? _controller;
   double _progress = 0; // for refresh
  late final PullToRefreshController _pullToRefreshController;
  late WebUri homeurl;


  Future<void> _goback() async {
    if (_controller == null || !mounted) return;

    final canGoBack = await _controller!.canGoBack();

    if (canGoBack) {
      await _controller!.goBack();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No previous screen')),
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeurl = WebUri(widget.url);
    _pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(enabled: true),
      onRefresh: ()async{
        if(_controller == null){
          //null hoile aikane taki jabe
          await _pullToRefreshController.endRefreshing();
          return;
        }
        if(await _controller!.getUrl() != null){
          await _controller!.reload();
        }else{
          await _controller!.loadUrl(urlRequest: URLRequest(url: homeurl));
        }
      }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(onPressed: _goback, icon:Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed:()=> _controller?.reload(), icon: Icon(Icons.refresh))
        ],

      ),
      body: Column(
        children: [
          if(_progress<1) LinearProgressIndicator(value: _progress,), //lite system progressbar
          Expanded(child: InAppWebView(
            initialUrlRequest: URLRequest(url: homeurl),
            initialSettings: InAppWebViewSettings(
              //airkm aro onk ase amra ja iccha korte pari settings
              javaScriptEnabled: true,
                allowFileAccess: true,
                mediaPlaybackRequiresUserGesture: true,
                supportZoom: true,
            ),
            onWebViewCreated: (controller) => _controller = controller,
            onProgressChanged: (controller,progress){
              setState(() {
                _progress = progress / 100; // for refresh progress
              });

    },
            onLoadStop: (controller,url){

            }
          ))
        ],
      ),
    );
  }
}
