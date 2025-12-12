import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/event_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  void _search() {
    if (_controller.text.isNotEmpty) {
      Provider.of<EventProvider>(context, listen: false).searchEvents(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search artists, venues...',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: _search)
        ],
      ),
      body: Consumer<EventProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchedEvents.isEmpty && _controller.text.isNotEmpty) {
            return const Center(child: Text("No results found."));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.searchedEvents.length,
            itemBuilder: (ctx, index) => EventCard(event: provider.searchedEvents[index]),
          );
        },
      ),
    );
  }
}