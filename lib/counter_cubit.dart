import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'input_cubit.dart';


class CounterCubit extends Cubit<num>{
  CounterCubit(): super(0);

  void incrementCounter() {
    emit(state + 1);
  }
  void decrementCounter() => emit(state - 1);
  void resetCounter() => emit(0);
  void timesCounter(value) => emit(state * value);
  void divideCounter(value) => emit(state / value);

}

