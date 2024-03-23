// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:covid_tracker/View/world_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final int cases;
  final int todayCases;
  final int recovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final int death;
  var image;

  DetailScreen(
      {required this.active,
      required this.cases,
      required this.critical,
      required this.name,
      required this.recovered,
      required this.casesPerOneMillion,
      required this.death,
      required this.image,
      required this.todayCases});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .067,
                      ),
                      ReusablRow(
                          title: 'Today Cases',
                          value: widget.todayCases.toString()),
                      ReusablRow(
                          title: 'Total Cases', value: widget.cases.toString()),
                      ReusablRow(
                          title: 'Active', value: widget.active.toString()),
                      ReusablRow(
                          title: 'Recovered',
                          value: widget.recovered.toString()),
                      ReusablRow(
                          title: 'Critical Cases',
                          value: widget.critical.toString()),
                      ReusablRow(
                          title: ' Cases', value: widget.death.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
