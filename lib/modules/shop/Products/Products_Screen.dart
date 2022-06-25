import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding/layout/Shop_home/home_model.dart';
import 'package:on_boarding/layout/shopApp/cubic/cubic.dart';
import 'package:on_boarding/layout/shopApp/cubic/states.dart';
import 'package:on_boarding/modules/shop/Categories/model_Categories.dart';
import 'package:on_boarding/shared/componnents0/components.dart';
import 'package:on_boarding/shared/style/colors.dart';

class Products_Screen extends StatelessWidget {
  const Products_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubic, ShopStates>(
        listener: (context, state) {
if(state is ShopSuccessChangeFavoritesState){
if(!state.model.status){
  ShowToast(state:Toaststates.ERROR ,text:state.model.message );

}
}

        },
        builder: (context, state) {
          var cubic = ShopCubic.get(context);
          return ConditionalBuilder(
              condition: cubic.homeModel != null&&cubic.categoriesModel != null,
              builder: (context) => productsBuilder(cubic.homeModel,cubic.categoriesModel,context),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? categories,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data.banners
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 100,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildCategories(categories!.data.data[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                          itemCount: categories!.data.data.length)),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.831,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(model.data.products.length,
                    (index) => buildGridproduct(model.data.products[index],context)),
              ),
            )
          ],
        ),
      );

  Widget buildCategories(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
               model.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.black.withOpacity(.8),
              width: 100,
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );

  Widget buildGridproduct(ProductsModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 9, color: Colors.white),
                  ),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.black, fontSize: 9, height: 1),
                  ),
                  Row(children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(fontSize: 10, color: defaultcolor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubic.get(context).changeFavorites(model.id);
print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:ShopCubic.get(context).favorites[model.id]==true?Colors.blue:Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );
}
