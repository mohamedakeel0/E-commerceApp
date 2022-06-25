import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/modules/shop/Search/Cubic/Cubic.dart';
import 'package:on_boarding/modules/shop/Search/Cubic/states.dart';
import 'package:on_boarding/shared/componnents0/components.dart';

class Search_screen extends StatelessWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubic(),
      child: BlocConsumer<SearchCubic, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          GlobalKey<FormState> formkey = GlobalKey<FormState>();
          var SearchController = TextEditingController();

          return Scaffold(
            appBar: AppBar(),
            body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(controller: SearchController, type: TextInputType.text, validate: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                        label: 'Name',prefix: Icons.search,onSubmit: ( text){
SearchCubic.get(context).search(text);

                          }),
                      SizedBox(height: 10,),
                      if (state is  SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubic.get(context).model!.data.data[index], context,isOldprice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount:  SearchCubic.get(context).model!.data.data.length),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
