import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({Key? key, required this.pdfUrl}) : super(key: key);

  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pdf viewer'),
        ),
        body: PDFView(
          filePath: pdfUrl,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          pageSnap: true,
          defaultPage: 0,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (pages) {
          },
          onError: (error) {
          },
          onPageError: (page, error) {
          },
          onViewCreated: (PDFViewController pdfViewController) {
            // _controller.complete(pdfViewController);
          },
          onLinkHandler: (String? uri) {
          },
          onPageChanged: (int? page, int? total) {
          },
        ));
  }
}
