import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:myapp/constants/k_my_text.dart';

class NotesPDFViewer extends StatelessWidget {
  const NotesPDFViewer({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () => Get.back(),
        ),
        title: Text(title),
      ),
      body: const PDF().fromUrl(
        kIsWeb ? 'https://cors-anywhere.herokuapp.com/$url' : url,
        placeholder: (double progress) => Center(
          child: Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: LiquidCircularProgressIndicator(
                value: progress / 100,
                borderColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.background,
                borderWidth: 2,
                direction: Axis.vertical,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).colorScheme.onPrimary,
                ),
                center: KMyText('Loading... $progress'),
              ),
            ),
          ),
        ),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
