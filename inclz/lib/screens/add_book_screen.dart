import 'package:flutter/material.dart';
import 'package:inclz/models/book_model.dart' as model;
import 'package:inclz/services/book_services.dart' as service;

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final service.BookService bookService = service.BookService();

  void saveBook() async {
    if (titleController.text.isEmpty || authorController.text.isEmpty) {
      if (!mounted) return;  // Ensure context is still valid
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter all fields")));
      return;
    }

    model.Book newBook = model.Book(
      id: '', // Firestore will generate ID
      title: titleController.text,
      author: authorController.text,
      description: descriptionController.text,
      dateAdded: DateTime.now(),
    );

    await bookService.addBook(newBook);
    if (!mounted) return;  // Ensure context is still valid
    Navigator.pop(context); // Go back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a Book")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: authorController, decoration: const InputDecoration(labelText: "Author")),
            TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveBook, child: const Text("Save Book")),
          ],
        ),
      ),
    );
  }
}
