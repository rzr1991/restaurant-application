import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurants/common/styles.dart';
import 'package:restaurants/data/model/restaurants_reviews.dart';
import 'package:restaurants/provider/restaurants_detail_provider.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({Key? key, required this.provider, required this.id})
      : super(key: key);
  final RestaurantDetailProvider provider;
  final String id;

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController();
    var _reviewController = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: const Text(
        "Add a review",
        style: Styles.detailSegment,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) return "Field cannot be empty";
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _reviewController,
              validator: (value) {
                if (value!.isEmpty) return "Field cannot be empty";
                return null;
              },
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Review',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: Colors.transparent,
                  textStyle: Theme.of(context).textTheme.subtitle1,
                ),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  CustomerReview review = CustomerReview(
                    id: id,
                    name: _nameController.text,
                    review: _reviewController.text,
                    date: '',
                  );
                  provider.postReview(review).then((value) {
                    Get.snackbar(
                      'Success',
                      'Review successfully added',
                      animationDuration: const Duration(milliseconds: 200),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    );
                    Navigator.pop(context);
                  });
                }
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.brown,
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              child: const Text("Add"),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ],
    );
  }
}
