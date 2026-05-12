import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/core/widgets/app_drawer.dart';
import 'package:flutter_counter_bloc/counter/cubit/counter_cubit.dart';
import 'package:flutter_counter_bloc/counter/cubit/counter_state.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text("Counter Page")),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text('${state.counter}', style: textTheme.displayMedium);
              },
            ),

              // hanya build widget tertentu, tidak perlu semuanya
              BlocSelector<CounterCubit, CounterState, bool>(
                selector: (state) => state.isEven,
                builder: (context, isEven) {
                  return Text(isEven ? "Genap" : "Ganjil");
                },
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
