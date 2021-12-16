import 'package:flutter/material.dart';
import 'package:plant_app/models/destination_model.dart';
import 'package:plant_app/screens/destination/destination_screen.dart';
import '../../../constants.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({this.destination});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        // top: kDefaultPadding / 2,
        bottom: kDefaultPadding,
      ),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DestinationScreen(destinationId: destination.id),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  destination.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 5,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                          text: "${destination.name}\n".toUpperCase(),
                          style: Theme.of(context).textTheme.button),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}