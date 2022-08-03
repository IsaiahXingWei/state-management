import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/counter_cubit.dart';

class InputCubit extends Cubit<num>{
  InputCubit(): super(0);

  void acceptNumber() => emit(state);
}