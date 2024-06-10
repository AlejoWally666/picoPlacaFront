import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';
import 'package:pico_placa/pages/home/widgets/dataTable/data_sources.dart';
import 'package:pico_placa/utils/constants.dart';
import 'package:pico_placa/utils/globals.dart';


// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

class DataTable2ScrollupDemo extends StatefulWidget {
  DataTable2ScrollupDemo({super.key, required this.contextHome});
  final BuildContext contextHome;

  @override
  DataTable2ScrollupDemoState createState() => DataTable2ScrollupDemoState();
}

class DataTable2ScrollupDemoState extends State<DataTable2ScrollupDemo> {
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late DessertDataSource _dessertDataSource;
  bool _initialized = false;
  final ScrollController _controller = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  List<CarModel> carList = [

  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Globals.listCars.forEach((value) {
        try{
          CarModel car = value;
          carList.add(car);
        }catch(e){

        }
      });
      _dessertDataSource = DessertDataSource(context,widget.contextHome);
      log("_buildBusinessList1 ${carList.length}");
      _initialized = true;
      _dessertDataSource.addListener(() {
        setState(() {});
      });
    }
  }

  void _sort<T>(
    Comparable<T> Function(CarModel d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dessertDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _dessertDataSource.dispose();
    _controller.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Stack(children: [
          Theme(
              // These makes scroll bars almost always visible. If horizontal scroll bar
              // is displayed then vertical migh be hidden as it will go out of viewport
              data: ThemeData(
                  scrollbarTheme: ScrollbarThemeData(
                      thumbVisibility: MaterialStateProperty.all(true),
                      thumbColor:
                          MaterialStateProperty.all<Color>(Colors.black))),
              child: DataTable2(
                  scrollController: _controller,
                  headingRowColor:  MaterialStateColor.resolveWith((states) => Colors.blueGrey.withOpacity(0.5)),
                  horizontalScrollController: _horizontalController,
                  columnSpacing: 0,
                  horizontalMargin: 12,
                  bottomMargin: 10,
                  minWidth: 600,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn2(
                      label: const Text('Modelo'),
                      size: ColumnSize.M,
                      onSort: (columnIndex, ascending) =>
                          _sort<String>((car) => car.model!, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: const Text('Placa'),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) =>
                          _sort<String>((car) => car.placa!, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: const Text('Chasis'),
                      size: ColumnSize.M,
                      onSort: (columnIndex, ascending) =>
                          _sort<String>((car) => car.placa!, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: const Text('Color'),
                      size: ColumnSize.S,
                      onSort: (columnIndex, ascending) =>
                          _sort<String>((car) => car.placa!, columnIndex, ascending),
                    ),
                    DataColumn2(
                      label: const Text(''),
                      size: ColumnSize.L,
                      numeric: true,
                    ),
                  ],
                  rows: List<DataRow>.generate(_dessertDataSource.rowCount,
                      (index) => _dessertDataSource.getRow(index)))),
          Positioned(
              bottom: 20,
              right: 0,
              child: _ScrollXYButton(_controller, '↑↑ arriba ↑↑')),
          Positioned(
              bottom: 60,
              right: 0,
              child: _ScrollXYButton(_horizontalController, '←← inicio ←←'))
        ]));
  }
}

class _ScrollXYButton extends StatefulWidget {
  const _ScrollXYButton(this.controller, this.title);

  final ScrollController controller;
  final String title;

  @override
  _ScrollXYButtonState createState() => _ScrollXYButtonState();
}

class _ScrollXYButtonState extends State<_ScrollXYButton> {
  bool _showScrollXY = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.pixels > 20 && !_showScrollXY) {
        setState(() {
          _showScrollXY = true;
        });
      } else if (widget.controller.position.pixels < 20 && _showScrollXY) {
        setState(() {
          _showScrollXY = false;
        });
      }
      // On GitHub there was a question on how to determine the event
      // of widget being scrolled to the bottom. Here's the sample
      // if (widget.controller.position.hasViewportDimension &&
      //     widget.controller.position.pixels >=
      //         widget.controller.position.maxScrollExtent - 0.01) {
      //   print('Scrolled to bottom');
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showScrollXY
        ? OutlinedButton(
            onPressed: () => widget.controller.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            child: Text(widget.title),
          )
        : const SizedBox();
  }
}
