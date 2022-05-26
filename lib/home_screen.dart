import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:chips_mini_app/providers/tag.dart';
import 'custom_chip.dart';
import 'tag_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late dynamic loadTagsData;

  @override
  void initState() {
    final tags = Provider.of<Tags>(context, listen: false);
    loadTagsData = tags.loadTagsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tags = Provider.of<Tags>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chips app'),
        actions: [
          IconButton(
            onPressed: () {
              tags.clearCache();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
        future: loadTagsData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: 140,
            child: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) =>
                  ChangeNotifierProvider<Tag>.value(
                value: tags.getTags[index],
                child: const CustomChip(),
              ),
              itemCount: tags.getTags.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const TagForm();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
