

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pico_placa/pages/car/controllers/carController.dart';
import 'package:pico_placa/pages/car/cubit/cartFormCubit.dart';
import 'package:pico_placa/pages/car/models/carModel.dart';
import 'package:pico_placa/utils/constants.dart';
import 'package:pico_placa/widgets/custom_buttons.dart';
import 'package:pico_placa/widgets/custom_textfield.dart';
import 'package:pico_placa/widgets/textFormats.dart';

class CarForm extends StatelessWidget {
  CarForm({Key? key, this.carModel, required this.contextHome, required this.upListener}) : super(key: key);

  final CarModel? carModel;
  final BuildContext contextHome;
  final Function upListener;

  TextEditingController _modelText = TextEditingController();
  TextEditingController _placaText = TextEditingController();
  TextEditingController _chasisText = TextEditingController();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool _inited=false;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    pickerColor = color;
  }

  String? _validatePlacaInput(String? value) {
    final regex = RegExp(r'^[A-Za-z]{3}-\d{4}$');
    if (value == null || !regex.hasMatch(value)) {
      return 'Formato de placa inválido. Debe ser AAA-0123.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CarFormCubit(),
        child: BlocBuilder<CarFormCubit, CarFormState>(
        builder: (context, state)
    {
      if (!_inited) {
        _inited = true;
        if(carModel!=null){
          _modelText.text = carModel!.model!;
          _placaText.text = carModel!.placa!;
          _chasisText.text = carModel!.chasis!;

          context.read<CarFormCubit>().changeColor(carModel?.color??"5C6BC0");
        }
      }
      return Column(
        children: [
          buildTextTitulo("Registrar Vehículo"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel("Modelo"),
                CustomTextfield(
                  controller: _modelText,
                  enabled: true,
                  autofocus: true,
                  label: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onSubitted: () {},
                  suffixIcon: Icon(Icons.car_repair),
                  textSize: 16,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                const SizedBox(height: 10.0),
                buildLabel("Placa"),
                CustomTextfield(
                  controller: _placaText,
                  enabled: true,
                  autofocus: true,
                  label: "",
                  validator: (value) {
                    return _validatePlacaInput(value);
                  },
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onSubitted: () {},
                  suffixIcon: Icon(Icons.confirmation_number),
                  textSize: 16,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                const SizedBox(height: 10.0),
                buildLabel("Chasis"),
                CustomTextfield(
                  controller: _chasisText,
                  enabled: true,
                  autofocus: true,
                  label: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onSubitted: () {},
                  suffixIcon: Icon(Icons.car_rental_sharp),
                  textSize: 16,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                const SizedBox(height: 10.0),
                buildLabel("Color"),
                ColorPicker(
                  color: hexToColor(state.selectedColor),
                  colorCodeHasColor: false,
                  onColorChanged: (Color value) {

                    context.read<CarFormCubit>().changeColor(value.hex);
                    print("selected: ${state.selectedColor}");
                  },
                  height: 35,
                  width: 35,
                  elevation: 0,
                  runSpacing: 5,
                  hasBorder: false,
                  selectedPickerTypeColor: Colors.blueGrey,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.wheel: false,
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            loading: state.loading,
                            backColor: AppColors.mainGrey,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Cancelar',
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                            loading: state.loading,
                            backColor: AppColors.mainLightGreen,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Guardar',
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            onPressed: () async {
                              context.read<CarFormCubit>().changeLoading(
                                  true);
                              if(carModel?.id!=null){

                                await CarController.updateCar(context,contextHome,state.selectedColor,_placaText.text,_modelText.text,_chasisText.text,carModel!.id!);
                              upListener();
                              }else{
                                await CarController.saveCar(context,contextHome,state.selectedColor,_placaText.text,_modelText.text,_chasisText.text);
                                upListener();
                              }

                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ],
      );
    }));
  }

}
