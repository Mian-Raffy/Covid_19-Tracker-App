// ignore_for_file: sort_child_properties_last

import 'package:covid_tracker/Services/Utilities/state_service.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountrieList extends StatefulWidget {
  const CountrieList({Key? key}) : super(key: key);

  @override
  State<CountrieList> createState() => _CountrieListState();
}

class _CountrieListState extends State<CountrieList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search Your Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateServices.getCountryRecord(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      // Use data from snapshot.data to build your list items
                      return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 8,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 8,
                                  width: 90,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade700);
                    },
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'];
                    // Use data from snapshot.data to build your list items
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      death: snapshot.data![index]['deaths'],
                                      name: snapshot.data![index]['country'],
                                      active: snapshot.data![index]['active'],
                                      casesPerOneMillion: snapshot.data![index]
                                          ['casesPerOneMillion'],
                                      cases: snapshot.data![index]['cases'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      todayCases: snapshot.data![index]
                                          ['todayCases'],
                                    ),
                                  ));
                            }),
                            child: ListTile(
                              leading: Image(
                                  height: 30,
                                  width: 30,
                                  image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']
                                      .toString())),
                              title: Text(snapshot.data![index]['country']),
                              // Add more ListTile properties based on your data
                            ),
                          ),
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      death: snapshot.data![index]['deaths'],
                                      name: snapshot.data![index]['country'],
                                      active: snapshot.data![index]['active'],
                                      casesPerOneMillion: snapshot.data![index]
                                          ['casesPerOneMillion'],
                                      cases: snapshot.data![index]['cases'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      todayCases: snapshot.data![index]
                                          ['todayCases'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              leading: Image(
                                  height: 30,
                                  width: 30,
                                  image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']
                                      .toString())),
                              title: Text(snapshot.data![index]['country']),
                              // Add more ListTile properties based on your data
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
