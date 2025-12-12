import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/event_card.dart';
import '../widgets/event_tile.dart';
import 'category_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when app starts
    Future.microtask(() {
      // Cek apakah widget masih aktif sebelum memanggil Provider
      if (!mounted) return;

      Provider.of<EventProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EventKu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            ),
          ),
        ],
      ),
      body: Consumer<EventProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hi, Student! 👋",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        ['Music', 'Sports', 'Arts', 'Film', 'Miscellaneous']
                            .map(
                              (cat) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ActionChip(
                                  label: Text(cat),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CategoryPage(category: cat),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Upcoming This Week
                const Text(
                  "Upcoming This Week",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.upcomingEvents.length,
                    itemBuilder: (ctx, index) =>
                        EventTile(event: provider.upcomingEvents[index]),
                  ),
                ),

                const SizedBox(height: 24),

                // Recommended
                const Text(
                  "Recommended Events",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.recommendedEvents.length,
                  itemBuilder: (ctx, index) =>
                      EventCard(event: provider.recommendedEvents[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
