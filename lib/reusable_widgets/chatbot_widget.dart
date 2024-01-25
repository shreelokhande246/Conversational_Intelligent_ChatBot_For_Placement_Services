import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class chatbot_widget extends StatefulWidget {
  const chatbot_widget({super.key});

  @override
  State<chatbot_widget> createState() => _chatbot_widgetState();
}

class _chatbot_widgetState extends State<chatbot_widget> {
  var url =
      "https://bots.kore.ai/webclient/9697556eae334772b8ccbd3b79372f397f241bd63567487c8b756796b7087f1est0c";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(url),
              ),
            ),
          )
        ],
      ),
    );
  }
}
