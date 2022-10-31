import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SchedulingProvider>(context).getDataScheduling();

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          _buildSwitchSceduling(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defaultMargin,
        top: defaultMargin,
        bottom: 12,
      ),
      child: Text(
        'Setting',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSwitchSceduling(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(
          'Scheduling Restaurant',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, scheduled, _) {
            return Switch.adaptive(
              value: scheduled.isScheduled!,
              onChanged: (value) async {
                if (Platform.isIOS) {
                  customDialog(context);
                } else {
                  scheduled.scheduledRestaurants(value);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
