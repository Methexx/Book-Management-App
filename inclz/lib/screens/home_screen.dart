import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inclz/services/book_services.dart'; // Ensure BookService is imported
import 'package:inclz/models/book_model.dart'; // Ensure Book model is imported

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookService bookService = BookService(); // Instantiate BookService

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Management App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: StreamBuilder<List<Book>>(
        stream: bookService.getBooks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snapshot.data!;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => bookService.deleteBook(book.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add Book Screen Navigation
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
