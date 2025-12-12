import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/event_card.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // 1. Cek apakah widget masih "hidup" (mounted)
      if (!mounted) return;

      // 2. Baru jalankan Provider
      Provider.of<EventProvider>(
        context,
        listen: false,
      ).fetchByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.category} Events")),
      body: Consumer<EventProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.categoryEvents.isEmpty) {
            return const Center(
              child: Text("No events found in this category."),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.categoryEvents.length,
            itemBuilder: (ctx, index) =>
                EventCard(event: provider.categoryEvents[index]),
          );
        },
      ),
    );
  }
}
