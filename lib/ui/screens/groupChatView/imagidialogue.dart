import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class EmojiDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EmojiDialog({super.key, required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    final emojis = ['😀', '😂', '😍', '👍', '🔥', '🥳', '😢', '👏'];

    return AlertDialog(
      title: Text(request.title ?? 'Pick an Emoji'),
      content: Wrap(
        spacing: 10,
        children: emojis
            .map((emoji) => GestureDetector(
          onTap: () => completer(DialogResponse(confirmed: true, data: emoji)),
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ))
            .toList(),
      ),
    );
  }
}
