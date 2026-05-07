import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/counter/cubit/counter_cubit.dart';
import 'package:flutter_counter_bloc/counter/view/counter_page.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/counter',
        routes: {
          // '/': (_) => const HomePage(),
          '/counter': (_) => const CounterPage(),
        },
      ),
    );
  }
}
