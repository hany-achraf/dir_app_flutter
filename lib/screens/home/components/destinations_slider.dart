import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/models/destination_model.dart';
import 'package:plant_app/screens/destination/destination_screen.dart';
import '../../../constants.dart';

class DestinationsSlider extends StatelessWidget {
  final List<Destination> destinations = [];

  final dynamic destinationsJson;
  DestinationsSlider({@required this.destinationsJson});

  void setDestinations() {
    destinationsJson.forEach((i) {
      destinations.add(Destination.fromJson(i));
    });
  }

  Widget _destinationCards() {
    Row x = Row(children: []);
    destinations.forEach((destination) {
      x.children.add(
        DestinationCard(destination: destination),
      );
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    setDestinations();
    return _destinationCards();
  }
}

class DestinationCard extends StatelessWidget {
  final Destination destination;
  const DestinationCard({
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding,
      ),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DestinationScreen(destination: destination),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: '${url}/${destination.imgPath}',
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child:
                              CircularProgressIndicator(color: kPrimaryColor)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                        children: [
                          TextSpan(
                              text: "${destination.name}\n".toUpperCase(),
                              style: Theme.of(context).textTheme.button),
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
