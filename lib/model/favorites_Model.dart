class FavoritesModel {
  late bool status;
  late   dynamic message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    message = json['message'];
    //print('messege : '+json['message'].runtimeType.toString());

    data = Data.fromJson(json['data']);
    //print('errrrrrrrrrrrr');


  }
}

class Data {
  late int currentPage;
  late List<favoritesData> data = [];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late  dynamic nextPageUrl;
  late String path;
  late int perPage;
  late dynamic prevPageUrl;
  late int to;
  dynamic total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];


      if (json['data'] != null) {
       // print(json['data'].length.toString()+ 'length....');
        json['data'].forEach((v) {
         // print(55);
          data.add(favoritesData.fromJson(v));

        });
      }


    firstPageUrl = json['first_page_url'];

//print(firstPageUrl.toString()+' first zeft');
    from = json['from'];
//print(from.toString() + ' from');
    lastPage = json['last_page'];
    //print(lastPage.toString() + ' last_page');

    lastPageUrl = json['last_page_url'];
   // print(lastPageUrl);

    nextPageUrl = json['next_page_url'];
  //  print(nextPageUrl);

    path = json['path'];
   // print(path);

    perPage = json['per_page'];
   // print(perPage);

    prevPageUrl = json['prev_page_url'];
   // print(prevPageUrl);

    to = json['to'];
  //  print(to);

    total = json['total'];
    //print(total);

  }
}

class favoritesData {
  late int id;
  late Product product;

  favoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
   // print(json['id'].runtimeType);

    product = Product.fromJson(json['product']);
//print(product);
  }
}

class Product {
  late int id;
 dynamic price;
dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'];
//print(json['price'].runtimeType);
    oldPrice = json['old_price'];
   // print('old price: '+json['old_price'].runtimeType.toString());

    discount = json['discount'];
    //print('discount: '+json['discount'].runtimeType.toString());

    image = json['image'];

    name = json['name'];

    description = json['description'];

  }
}
