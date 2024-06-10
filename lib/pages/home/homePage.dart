import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';
import 'package:pico_placa/pages/home/cubit/homePageCubit.dart';
import 'package:pico_placa/pages/home/widgets/carForm.dart';
import 'package:pico_placa/pages/home/widgets/dataTable/data_table2_scrollup.dart';
import 'package:pico_placa/pages/home/widgets/homeAppBar.dart';
import 'package:pico_placa/utils/constants.dart';
import 'package:pico_placa/utils/globals.dart';
import 'package:pico_placa/widgets/awesomeDialogWidget.dart';
import 'package:pico_placa/widgets/custom_buttons.dart';
import 'package:pico_placa/widgets/custom_toast.dart';
import 'package:pico_placa/widgets/textFormats.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  bool _inited = false;
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  DateTime dateTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  List<CarModel> listCars=[];

  _setTime(Time _time, BuildContext context) {
    DateTime dateTimeAux = DateTime(dateTime.year, dateTime.month, dateTime.day,
        _time.hour, _time.minute, _time.second);
    if (dateTimeAux.isAfter(DateTime.now())) {
      dateTime = dateTimeAux;
      Globals.datetime=dateTime;
      context.read<HomePageCubit>().changeDateTime(dateTime);
    } else {
      customErrorToast(
          context,
          "La fecha y hora no pueden ser menores a la fecha y hora actual",
          3000);
    }
  }

  _setDate(DateTime _date, BuildContext context) {
    DateTime dateTimeAux = DateTime(_date.year, _date.month, _date.day,
        dateTime.hour, dateTime.minute, dateTime.second);
    print("dateTime::$dateTimeAux");
    print("DateTime.now()::${DateTime.now()}");
    if (dateTimeAux.isAfter(DateTime.now())) {
      dateTime = dateTimeAux;
      Globals.datetime=dateTime;
      context.read<HomePageCubit>().changeDateTime(dateTime);
    } else {
      customErrorToast(
          context,
          "La fecha y hora no pueden ser menores a la fecha y hora actual",
          3000);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: const Locale('es', 'ES'), // Establece el idioma a español
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _setDate(_selectedDate, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: homeAppBar(context),
        body: BlocProvider(
            create: (context) => HomePageCubit(),
            child: BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
              if (!_inited) {
                _inited = true;

                _time = Time(
                    hour: DateTime.now().add(Duration(minutes: 1)).hour,
                    minute: DateTime.now().add(Duration(minutes: 1)).minute,
                    second: DateTime.now().add(Duration(minutes: 1)).second);
                //_setTime(_time,context);
                Globals.listCars=[];
                context.read<HomePageCubit>().loadCarList(context);
              }
              _time = Time(
                  hour: state.dateTimeSelected.hour,
                  minute: state.dateTimeSelected.minute,
                  second: state.dateTimeSelected.second);
              listCars=state.listCars?.data??[];
              return Column(
                children: [
                  Divider(),
                  Row(
                    children: [
                      Expanded(child: SizedBox.shrink()),
                      Text(
                        'Vehículos Registrados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: SizedBox.shrink()),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: CustomButton(
                                  backColor: AppColors.mainDarkCyan,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text("+ Agregar Nuevo"),
                                  ),
                                  onPressed: () {
                                    showCustomDialog(
                                        context,
                                        "Agregar nuevo vehículo",
                                        CarForm(
                                          carModel: null,
                                          contextHome: context,
                                          upListener: (){
                                            //notifyListeners();
                                          },
                                        ),
                                        dismiss: false);
                                  },
                                  loading: false),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Expanded(
                    child: state.loading?Center(child: CircularProgressIndicator(),):state.showTable==true?DataTable2ScrollupDemo(contextHome: context):Center(child: Text("No tiene vehículos registrados",style: TextStyle(fontSize: 25,color: AppColors.mainDarkCyan),),),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(child: SizedBox.shrink()),
                        Text(
                          'Fecha para su consulta:  ',
                          style: TextStyle(
                              fontSize: 25, color: AppColors.mainDarkBlue),
                        ),
                        Card(
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${fechaString(state.dateTimeSelected)}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.mainDarkCyan,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                showPicker(
                                  context: context,
                                  value: _time,
                                  sunrise: TimeOfDay(
                                      hour: 6, minute: 30), // optional
                                  sunset: TimeOfDay(
                                      hour: 18, minute: 30), // optional
                                  duskSpanInMinutes: 120, // optional
                                  onChange: (value) {
                                    _setTime(value, context);
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${horaMinString(state.dateTimeSelected)}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.mainDarkCyan,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              );
            })));
  }
}
