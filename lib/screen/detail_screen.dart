import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/detail_story_provider.dart';
import 'package:story_app/widget/detail_story_widget.dart';
import 'package:story_app/widget/message_data.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  Future<void> _refreshData(BuildContext context) async {
    final currentToken = context.read<AuthProvider>().token;
    await context.read<DetailStoryProvider>().getDetailStory(id, currentToken!);
  }

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthProvider>().token;

    return ChangeNotifierProvider(
      create: (context) => DetailStoryProvider(
        apiService: ApiService(),
        id: id,
      )..getDetailStory(id, token ?? ""),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.detailScreenTitle),
          backgroundColor: primaryColor,
        ),
        body: Consumer<DetailStoryProvider>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              );
            } else if (state.hasData) {
              return RefreshIndicator(
                onRefresh: () => _refreshData(context),
                child: ListView(
                  children: [
                    DetailStoryWidget(
                        detailStory: state.getDetailStoryResponse!.story)
                  ],
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
    );
  }
}
