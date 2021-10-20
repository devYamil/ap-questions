import 'package:AP/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:AP/src/models/Products.dart';
import 'package:AP/src/pages/DetailProduct.dart';
import 'package:AP/src/providers/getDataProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:AP/utils/env.dart';
import 'package:AP/utils/constants_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  String token = '';

  @override
  void initState() {
    this.configuracionInicial();
    super.initState();
  }

  void configuracionInicial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            _customAppBar(),
            Expanded(
              child: FutureBuilder(
                future: ProductServices().getProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Loading'),
                      ),
                    );
                  } else {
                    return ProductList(products: snapshot.data, token: token);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 30.0),
              child: Text(
                'Banco de Preguntas',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 16.0),
              )),
          Container(
            margin: EdgeInsets.only(left: 50.0),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(
                  width: 5.0,
                ),
                Icon(Icons.shop),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  final List<Products> products;
  final String token;
  const ProductList({
    this.products,
    this.token,
    Key key,
  }) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ScrollController _scrollControllerProducts = new ScrollController();
  List<Products> product;
  String token;
  bool _onNotificationListenerCustom(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollControllerProducts.position.maxScrollExtent >
              _scrollControllerProducts.offset &&
          _scrollControllerProducts.position.maxScrollExtent -
                  _scrollControllerProducts.offset <=
              50) {
        print('End Scroll');
        ProductServices()
            .getProducts(
                url_custom:
                    'http://192.168.0.17:4500/api/get-products-paginate?page=2')
            .then((value) {
          setState(() {
            product.addAll(value);
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    product = widget.products;
    token = widget.token;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollControllerProducts.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.5;
    return NotificationListener(
      onNotification: _onNotificationListenerCustom,
      child: ListView.builder(
        controller: _scrollControllerProducts,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: product.length,
        padding: EdgeInsets.only(left: 20),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("Container clicked ${product[index].id}");
              /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailProduct(
                  idProducto: product[index].id,
                );
              }));*/
              cargarProducto(product[index].id);
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.DetailProductPageClickEvent);
            },
            child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 15,
                ),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    FadeInImage(
                      width: 100,
                      height: 100,
                      placeholder:
                          AssetImage('assets/images/loading_image.gif'),
                      image: NetworkImage(
                          api_rest_uri +
                              api_rest_get_image_product +
                              product[index].imagen,
                          headers: {
                            'Authorization': 'Bearer $token',
                          }),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: containerWidth,
                          child: Text(
                            "${product[index].item}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: containerWidth,
                          child: Text(
                            "(${product[index].descripcion})",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "\$${product[index].precio}",
                              style: TextStyle(
                                fontSize: 20,
                                color: redColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
