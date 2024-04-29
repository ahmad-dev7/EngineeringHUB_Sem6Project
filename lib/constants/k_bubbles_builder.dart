import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bubbleBuilder(
    {required BuildContext context,
    required Function() onChatbotTap,
    required Function() onAddFile,
    required Function() onAddUrl}) {
  return [
    Bubble(
      icon: FontAwesomeIcons.robot,
      iconColor: Colors.blue,
      title: 'Chat with Bot',
      titleStyle: TextStyle(color: Theme.of(context).colorScheme.background),
      bubbleColor: Theme.of(context).colorScheme.onSecondary,
      onPress: onChatbotTap,
    ),
    Bubble(
      icon: FontAwesomeIcons.fileArrowUp,
      iconColor: Theme.of(context).colorScheme.onPrimary,
      title: 'Add notes file',
      titleStyle: TextStyle(color: Theme.of(context).colorScheme.background),
      bubbleColor: Theme.of(context).colorScheme.onSecondary,
      onPress: onAddFile,
    ),
    Bubble(
      icon: FontAwesomeIcons.youtube,
      iconColor: Colors.red,
      title: 'Add video url',
      titleStyle: TextStyle(color: Theme.of(context).colorScheme.background),
      bubbleColor: Theme.of(context).colorScheme.onSecondary,
      onPress: onAddUrl,
    )
  ];
}
