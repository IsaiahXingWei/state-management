import 'counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (_) => CounterCubit()),
      //     BlocProvider(create: (_) => InputCubit()),
      //   ],
      //   child: const MyHomePage(title: 'Bloc Practice'),
      // ),
      home: BlocProvider(
        create: (context)=> CounterCubit(),
        child: BlocProvider(
          create: (context)=> InputCubit(),
          child: const MyHomePage(title: 'Bloc Practice'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit counterCubit;
  late InputCubit inputCubit;
  final inputNumber = TextEditingController();

  @override
  void initState() {
    super.initState();

    counterCubit = BlocProvider.of<CounterCubit>(context);
    inputCubit = BlocProvider.of<InputCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          BlocBuilder<InputCubit, num>(
            bloc: inputCubit,
            builder: (context, state) {
              return TextField(
                keyboardType: TextInputType.number,
                controller: inputNumber,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input Number Here',
                ),
              );
            },
          ),
          BlocConsumer<CounterCubit, num>(
            bloc: counterCubit,
            listener: (context, stateCounter) {
              const snackbar = SnackBar(
                content: Text("Don't you have anything better to do?"),
              );
              if (stateCounter == 15) {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            builder: (context, stateCounter) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '$stateCounter',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        counterCubit.incrementCounter();
                      },
                      child: const Text("Increment"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        counterCubit.decrementCounter();
                      },
                      child: const Text("Decrement"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        counterCubit.resetCounter();
                      },
                      child: const Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        counterCubit.timesCounter(inputNumber);
                      },
                      child: const Text("Multiply"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        counterCubit.divideCounter(inputNumber);
                      },
                      child: const Text("Divide"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
