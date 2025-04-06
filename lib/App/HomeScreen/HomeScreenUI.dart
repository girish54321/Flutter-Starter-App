import 'package:flutter/material.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/model/userListModal.dart';
import 'package:reqres_app/network/remote_data_source.dart';
import 'package:reqres_app/widget/loadingView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreenUI extends StatelessWidget {
  final Function userLogout;
  final RemoteDataSource remoteDataSource;
  final Function goToUserInfoScreen;
  final List<AppMenuItem> menu;
  final Function goToSettings;
  const HomeScreenUI(
      {Key? key,
      required this.userLogout,
      required this.remoteDataSource,
      required this.goToUserInfoScreen,
      required this.menu,
      required this.goToSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localData = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localData.home),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) {
              if (val == "logout") {
                userLogout();
                return;
              }
              if (val == "setting") {
                goToSettings();
                return;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                AppMenuItem(
                    "setting",
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(localData.settings),
                    )),
                AppMenuItem(
                    "logout",
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(localData.logout),
                    ))
              ].map((AppMenuItem choice) {
                return PopupMenuItem<String>(
                    value: choice.id, child: choice.widget);
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: remoteDataSource.userList(),
          builder: (BuildContext contex,
              AsyncSnapshot<LoadingState<UserListResponse?>> snapshot) {
            if (snapshot.data?.status == LoadingStatus.error) {
              return Center(
                child: Text(snapshot.data?.errorMessage ?? ""),
              );
            }
            if (snapshot.data?.status == LoadingStatus.success) {
              UserListResponse userListResponse = snapshot.data!.data!;
              return ListView.builder(
                itemCount: userListResponse.data!.length,
                itemBuilder: (context, index) {
                  UserListResponseData? userItem =
                      userListResponse.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 33.0,
                      backgroundImage: NetworkImage(userItem!.avatar as String),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text("${userItem.firstName!} ${userItem.lastName!}"),
                    subtitle: Text(userItem.email!),
                    onTap: () {
                      goToUserInfoScreen(userItem);
                    },
                  );
                },
              );
            }
            return const LoadingView();
          }),
    );
  }
}
