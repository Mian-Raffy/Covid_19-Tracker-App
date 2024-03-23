// ignore_for_file: must_be_immutable, prefer_const_constructors, unused_local_variable

import 'package:covid_tracker/Models/world_state_model.dart';
import 'package:covid_tracker/Services/Utilities/state_service.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({Key? key}) : super(key: key);

  @override
  State<WorldScreen> createState() => WorldScreenState();
}

class WorldScreenState extends State<WorldScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4284F4),
    Color(0xffeaf655),
    Color(0xffde5246),
    Color(0xff1aa160),
  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            FutureBuilder(
              future: stateServices.getWorldStateRecord(),
              builder: (context, AsyncSnapshot<WorldstateModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Active":
                              double.parse(snapshot.data!.active.toString()),
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Death":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.deaths.toString()),
                        },
                        animationDuration: Duration(seconds: 3),
                        colorList: colorList,
                        chartType: ChartType.ring,
                        chartRadius: 160,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                          legendShape: BoxShape.circle,
                        ),
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          child: Column(
                            children: [
                              ReusablRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReusablRow(
                                  title: 'Recover',
                                  value: snapshot.data!.cases.toString()),
                              ReusablRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReusablRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReusablRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReusablRow(
                                  title: 'Testes',
                                  value: snapshot.data!.tests.toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountrieList(),
                              ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            'Track Countries',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReusablRow extends StatelessWidget {
  String title, value;
  ReusablRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value)],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
      ]),
    );
  }
}
