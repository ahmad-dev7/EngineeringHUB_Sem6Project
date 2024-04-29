import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/components/ad_youtube_url.dart';
import 'package:myapp/components/add_file.dart';
import 'package:myapp/components/add_notes_button.dart';
import 'package:myapp/constants/k_my_text.dart';

class AddNoteRequest extends StatelessWidget {
  const AddNoteRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: KMyText(
          'You can help many students by providing BOOKS / NOTES PDF’s OR by providing YouTube videos / Playlists links which you refer for your studies.',
          size: 13,
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.8),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AddNotes(
                onTap: () => showBarModalBottomSheet(
                  context: context,
                  expand: false,
                  builder: (_) => const AddFile(),
                ),
                label: 'Add PDF',
                icon: FontAwesomeIcons.filePdf,
              ),
              const SizedBox(width: 20),
              AddNotes(
                onTap: () => showBarModalBottomSheet(
                  context: context,
                  expand: false,
                  builder: (_) => const AddYouTubeUrl(),
                ),
                label: 'Add Links',
                icon: FontAwesomeIcons.youtube,
              )
            ],
          ),
        ),
      ),
    );
  }
}
