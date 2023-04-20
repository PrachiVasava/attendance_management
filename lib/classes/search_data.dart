import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class DataSearch extends SearchDelegate<String?> {
  List<String> cities = [
    'Ahmedabad',
    'Amreli district',
    'Anand',
    'Banaskantha',
    'Bharuch',
    'Bhavnagar',
    'Dahod',
    'The Dangs',
    'Gandhinagar',
    'Jamnagar',
    'Junagadh',
    'Kutch',
    'Kheda',
    'Mehsana',
    'Narmada',
    'Navsari',
    'Patan',
    'Panchmahal',
    'Porbandar',
    'Rajkot',
    'Sabarkantha',
    'Surendranagar',
    'Surat',
    'Vyara',
    'Vadodara',
    'Valsad',
  ];
  final recentCities = [
    'Ahmedabad',
    'Vadodara',
    'Surat',
    'Gandhinagar',
    'Rajkot',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on left side of appbar
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // show result based on selection
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.grey,
          child: Center(
              child: Text(
            query,
            style: TextStyle(color: AppColors.white),
          )),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show suggestions

    final suggestionList = query.toLowerCase().isEmpty
        ? recentCities
        : cities
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_on),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index],
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
