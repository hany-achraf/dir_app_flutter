import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/delegates/custom_search_delegate.dart';
import 'package:plant_app/providers/destinations_provider.dart';
import 'package:plant_app/screens/destinations/components/body.dart';
import 'package:provider/provider.dart';

class DestinationsScreen extends StatefulWidget {
  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  @override
  void initState() {
    Provider.of<DestinationsProvider>(context, listen: false)
        .loadInitialDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
          size: 30.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: kPrimaryColor,
              size: 30.0,
            ),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        )
      ],
    );
  }
}
