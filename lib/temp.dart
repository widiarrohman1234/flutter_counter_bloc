import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/counter/counter.dart';
import 'package:flutter_counter_bloc/home/view/home_page.dart';
import 'package:flutter_counter_bloc/posts/bloc/post_bloc.dart';
import 'package:flutter_counter_bloc/posts/bloc/post_event.dart';
import 'package:flutter_counter_bloc/posts/view/posts_page.dart';
import 'package:http/http.dart' as http;

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(
          create: (_) =>
              PostBloc(httpClient: http.Client())..add(PostFetched()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/posts',
        routes: {
          '/': (_) => const HomePage(),
          '/counter': (_) => const CounterPage(),
          '/posts': (_) => const PostsPage(),
        },
      ),
    );
  }
}
