// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:pico_placa/pages/car/controllers/carController.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';
import 'package:pico_placa/pages/car/widgets/picoPlacaChecking.dart';
import 'package:pico_placa/pages/home/widgets/carForm.dart';
import 'package:pico_placa/utils/constants.dart';
import 'package:pico_placa/utils/globals.dart';
import 'package:pico_placa/widgets/awesomeDialogWidget.dart';
import 'package:pico_placa/widgets/custom_buttons.dart';
import 'package:pico_placa/widgets/textFormats.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

BuildContext? contextPagina;

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class DessertDataSource extends DataTableSource {
  final BuildContext contextHome;

  DessertDataSource.empty(
    this.context, this.contextHome, {
    required businessList
  }) {
    carItems = [];
  }

  DessertDataSource(this.context, this.contextHome,
      [sortedByPlaca = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false,]) {
    carItems = _cars;
    if (sortedByPlaca) {
      sort((car) => car.placa!, true);
    }
  }

  final BuildContext context;

  late List<CarModel> carItems;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(CarModel d) getField, bool ascending) {
    carItems.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow2 getRow(int index, [Color? color]) {
    contextPagina = context;
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= carItems.length) throw 'index > _desserts.length';
    final caritem = carItems[index];
    return DataRow2.byIndex(
      index: index,
      //selected: dessert.tag,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${caritem.model}')
          : null,
      onDoubleTap: hasRowTaps
          ? () =>
              _showSnackbar(context, 'Double Tapped on row ${caritem.model}')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(context, 'Long pressed on row ${caritem.model}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () =>
              _showSnackbar(context, 'Right clicked on row ${caritem.model}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) => _showSnackbar(
              context, 'Right button down on row ${caritem.model}')
          : null,
      specificRowHeight: hasRowHeightOverrides ? 100 : null,
      cells: [
        DataCell(Text("${caritem.model}")),
        DataCell(Card(child: Padding(
          padding: const EdgeInsets.only(left: 4.0,right: 4,top:2),
          child: Column(
            children: [
              Text('ECUADOR',style: TextStyle(height: 1,fontWeight: FontWeight.bold,fontSize: 10),),
              Text('${caritem.placa}',style: TextStyle(height: 2,fontWeight: FontWeight.bold),),
            ],
          ),
        )),
            onTap: () => _showSnackbar(context,
                'Tapped on a cell with "${caritem.placa}"', Colors.red)),
        DataCell(Text("${caritem.chasis}")),
        DataCell(SizedBox(
          width: 100,
          child: Image.asset(
            "assets/img/carIcon.png",
            color: hexToColor(caritem.color!),
          ),
        )),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit,color: AppColors.mainLightGreen,),
              onPressed: () {
                showCustomDialog(contextHome, "Actualizar datos del vehículo", CarForm(carModel:caritem,contextHome: contextHome,upListener: (){
                  carItems = _getCars();
                  notifyListeners();
                },),dismiss: false);

              },
            ),
            IconButton(
              icon: Icon(Icons.delete,color: AppColors.mainRed,),
              onPressed: () async {
               await  CarController.deleteCar(contextHome,caritem?.id??0);
              },
            ),
            CustomButton(
                backColor: AppColors.mainOrange,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: Text("Ver Pico y Placa"),
                ),
                onPressed: () {
                  showCustomDialog(context, "Validar Pico y Placa", CheckPicoPlaca(carModel:caritem!,contextHome: context,datetime:Globals.datetime),dismiss: true);
                  },
                loading: false)
          ],
        )),
      ],
    );
  }



  @override
  int get rowCount => carItems.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => throw UnimplementedError();
}

/// Async datasource for AsynPaginatedDataTabke2 example. Based on AsyncDataTableSource which
/// is an extension to Flutter's DataTableSource and aimed at solving
/// saync data fetching scenarious by paginated table (such as using Web API)
class DessertDataSourceAsync extends AsyncDataTableSource {
  DessertDataSourceAsync() {
    print('DessertDataSourceAsync created');
  }

  DessertDataSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  DessertDataSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;
  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final DesertsFakeWebService _repo = DesertsFakeWebService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    print('getRows($startIndex, $count)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var x = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => DesertsFakeWebServiceResponse(0, []))
        : await _repo.getData(startIndex, count, _sortColumn, _sortAscending);

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((CarModel carItem) {
          return DataRow(
            key: ValueKey<String>(carItem.model!),
            //selected: dessert.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<String>(carItem.model!), value);
              }
            },
            cells: [
              DataCell(Text("${carItem.model}")),
              DataCell(Text('${carItem.placa}'), onTap: () {}),
              DataCell(Text("${carItem.chasis}")),
              DataCell(Text("${carItem.color}")),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Acción para editar
                      // Puedes implementar aquí la lógica para editar el negocio
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Acción para eliminar
                      // Puedes implementar aquí la lógica para eliminar el negocio
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.video_camera_back_outlined),
                    onPressed: () {
                      // Acción para ver detalles
                      // Puedes implementar aquí la lógica para ver detalles del negocio
                    },
                  ),
                ],
              )),
            ],
          );
        }).toList());

    return r;
  }
}

class DesertsFakeWebServiceResponse {
  DesertsFakeWebServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<CarModel> data;
}

class DesertsFakeWebService {
  int Function(CarModel, CarModel)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      /* case 'id':
        return (CarModel d1, CarModel d2) => coef * d1.id!.compareTo(d2.id!);*/
      case 'model':
        return (CarModel d1, CarModel d2) =>
            coef * d1.model!.compareTo(d2.model!);
      case 'placa':
        return (CarModel d1, CarModel d2) =>
            coef * d1.placa!.compareTo(d2.placa!);
      case 'chasis':
        return (CarModel d1, CarModel d2) =>
            coef * d1.chasis!.compareTo(d2.chasis!);
    }

    return null;
  }

  Future<DesertsFakeWebServiceResponse> getData(
      int startingAt, int count, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 2650
                : startingAt < 20
                    ? 2000
                    : 400), () {
      var result = _cars;

      result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      return DesertsFakeWebServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;

List<CarModel> _cars = [..._getCars()];
List<CarModel> _getCars() {
  return List<CarModel>.from(Globals.listCars);
}

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
