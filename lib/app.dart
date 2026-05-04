import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/counter/counter.dart';
// import 'package:flutter_counter_bloc/counter/view/counter_page.dart';
import 'package:flutter_counter_bloc/home/view/home_page.dart';
import 'package:flutter_counter_bloc/home/view/home_view.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => CounterCubit())],
      child: HomeView(),
    );
  }
}
