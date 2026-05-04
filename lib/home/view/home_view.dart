import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/core/widgets/app_drawer.dart';
import 'package:flutter_counter_bloc/counter/counter.dart';
import 'package:flutter_counter_bloc/counter/view/counter_page.dart';
import 'package:flutter_counter_bloc/home/view/home_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (_) => const HomePage(),
        '/counter': (_) => const CounterPage(),
      },
      title: "Cubit App",
      home: Scaffold(
        appBar: AppBar(title: Text("Home Cubit")),
        drawer: AppDrawer(),
        body: Center(
          child: Column(
            children: [
              Text("Welcome"),
              BlocBuilder<CounterCubit, int>(
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
