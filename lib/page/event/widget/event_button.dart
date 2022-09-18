
import 'package:flutter/material.dart';

import '../event_controller.dart';

class EventButton extends StatelessWidget {
  const EventButton({
    Key? key,
    required this.mainPadding,
    required this.eventController,
    required this.screenSize,
    required this.eventId,
    required this.eventText,
  }) : super(key: key);

  final double mainPadding;
  final EventController eventController;
  final Size screenSize;
  final int eventId;
  final String eventText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mainPadding),
      child: ElevatedButton(
          onPressed: () => eventController.setEvent(eventId, eventText),
          child: SizedBox(
              width: double.infinity * 0.7,
              height: screenSize.height * 0.07,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(eventText)))),
    );
  }
}
