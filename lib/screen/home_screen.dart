import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/get_all_story_provider.dart';
import 'package:story_app/widget/card_list_story_widget.dart';
import 'package:story_app/widget/message_data.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onSetting;
  final Function() onUploadStory;
  final Function() onMaps;

  const HomeScreen({
    super.key,
    required this.onTapped,
    required this.onSetting,
    required this.onUploadStory,
    required this.onMaps,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  Future<void> _refreshData(BuildContext context) async {
    final currentToken = context.read<AuthProvider>().token;
    final getAllStoryProvider = context.read<GetAllStoryProvider>();

    getAllStoryProvider.allStories.clear();
    getAllStoryProvider.pageItems = 1;

    await getAllStoryProvider.getAllStory(currentToken!);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });

    final currentToken = context.read<AuthProvider>().token;
    final getAllStory = context.read<GetAllStoryProvider>();

    if (currentToken != null) {
      getAllStory.getAllStory(currentToken);
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (!getAllStory.isLoading && getAllStory.pageItems != null) {
          getAllStory.getAllStory(currentToken!);
        }
      }
    });
  }

  Future<void> _loadInitialData() async {
    final authProvider = context.read<AuthProvider>();
    final getAllStoryProvider = context.read<GetAllStoryProvider>();
    final token = authProvider.token;
    if (token != null) {
      await getAllStoryProvider.loadInitialStories(token);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(AppLocalizations.of(context)!.homeScreenTitle),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSetting();
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              widget.onMaps();
            },
            icon: const Icon(Icons.map_sharp),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<GetAllStoryProvider>(
              builder: (context, state, _) {
                if (state.isLoading && state.allStories.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: secondaryColor),
                  );
                } else if (state.hasData || state.allStories.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount:
                          state.allStories.length + (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.allStories.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        var listStory = state.allStories[index];
                        return CardListStoryWidget(
                          listStory: listStory,
                          onTapped: widget.onTapped,
                        );
                      },
                    ),
                  );
                } else if (state.hasError) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width,
                          child: Center(
                            child: MessageData(
                              image: "assets/no_internet.png",
                              message: AppLocalizations.of(context)!
                                  .errorInternetMessage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width,
                          child: Center(
                            child: MessageData(
                              image: "assets/no_data.png",
                              message: AppLocalizations.of(context)!
                                  .errorDataEmptyMessage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onUploadStory();
        },
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add, color: primaryColor),
      ),
    );
  }
}
