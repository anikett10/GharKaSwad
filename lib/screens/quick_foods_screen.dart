import 'package:flutter/material.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';
import '../widgets/quick_screen_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuickFoodsScreen extends StatefulWidget {
  const QuickFoodsScreen({Key? key}) : super(key: key);

  @override
  State<QuickFoodsScreen> createState() => _QuickFoodsScreenState();
}

class _QuickFoodsScreenState extends State<QuickFoodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickScreenAppbar(),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('foods').get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show a loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<QueryDocumentSnapshot<Object?>> documents = snapshot.data!.docs;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) => FoodCard(
                          food: Food(
                            name: documents[index]['name'],
                            image: documents[index]['image'],
                            cal: documents[index]['calories'],
                            time: documents[index]['cookingTime'],
                            rate: documents[index]['rating'],
                            reviews: documents[index]['reviews'],
                            isLiked: documents[index]['isLiked'],
                          ),
                        ),
                        itemCount: documents.length,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
