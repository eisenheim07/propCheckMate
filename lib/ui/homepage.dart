import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:propcheckmate/businessLogic/cubit/home_cubit.dart';
import 'package:propcheckmate/businessLogic/models/homepage/home_model.dart';
import 'package:propcheckmate/common/flushbar.dart';
import 'package:propcheckmate/common/global.dart';
import 'package:propcheckmate/widgets/loading_widget.dart';

import '../common/colors.dart';
import '../common/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://cdn5.vectorstock.com/i/1000x1000/99/99/house-renting-service-flat-promo-poster-vector-28919999.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/99/99/house-renting-service-flat-promo-poster-vector-28919999.jpg',
    'https://cdn5.vectorstock.com/i/1000x1000/99/99/house-renting-service-flat-promo-poster-vector-28919999.jpg',
  ];

  @override
  void initState() {
    context.read<HomeCubit>().fetchData();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, NetworkState<List<HomeModel>>>(
      listener: (context, state) {
        if (state is Error<List<HomeModel>>) {
          context.flushBarErrorMessage(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          key: _scaffoldKey,
          drawer: customDrawer(),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<HomeCubit>().fetchData();
                  },
                ),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    toggleDrawer();
                  }),
            ),
            actionsIconTheme: IconThemeData(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Azam Khan', style: Global.customFonts(color: AppColors.whiteColor, size: 12, weight: FontWeight.bold)),
                Text('WELCOME', style: Global.customFonts(color: AppColors.whiteColor, size: 14, weight: FontWeight.bold)),
              ],
            ),
            backgroundColor: AppColors.primaryColor,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  if (state is Success<List<HomeModel>>) ...[
                    if (state.data.isNotEmpty) ...[
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            var element = state.data[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (element.isEnabled == true && element.info!.layout.toString() == 'slider') ...[
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 200,
                                      autoPlay: true,
                                      viewportFraction: 1.0,
                                    ),
                                    items: imageUrls.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Image.network(i, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width);
                                        },
                                      );
                                    }).toList(),
                                  )
                                ],
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (element.isEnabled == true) ...[
                                        if (element.info!.header!.isNotEmpty) ...[
                                          Text(
                                            element.info!.header.toString(),
                                            style: Global.customFonts(family: 'Poppins2', weight: FontWeight.bold, size: 16),
                                          ),
                                          Global.verticalSpace(context, 0.01),
                                        ],
                                        if (element.info!.layout == 'linear') ...[
                                          if (element.info!.type == "1.1") ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Card(
                                                child: Row(
                                                  children: List.generate(element.info!.data!.length, (index) {
                                                    var info = element.info!.data![index];
                                                    return Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(child: Icon(Icons.import_contacts)),
                                                          Text(info.name.toString(), style: Global.customFonts(size: 12)),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ] else if (element.info!.type == "1.2") ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(element.info!.data!.length, (index) {
                                                  var info = element.info!.data![index];
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.blackColor)),
                                                      child: Card(
                                                        child: InkWell(
                                                          onTap: () {
                                                            context.flushBarErrorMessage(message: info.name.toString());
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Center(
                                                                  child: Image.network(info.img.toString(), fit: BoxFit.cover),
                                                                ),
                                                                Global.verticalSpace(context, 0.01),
                                                                Text(info.name.toString(),
                                                                    style: Global.customFonts(size: 14, weight: FontWeight.bold)),
                                                                Text(info.address.toString(),
                                                                    overflow: TextOverflow.ellipsis, style: Global.customFonts(size: 12)),
                                                                Global.verticalSpace(context, 0.01),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          border: Border.all(color: AppColors.blackColor)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Icon(Icons.currency_rupee, size: 16),
                                                                                Text(info.price.toString(), style: Global.customFonts(size: 12)),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(info.ratings.toString()),
                                                                        Global.horizontalSpace(context, 0.01),
                                                                        Icon(Icons.star)
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  height: 40,
                                                                  color: AppColors.blackColor,
                                                                  thickness: 0.5,
                                                                  indent: 2,
                                                                  endIndent: 2,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          border: Border.all(color: AppColors.blackColor)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.hot_tub),
                                                                            Global.horizontalSpace(context, 0.01),
                                                                            Text(info.bhk![0].toString(), style: Global.customFonts(size: 12)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          border: Border.all(color: AppColors.blackColor)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.bed),
                                                                            Global.horizontalSpace(context, 0.01),
                                                                            Text(info.bhk![1].toString(), style: Global.customFonts(size: 12)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          border: Border.all(color: AppColors.blackColor)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(4.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.square),
                                                                            Global.horizontalSpace(context, 0.01),
                                                                            Text("${info.area} sq. mtr.", style: Global.customFonts(size: 12)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ] else if (element.info!.type == "1.3") ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(element.info!.data!.length, (index) {
                                                  var info = element.info!.data![index];
                                                  return InkWell(
                                                    onTap: () {
                                                      context.flushBarErrorMessage(message: info.name.toString());
                                                    },
                                                    child: Card(
                                                      child: InkWell(
                                                        onTap: () {
                                                          context.flushBarErrorMessage(message: info.name.toString());
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(12),
                                                              color: AppColors.cardColor,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  CircleAvatar(radius: 30, child: Icon(Icons.place, size: 30)),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Column(
                                                                      children: [
                                                                        Text(info.name.toString(),
                                                                            style: Global.customFonts(size: 14, weight: FontWeight.bold)),
                                                                        Row(
                                                                          children: [
                                                                            Text(info.type.toString(), style: Global.customFonts(size: 14)),
                                                                            Global.horizontalSpace(context, 0.01),
                                                                            Text(" | "),
                                                                            Text(info.visit.toString(), style: Global.customFonts(size: 14)),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Global.verticalSpace(context, 0.01),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons.phone_android),
                                                                          Global.horizontalSpace(context, 0.01),
                                                                          Text(info.phone.toString(), style: Global.customFonts(size: 14)),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons.mail),
                                                                          Global.horizontalSpace(context, 0.01),
                                                                          Text(info.email.toString(), style: Global.customFonts(size: 14)),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ] else if (element.info!.type == "1.4") ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(element.info!.data!.length, (index) {
                                                  var info = element.info!.data![index];
                                                  return Card(
                                                    child: Container(
                                                      height: 120,
                                                      width: 120,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(child: Icon(Icons.import_contacts)),
                                                          Global.verticalSpace(context, 0.01),
                                                          Text(info.name.toString(),
                                                              overflow: TextOverflow.ellipsis,
                                                              style: Global.customFonts(size: 12, weight: FontWeight.bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ] else ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(element.info!.data!.length, (index) {
                                                  var info = element.info!.data![index];
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 320.0,
                                                          height: 280.0,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(fit: BoxFit.fitHeight, image: NetworkImage(info.img.toString())),
                                                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                flex: 6,
                                                                child: SizedBox(),
                                                              ),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.black54,
                                                                          blurRadius: 50,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    padding: EdgeInsets.all(8),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 200,
                                                                              child: RichText(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                text: TextSpan(
                                                                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                                                                  children: <TextSpan>[
                                                                                    TextSpan(
                                                                                        text: info.name.toString(),
                                                                                        style: Global.customFonts(
                                                                                            family: 'Poppins2',
                                                                                            size: 14,
                                                                                            color: AppColors.whiteColor,
                                                                                            weight: FontWeight.bold)),
                                                                                    TextSpan(
                                                                                        text: "  in  ",
                                                                                        style: Global.customFonts(
                                                                                            family: 'Poppins2',
                                                                                            size: 12,
                                                                                            color: AppColors.whiteColor,
                                                                                            weight: FontWeight.bold)),
                                                                                    TextSpan(
                                                                                        text: info.location.toString(),
                                                                                        style: Global.customFonts(
                                                                                            family: 'Poppins2',
                                                                                            size: 14,
                                                                                            color: AppColors.whiteColor,
                                                                                            weight: FontWeight.bold)),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(info.address.toString(),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Global.customFonts(
                                                                                        family: 'Poppins2',
                                                                                        size: 12,
                                                                                        color: AppColors.whiteColor,
                                                                                        weight: FontWeight.bold)),
                                                                                Text(info.desc.toString(),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Global.customFonts(
                                                                                        family: 'Poppins2',
                                                                                        size: 12,
                                                                                        color: AppColors.whiteColor,
                                                                                        weight: FontWeight.bold)),
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    Icon(Icons.currency_rupee, color: AppColors.whiteColor),
                                                                                    Text(info.price.toString(),
                                                                                        style: Global.customFonts(
                                                                                            family: 'Poppins2',
                                                                                            size: 14,
                                                                                            color: AppColors.whiteColor,
                                                                                            weight: FontWeight.bold))
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ]
                                        ] else if (element.info!.layout == 'promo') ...[
                                          Image.network(element.info!.data!.first.icon.toString())
                                        ] else if (element.info!.layout == 'gridview') ...[
                                          SizedBox(
                                            height: 650,
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                childAspectRatio: 1.2,
                                              ),
                                              itemCount: element.info!.data!.length,
                                              itemBuilder: (context, index) {
                                                var info = element.info!.data![index];
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.blackColor)),
                                                  child: Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(8), // Set the desired border radius
                                                            child: Image.network(
                                                              info.img.toString(),
                                                              width: double.infinity,
                                                              fit: BoxFit.contain,
                                                            ),
                                                          ),
                                                          Global.verticalSpace(context, 0.01),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(color: AppColors.blackColor)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Icon(Icons.currency_rupee, size: 16),
                                                                  Text(info.price.toString(), style: Global.customFonts(size: 12)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Global.verticalSpace(context, 0.01),
                                                          Text(info.desc.toString(),
                                                              overflow: TextOverflow.ellipsis,
                                                              style: Global.customFonts(size: 12, weight: FontWeight.bold)),
                                                          Global.verticalSpace(context, 0.01),
                                                          Text(info.address.toString(),
                                                              overflow: TextOverflow.ellipsis, style: Global.customFonts(size: 12)),
                                                          Global.verticalSpace(context, 0.02),
                                                          Text(info.createdAt.toString(), style: Global.customFonts(size: 12)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Global.verticalSpace(context, 0.01),
                                        ] else if (element.info!.layout == 'grids') ...[
                                          GridView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: element.info!.rc!,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                            itemCount: element.info!.data!.length,
                                            itemBuilder: (context, index) {
                                              var info = element.info!.data![index];
                                              return Card(
                                                color: AppColors.cardColor,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CircleAvatar(child: Icon(Icons.import_contacts)),
                                                      Text(info.name.toString(), style: Global.customFonts(size: 12)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ] else if (element.info!.layout == 'vertical') ...[
                                          ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: element.info!.data!.length,
                                            itemBuilder: (context, index) {
                                              var info = element.info!.data![index];
                                              return Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 24,
                                                            backgroundImage:
                                                                AssetImage('assets/images/profile.png'), // Replace with a network image if needed
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "Preferred",
                                                                style: TextStyle(fontSize: 12, color: Colors.teal),
                                                              ),
                                                              Text(
                                                                info.name.toString(),
                                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Icon(Icons.verified, color: Colors.blue), // Preferred badge
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[200],
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Chheda Modak Estate Consultant",
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              children: [
                                                                Text("Operating Since 1993  |  "),
                                                                Text("Buyers Served 1500+"),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "35",
                                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                              ),
                                                              Text("Properties for Sale"),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "11",
                                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                              ),
                                                              Text("Properties for Rent"),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ]
                                      ]
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ]
                  ],
                ],
              ),
              if (state is Loading<List<HomeModel>>) ...[LoadingWidget()]
            ],
          ),
          bottomNavigationBar: Padding(
              padding: EdgeInsets.all(2),
              child: CustomNavigationBar(
                  iconSize: 25,
                  borderRadius: Radius.circular(20),
                  selectedColor: AppColors.cardColor,
                  unSelectedColor: AppColors.greyColor,
                  backgroundColor: AppColors.primaryColor,
                  strokeColor: AppColors.whiteColor,
                  items: [
                    CustomNavigationBarItem(icon: Icon(Icons.home_outlined)),
                    CustomNavigationBarItem(icon: Icon(Icons.search)),
                    CustomNavigationBarItem(icon: Icon(Icons.settings_outlined)),
                    CustomNavigationBarItem(icon: Icon(Icons.favorite_outline)),
                  ],
                  onTap: (i) {})),
        );
      },
    );
  }

  Widget customDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('example123@gmail.com', style: Global.customFonts(color: AppColors.whiteColor, size: 14, weight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts_rounded),
            title: Text('Profile', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: Text('News', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text('Favorite', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: Text('Saved Searches', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text('About Us', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: Text('Contact Us', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Settings', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: Text('Terms', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {
              toggleDrawer();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Logout', style: Global.customFonts(size: 14, weight: FontWeight.w500)),
            onTap: () {},
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
