import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? path;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/file.pdf');

    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      path = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: path != null
          ? PDFView(
              filePath: path!,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
