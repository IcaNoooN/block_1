import 'package:block_1/Blocs/list_of_cubit.dart';
import 'package:block_1/Blocs/listpost_bloc_state.dart';
import 'package:block_1/Model/UserContacts.dart';
import 'package:block_1/Views/homeviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'createPage.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BloC"),
          centerTitle: true,
        ),
        body: BlocBuilder<ListPostCubit, ListPostsState>(
          builder: (BuildContext context, ListPostsState state) {
            if (state is ListPostError) {
              return viewOfHome(items, true);
            }
            if (state is ListPostLoaded) {
              items = state.posts;
              return viewOfHome(items, false);
            }
            return viewOfHome(items, true);
          },
        ),
        floatingActionButton: FloatingActionButton(

          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            BlocProvider.of<ListPostCubit>(context).callCreatePage(context);

          },
          child: Icon(Icons.add),
        ));
  }
}