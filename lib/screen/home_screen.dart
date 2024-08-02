import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/get_all_story_provider.dart';
import 'package:story_app/widget/card_list_story_widget.dart';
import 'package:story_app/widget/message_data.dart';

class HomeScreen extends StatelessWidget {
  final Function(String) onTapped;
  final Function() onSetting;
  final Function() onUploadStory;

  const HomeScreen(
      {super.key,
      required this.onTapped,
      required this.onSetting,
      required this.onUploadStory});

  Future<void> _refreshData(BuildContext context) async {
    final currentToken = context.read<AuthProvider>().token;
    await context.read<GetAllStoryProvider>().getAllStory(currentToken!);
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
              onSetting();
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<GetAllStoryProvider>(
              builder: (context, state, _) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: secondaryColor),
                  );
                } else if (state.hasData) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: ListView.builder(
                      itemCount:
                          state.getAllStoryResponse?.listStory.length ?? 0,
                      itemBuilder: (context, index) {
                        var listStory =
                            state.getAllStoryResponse?.listStory[index];
                        return CardListStoryWidget(
                          listStory: listStory!,
                          onTapped: onTapped,
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
          onUploadStory();
        },
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add, color: primaryColor),
      ),
    );
  }
}
