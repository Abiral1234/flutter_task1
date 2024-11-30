import 'package:flutter/material.dart';

class ReviewSection extends StatefulWidget {
  const ReviewSection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReviewSectionState createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  int _selectedRating = 0; // Default rating is 0 (no stars selected)

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate this Product',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _selectedRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _selectedRating = index + 1; // Set rating based on index
                });
              },
            );
          }),
        ),
        const SizedBox(height: 10),
        Text(
          'Your Rating: $_selectedRating/5',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        // Optionally, show a review text field below the stars
        const TextField(
          decoration: InputDecoration(
            labelText: 'Write a Review',
            border: OutlineInputBorder(),
            hintText: 'Enter your review here...',
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}
