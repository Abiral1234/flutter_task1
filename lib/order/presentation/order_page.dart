import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/order/application/bloc/order_bloc.dart';
import 'package:flutter_task/order/presentation/message_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import '../application/bloc/order_bloc_event.dart';
import '../application/bloc/order_bloc_state.dart';
import 'review_section.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(dio: dio)..add(FetchOrders()),
      child: Scaffold(
          // backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            elevation: 5,
            backgroundColor: Colors.white,
            actions: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.newspaper,
                    color: Colors.black,
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0XFF6688bb),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagePage()),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.solidMessage,
              color: Colors.white,
            ),
          ),
          body: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 400.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: state.orders.data?.images?.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: state.orders.data!.images!
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            String imageUrl = entry.value;

                            return GestureDetector(
                              onTap: () {
                                _carouselController.animateToPage(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    imageUrl,
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          state.orders.data?.brand?.name ?? '',
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          state.orders.data?.title ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 30,
                                  Icons.favorite_border_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.share_outlined),
                                          Text("Share")
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Code: $produceCode",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: Text(
                                "Rating",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: Colors.grey.shade300,
                              ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                "See All Reviews",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'Rs. $price',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Rs. $strikePrice',
                                style: const TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFF6688bb),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(4)),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "10% Off",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF6688bb),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 0, 5, 0),
                            child: Text(
                              "Color",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Text(
                            "($colorName)",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < state.orders.data!.colorAttributes!.length;
                                i++)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    (i == 0) ? 0.0 : 10.0, 0, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      price = state
                                          .orders.data!.colorVariants![i].price
                                          .toString();
                                      strikePrice = state.orders.data!
                                          .colorVariants![i].strikePrice
                                          .toString();
                                      produceCode = state.orders.data!
                                              .colorVariants![i].productCode ??
                                          '';
                                      colorName = state.orders.data!
                                              .colorAttributes![i].name ??
                                          'Warm Cocoa';
                                      for (int k = 0;
                                          k < selectedColor.length;
                                          k++) {
                                        selectedColor[k] = false;
                                      }
                                      selectedColor[i] = true;
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: selectedColor[i] == true
                                            ? Colors.black
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                            color: Color(int.parse(state
                                                .orders
                                                .data!
                                                .colorAttributes![i]
                                                .colorValue![0]
                                                .replaceAll('#', '0XFF'))),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Select Quantity",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quantity buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: const Color(0XFF6688bb),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity = quantity - 1;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    width: 48,
                                    height: 48,
                                    color: const Color(0XFF6688bb),
                                    child: Center(
                                      child: Text('$quantity',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    )),
                                Container(
                                  color: const Color(0XFF6688bb),
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity >= 1) {
                                          quantity = quantity + 1;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Add to Cart button
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0XFF6688bb),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Collapsible product description
                            ExpansionTile(
                              collapsedBackgroundColor: Colors.grey.shade200,
                              title: const Text(
                                'Product Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(parseHtmlString(
                                    state.orders.data?.description ?? '',
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ExpansionTile(
                              collapsedBackgroundColor: Colors.grey.shade200,
                              title: const Text(
                                'Product Ingredient',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(parseHtmlString(
                                    state.orders.data?.ingredient ?? '',
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ExpansionTile(
                              collapsedBackgroundColor: Colors.grey.shade200,
                              title: const Text(
                                'How To Use?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(parseHtmlString(
                                    state.orders.data?.howToUse ?? '',
                                  )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: ReviewSection(),
                      )
                    ],
                  ),
                );
              } else if (state is OrderError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  final CarouselController _carouselController = CarouselController();
  int quantity = 1;
  String colorName = "Warm Cocoa";
  List<bool> selectedColor = [true, false, false, false, false, false, false];
  String price = '981';
  String strikePrice = '1090';
  String produceCode = "46437";
}

String parseHtmlString(String htmlString) {
  final document = htmlParser.parse(htmlString);
  return document.body?.text ?? '';
}
