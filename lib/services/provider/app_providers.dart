import 'package:flutter/material.dart';
import 'package:project_vofaze/services/provider/ticket_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_vofaze/services/provider/radio_provider.dart';
import 'package:project_vofaze/services/provider/date_time_provider.dart';

MultiProvider getAppProviders(BuildContext context, Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RadioProvider()),
      ChangeNotifierProvider(create: (context) => DateTimeProvider()),
      ChangeNotifierProvider(create: (context) => TicketProvider()),
    ],
    child: child,
  );
}
