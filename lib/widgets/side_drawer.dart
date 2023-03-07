import 'package:aquila_news_app/contollers/news_controller.dart';
import 'package:aquila_news_app/utils/utils.dart';
import 'package:aquila_news_app/widgets/dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer sideDrawer(NewsController newsController) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        Builder(
          builder: (context) {
            return Column(
              children: [
                DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 87, 0, 29)),
                    accountName: const Text(
                      "Jacmwas",
                      style: TextStyle(fontSize: 18),
                    ),
                    accountEmail: const Text(
                      "mwasjac@gmail.com",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    currentAccountPictureSize: const Size.square(50),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Text(
                        "M",
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                newsController.cName.isNotEmpty
                    ? Text(
                        "Country: ${newsController.cName.value.toUpperCase()}",
                        style: const TextStyle(fontSize: 18),
                      )
                    : const SizedBox.shrink(),
                newsController.category.isNotEmpty
                    ? Text(
                        "Category: ${newsController.category.value.capitalizeFirst}",
                        style: const TextStyle(fontSize: 18),
                      )
                    : const SizedBox.shrink(),
                newsController.channel.isNotEmpty
                    ? Text(
                        "Channel: ${newsController.channel.value.capitalizeFirst}",
                        style: const TextStyle(fontSize: 18),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),

        /// For Selecting the Country
        ExpansionTile(
          title: const Text("Select Country"),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.country.value = listOfCountry[i]['code']!;
                  newsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  newsController.getAllNews();
                  newsController.getBreakingNews();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              ),
          ],
        ),

        /// For Selecting the Category
        ExpansionTile(
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          title: const Text("Select Channel"),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        const Divider(),
        ListTile(
            trailing: const Icon(
              Icons.done_sharp,
              size: 28,
            ),
            title: const Text(
              "Done",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => Get.back()),
        ListTile(
          title: const Text('Saved Articles'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Bookmarks'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('About'),
          onTap: () {},
        ),
      ],
    ),
  );
}
