import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key key}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int rating = -1;

  Widget Star(int index) {
    return InkWell(
      onTap: () {
        this.setState(() {
          rating = index;
        });
      },
      child: Icon(
        Icons.star,
        color: rating < index ? Colors.grey.shade300 : Colors.yellow,
        size: 60,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.purple,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          children: [
            Center(
              child: Text(
                'What is your rate?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++) Star(i),
                ],
              ),
            ),
            Center(
              child: Text(
                'Please share your comme about the place',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(8),
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  minLines: 3,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    hintText: 'Write your comment',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Submit review',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}