import 'package:app_feedback/app_feedback.dart';
import 'package:flutter/material.dart';

AppFeedback appfeedback() {
  AppFeedback appFeedback = AppFeedback.instance;
  return appFeedback;
}

void initfeedback() {
  appfeedback().init(FeedbackConfig(duration: Duration(seconds: 84600)));
}

void trydisplay(context) {
  appfeedback().tryDisplay(context, onSubmit: (UserFeedback feedback) {
    print(feedback);
  });
}
