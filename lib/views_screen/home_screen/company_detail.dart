import 'dart:convert';

import 'package:firstapp/constants/image_assets.dart';
import 'package:firstapp/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../../constants/color_app.dart';
import '../../widgets/Custom Text/generaltext.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/applay_card_widget.dart';
import '../../widgets/buttonSubmit_widget.dart';
import '../../widgets/jobscard_widget.dart';

class CompanyDetailScreen extends StatefulWidget {
  String? companyId;
  String? companyName;
  String? companywebsite;
  String? companyoption;
  String? image;

  CompanyDetailScreen(
      {Key? key,
      this.companyId,
      this.companyName,
      this.companywebsite,
      this.companyoption,
      this.image})
      : super(key: key);

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with TickerProviderStateMixin {
  var data;

  companyDetails() async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://api.publish.jobs/api/get-companyDetail?Id=${widget.companyId}"),
          body: {"id": widget.companyId});
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body.toString());
        });

        return data;
      } else {
        print("jobs details error");
      }
    } catch (e) {
      print(e.toString());
      return data;
    }
  }

  var jobDetailApi;
  var rating = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    print(widget.companyId.toString() + "show company details");
    _tabController = new TabController(length: 4, vsync: this);
    jobDetailApi = companyDetails();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          AppBarShow(),
        ],
        backgroundColor: isDarkMode == true
            ? ColorApp.colornewblack
            : ColorApp.colorbackground,
      ),
      backgroundColor: isDarkMode == true
          ? ColorApp.colornewblack
          : ColorApp.colorbackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                  future: jobDetailApi,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      String name = data["name"];
                      return Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: s.width * 0.01,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: s.width * 0.12,
                                    ),
                                    child: data["business_image"] != null
                                        ? Material(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            elevation: 1,
                                            color: isDarkMode == true
                                                ? ColorApp.colorblackgalf
                                                    .withOpacity(0.5)
                                                : ColorApp.colorwhite,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.white)),
                                              child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor:
                                                      AppColors.colorgray,
                                                  backgroundImage: NetworkImage(
                                                      'https://api.publish.jobs/pjcloud/Business/' +
                                                          data['business_image']
                                                                  ['image']
                                                              .toString())),
                                            ))
                                        : Container(
                                            decoration: BoxDecoration(
                                                color: isDarkMode == true
                                                    ? ColorApp.colorblack
                                                    : ColorApp.colorwhite,
                                                border: Border.all(
                                                    color: isDarkMode == true
                                                        ? ColorApp.colorblack
                                                        : ColorApp.colorwhite)),
                                            height: s.width * 0.07,
                                            width: s.width * 0.11,
                                            child: Center(
                                              child: Text(
                                                name.substring(0),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 24,
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        : AppColors
                                                            .colorgraydark),
                                              ),
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: s.width * 0.04, top: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["name"] ?? '',
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: isDarkMode == true
                                                  ? AppColors.colorwhite
                                                  : ColorApp.colornewblack,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        if ((data['industry_options']
                                                    ?.length
                                                    .toString() ??
                                                '0') !=
                                            '0') ...[
                                          Text(
                                              data['industry_options'][0]
                                                  ['title'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      : ColorApp.colorblackgalf,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("4.5",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        : ColorApp
                                                            .colorblackgalf,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: ColorApp.colorprimary,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: ColorApp.colorprimary,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: ColorApp.colorprimary,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: ColorApp.colorprimary,
                                            ),
                                            Icon(Icons.star,
                                                size: 12,
                                                color: ColorApp.colordltbtn),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: s.width * 0.04,
                                bottom: 10,
                                top: s.height * 0.030),
                            child: Row(
                              children: [
                                SubmitButton(
                                  textColor: isDarkMode == true
                                      ? ColorApp.colorwhite
                                      : Colors.white,
                                  heightButton: s.height * 0.05,
                                  widthButton: s.width * 0.46,
                                  borderRadius: BorderRadius.circular(8),
                                  backGroundColor: AppColors.btnbackground,
                                  textButton: 'Drop your Resume',
                                  onPressed: () {},
                                ),
                                SubmitButton(
                                  backGroundColor: isDarkMode == true
                                      ? ColorApp.colorblack
                                      : ColorApp.colorwhite,
                                  textColor: AppColors.colorprimary,
                                  border: Border.all(
                                      color: AppColors.btnbackground),
                                  heightButton: s.height * 0.05,
                                  widthButton: s.width * 0.26,
                                  borderRadius: BorderRadius.circular(12),
                                  textButton: 'Share',
                                  onPressed: () async {
                                    dynamic name = data["name"];
                                    final result = name.replaceAll(
                                        RegExp('[^A-Za-z0-9]'), '-');
                                    name.trim();

                                    final url =
                                        '${'https://publish.jobs/${result}/${data["uuid"].toString()}'}';

                                    await Share.share('${url}');
                                  },
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: s.height,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    )),
                                    child: TabBar(
                                      unselectedLabelColor: isDarkMode == true
                                          ? ColorApp.colorwhite
                                          : Colors.black,
                                      labelColor: AppColors.colorprimary,
                                      tabs: [
                                        Tab(
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "About",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          icon: Text(
                                            "Locations",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          icon: Row(
                                            children: [
                                              Text(
                                                "Jobs",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          icon: Row(
                                            children: [
                                              Text(
                                                "Review",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                      controller: _tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: s.width * 0.055,
                                              top: s.height * 0.02),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ("About") +
                                                    " " +
                                                    (data["name"]),
                                                style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      : ColorApp.colornewblack,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              if ((data['business_details']
                                                          ?.length
                                                          .toString() ??
                                                      '0') !=
                                                  '0') ...[
                                                Text(
                                                    data['business_details']
                                                        ['details'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: isDarkMode ==
                                                                true
                                                            ? AppColors
                                                                .colorwhite
                                                            : ColorApp
                                                                .colorblackgalf,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Employeer",
                                                style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      : ColorApp.colornewblack,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              if ((data['num_of_employes']
                                                          ?.length
                                                          .toString() ??
                                                      '0') !=
                                                  '0') ...[
                                                Text(
                                                    data['num_of_employes'][0]
                                                        ['title'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: isDarkMode ==
                                                                true
                                                            ? AppColors
                                                                .colorwhite
                                                            : ColorApp
                                                                .colorblackgalf,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Website",
                                                style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? AppColors.colorwhite
                                                      : ColorApp.colornewblack,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                data["websites"]["website"],
                                                style: TextStyle(
                                                  color: ColorApp.colorprimary,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              if ((data['address']
                                                          ?.length
                                                          .toString() ??
                                                      '0') !=
                                                  '0') ...[
                                                Column(
                                                  children: [
                                                    Text(
                                                      "HeadOffice",
                                                      style: TextStyle(
                                                        color: isDarkMode ==
                                                                true
                                                            ? AppColors
                                                                .colorwhite
                                                            : ColorApp
                                                                .colornewblack,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        data['address'][0]
                                                            ['address'],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: isDarkMode ==
                                                                    true
                                                                ? AppColors
                                                                    .colorwhite
                                                                : ColorApp
                                                                    .colorblackgalf,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ],
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: s.width * 0.055,
                                              top: s.height * 0.02),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Company Locations",
                                                style: TextStyle(
                                                    color: isDarkMode == true
                                                        ? AppColors.colorwhite
                                                        : ColorApp
                                                            .colornewblack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: s.height * 0.025,
                                              ),
                                              Container(
                                                width: s.width,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    itemCount:
                                                        data["address"].length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10,
                                                                right: s.width *
                                                                    0.07),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.4)
                                                                  : ColorApp
                                                                      .colorblackgalf
                                                                      .withOpacity(
                                                                          0.05),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 12,
                                                                              right: 12),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                28,
                                                                            width:
                                                                                28,
                                                                            decoration:
                                                                                BoxDecoration(color: data["address"][index]["addresstypes"]["title"] == "Head Office" ? ColorApp.colorprimary : ColorApp.colorblackgalf, borderRadius: BorderRadius.circular(40)),
                                                                            child:
                                                                                Center(
                                                                              child: Icon(Icons.location_on_outlined, color: ColorApp.colorwhite, size: 19),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data["address"][index]["addresstypes"]
                                                                              [
                                                                              "title"],
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: isDarkMode == true ? Colors.white : ColorApp.colornewblack),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              12),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "Get direction",
                                                                            style: TextStyle(
                                                                                color: ColorApp.colorprimary,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_forward_outlined,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                ColorApp.colorprimary,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: s.width *
                                                                              0.14,
                                                                          right:
                                                                              3,
                                                                          bottom:
                                                                              12,
                                                                          top:
                                                                              3),
                                                                      child:
                                                                          Text(
                                                                        data["address"][index]
                                                                            [
                                                                            "address"],
                                                                        style: TextStyle(
                                                                            color: isDarkMode == true
                                                                                ? Colors.white
                                                                                : ColorApp.colornewblack,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: s.width,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount:
                                                      data["jobs"].length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    String name = data["name"];
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          bottom: 10,
                                                          right:
                                                              s.width * 0.04),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8,
                                                                    bottom: 8,
                                                                    left: 10),
                                                            child: Text(
                                                              data["name"],
                                                              style: TextStyle(
                                                                  color: isDarkMode == false
                                                                      ? ColorApp
                                                                          .colorblackgalf
                                                                      : ColorApp
                                                                          .colorwhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4),
                                                            child: SizedBox(
                                                              height: s.height *
                                                                  0.05,
                                                              child: Material(
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? ColorApp
                                                                        .colorblackgalf
                                                                        .withOpacity(
                                                                            0.5)
                                                                    : ColorApp
                                                                        .colorbackgroundsearch,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0)),
                                                                child:
                                                                    TextFormField(
                                                                  onFieldSubmitted:
                                                                      (value) {
                                                                    // getAllJobsFuture = GetJobsListController()
                                                                    //     .getJobList(
                                                                    //     searchData == 'null'
                                                                    //         ? ''
                                                                    //         : searchData.toString(),
                                                                    //     fc,
                                                                    //     fct,
                                                                    //     fjt);
                                                                    // companyData.toString()=='null'?'':companyData.toString()

                                                                    FocusScopeNode
                                                                        currentFocus =
                                                                        FocusScope.of(
                                                                            context);

                                                                    if (!currentFocus
                                                                        .hasPrimaryFocus) {
                                                                      currentFocus
                                                                          .unfocus();
                                                                    }
                                                                  },
                                                                  onChanged:
                                                                      (data) {
                                                                    // setState(() {
                                                                    //   searchData = data.toString();
                                                                    // });
                                                                  },
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  decoration: InputDecoration(
                                                                      hintText: 'Search Publish jobs or keybords',
                                                                      hintStyle: TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : ColorApp.colorwhite.withOpacity(0.8), fontSize: 12),
                                                                      prefixIcon: GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          // setState(() {
                                                                          //   // fc='';
                                                                          //   // fct='';
                                                                          //   // fjt='';
                                                                          //   FocusScope.of(context).unfocus();
                                                                          // });
                                                                          // getAllJobsFuture = GetJobsListController()
                                                                          //     .getJobList(
                                                                          //     searchData == 'null'
                                                                          //         ? ''
                                                                          //         : searchData.toString(),
                                                                          //     fc,
                                                                          //     fct,
                                                                          //     fjt);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .search,
                                                                          color: isDarkMode == false
                                                                              ? ColorApp.colorblackgalf
                                                                              : ColorApp.colorwhite.withOpacity(0.8),
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12))),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8,
                                                                    bottom: 8,
                                                                    left: 8),
                                                            child: Text(
                                                              "Recent Open jobs ",
                                                              style: TextStyle(
                                                                  color: isDarkMode == false
                                                                      ? ColorApp
                                                                          .colorblackgalf
                                                                      : ColorApp
                                                                          .colorwhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          Material(
                                                            color: isDarkMode ==
                                                                    true
                                                                ? ColorApp
                                                                    .colorblackgalf
                                                                    .withOpacity(
                                                                        0.5)
                                                                : ColorApp
                                                                    .colorwhite,
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    color: ColorApp
                                                                        .colorblackgalf
                                                                        .withOpacity(
                                                                            0.4)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0)),
                                                            child: Column(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Material(
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  side: BorderSide(
                                                                                    color: ColorApp.colorprimary.withOpacity(0.4),
                                                                                  ),
                                                                                ),
                                                                                elevation: 1,
                                                                                color: isDarkMode == true ? ColorApp.colorblackgalf.withOpacity(0.5) : ColorApp.colorwhite,
                                                                                child: data["business_image"] != null
                                                                                    ? Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(width: 1, color: Colors.white)),
                                                                                        child: CircleAvatar(radius: 40, backgroundColor: AppColors.colorgray, backgroundImage: NetworkImage('https://api.publish.jobs/pjcloud/Business/' + data['business_image']['image'].toString())),
                                                                                      )
                                                                                    : Padding(
                                                                                        padding: const EdgeInsets.only(left: 5),
                                                                                        child: Container(
                                                                                            height: s.height * 0.06,
                                                                                            width: s.width * 0.14,
                                                                                            child: Center(
                                                                                                child: Container(
                                                                                              // decoration: BoxDecoration(
                                                                                              //     color: isDarkMode ==
                                                                                              //             true
                                                                                              //         ? ColorApp
                                                                                              //             .colorblackgalf
                                                                                              //             .withOpacity(
                                                                                              //                 0.5)
                                                                                              //         : ColorApp
                                                                                              //             .colorwhite,
                                                                                              //     borderRadius:
                                                                                              //         BorderRadius
                                                                                              //             .circular(
                                                                                              //                 4)),
                                                                                              height: s.width * 0.07,
                                                                                              width: s.width * 0.11,
                                                                                              child: Center(
                                                                                                child: Text(
                                                                                                  name.substring(0),
                                                                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: isDarkMode == true ? AppColors.colorwhite : AppColors.colorgraydark),
                                                                                                ),
                                                                                              ),
                                                                                            ))),
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: s.width * 0.045, top: 7),
                                                                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                CustomText(
                                                                                  color: isDarkMode == false ? ColorApp.colorblack : ColorApp.colorwhite,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  text: data["jobs"][index]["title"],
                                                                                  size: 12,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 2,
                                                                                ),
                                                                                CustomText(
                                                                                  color: isDarkMode == false ? ColorApp.colorblackgalf : ColorApp.colorwhite,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  text: data["name"],
                                                                                  size: 10,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 2,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.location_on_outlined,
                                                                                      size: 18,
                                                                                      color: ColorApp.colorprimary,
                                                                                    ),
                                                                                    Text(
                                                                                      data["address"][index]["city"]["title"] + ", " + (data["address"][index]["country"]["title"]),
                                                                                      style: TextStyle(color: ColorApp.colorprimary, fontSize: 11),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              bottom: s.height * 0.03,
                                                                              right: 10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 8),
                                                                                  child: Icon(
                                                                                    Icons.favorite_border,
                                                                                    color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblackgalf,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 5),
                                                                                  child: Icon(
                                                                                    Icons.share,
                                                                                    color: isDarkMode == true ? ColorApp.colorwhite : ColorApp.colorblackgalf,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
                                                                                  child: Text(
                                                                                    "1 hour ago",
                                                                                    style: TextStyle(color: ColorApp.colorprimary, fontSize: 12),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                                                                                  child: Material(
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                                      elevation: 1,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 05),
                                                                                        child: Text(
                                                                                          data["jobs"][index]["salary"]['currency']['currency_code'] + " " + data["jobs"][index]["salary"]['minimum'] + "-" + data["jobs"][index]["salary"]['maximum'],
                                                                                          style: TextStyle(
                                                                                            fontSize: 7,
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 08,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                                                                                  child: Material(
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                                      elevation: 1,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 3),
                                                                                            child: Icon(
                                                                                              Icons.access_time,
                                                                                              size: 7,
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 05),
                                                                                            child: Text(
                                                                                              data["jobs"][index]["jobtype_options"][0]["title"],
                                                                                              // data['jobtype_options'][index]['title'],
                                                                                              style: TextStyle(
                                                                                                fontSize: 7,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 08,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(bottom: 10, top: 5, right: 10),
                                                                              child: Container(
                                                                                height: s.height * 0.035,
                                                                                width: s.width * 0.23,
                                                                                decoration: BoxDecoration(color: ColorApp.colorprimary, borderRadius: BorderRadius.circular(20)),
                                                                                child: Material(
                                                                                  color: ColorApp.colorprimary,
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                                  elevation: 6,
                                                                                  child: InkWell(
                                                                                    onTap: () {},
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        Text(
                                                                                          "Applay",
                                                                                          style: TextStyle(color: ColorApp.colorwhite, fontSize: 11),
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.person,
                                                                                          color: ColorApp.colorwhite,
                                                                                          size: 14,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        child: Text(
                                                          "100 review",
                                                          style: TextStyle(
                                                              color: ColorApp
                                                                  .colorblackgalf,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: s.width *
                                                                    0.031),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: ColorApp
                                                                  .colorprimary
                                                                  .withOpacity(
                                                                      0.3)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Write a Review",
                                                              style: TextStyle(
                                                                  color: ColorApp
                                                                      .colorprimary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0,
                                                                top: s.height *
                                                                    0.014),
                                                        child: SizedBox(
                                                          height:
                                                              s.height * 0.05,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 0,
                                                                      right: s.width *
                                                                          0.04),
                                                                  child:
                                                                      Material(
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? ColorApp
                                                                            .colorblackgalf
                                                                            .withOpacity(
                                                                                0.5)
                                                                        : ColorApp
                                                                            .colorbackgroundsearch,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0)),
                                                                    child:
                                                                        TextFormField(
                                                                      onFieldSubmitted:
                                                                          (value) {
                                                                        // getAllJobsFuture = GetJobsListController()
                                                                        //     .getJobList(
                                                                        //     searchData == 'null'
                                                                        //         ? ''
                                                                        //         : searchData.toString(),
                                                                        //     fc,
                                                                        //     fct,
                                                                        //     fjt);
                                                                        // companyData.toString()=='null'?'':companyData.toString()

                                                                        FocusScopeNode
                                                                            currentFocus =
                                                                            FocusScope.of(context);

                                                                        if (!currentFocus
                                                                            .hasPrimaryFocus) {
                                                                          currentFocus
                                                                              .unfocus();
                                                                        }
                                                                      },
                                                                      onChanged:
                                                                          (data) {
                                                                        // setState(() {
                                                                        //   searchData = data.toString();
                                                                        // });
                                                                      },
                                                                      textAlignVertical:
                                                                          TextAlignVertical
                                                                              .center,
                                                                      decoration: InputDecoration(
                                                                          hintText: 'Search Publish jobs or keybords',
                                                                          hintStyle: TextStyle(color: isDarkMode == false ? ColorApp.colorblackgalf : ColorApp.colorwhite.withOpacity(0.8), fontSize: 12),
                                                                          prefixIcon: GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // setState(() {
                                                                              //   // fc='';
                                                                              //   // fct='';
                                                                              //   // fjt='';
                                                                              //   FocusScope.of(context).unfocus();
                                                                              // });
                                                                              // getAllJobsFuture = GetJobsListController()
                                                                              //     .getJobList(
                                                                              //     searchData == 'null'
                                                                              //         ? ''
                                                                              //         : searchData.toString(),
                                                                              //     fc,
                                                                              //     fct,
                                                                              //     fjt);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.search,
                                                                              color: isDarkMode == false ? ColorApp.colorblackgalf : ColorApp.colorwhite.withOpacity(0.8),
                                                                            ),
                                                                          ),
                                                                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12))),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                        s.width *
                                                                            0.06),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      s.width *
                                                                          0.13,
                                                                  height:
                                                                      s.height *
                                                                          0.048,
                                                                  decoration: BoxDecoration(
                                                                      color: isDarkMode ==
                                                                              true
                                                                          ? ColorApp.colorblackgalf.withOpacity(
                                                                              0.5)
                                                                          : ColorApp
                                                                              .colorbackgroundsearch,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Image
                                                                      .asset(
                                                                    width:
                                                                        s.width *
                                                                            0.04,
                                                                    ImangeAssests
                                                                        .searchImg,
                                                                    color: isDarkMode ==
                                                                            true
                                                                        ? ColorApp
                                                                            .colorwhite
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                top: 8),
                                                        child: Text(
                                                          "what people say about" +
                                                              " " +
                                                              data["name"],
                                                          style: TextStyle(
                                                              color: ColorApp
                                                                  .colorblackgalf,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey,
                                                        thickness: 2,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        width: s.width,
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                ScrollPhysics(),
                                                            itemCount: 10 + 1,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              String name =
                                                                  data["name"];
                                                              return Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 15,
                                                                    bottom: 15,
                                                                    right:
                                                                        s.width *
                                                                            0.04),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                CircleAvatar(
                                                                                  backgroundColor: ColorApp.colorprimary,
                                                                                  child: Text(
                                                                                    "Ma",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: s.width * 0.04, bottom: 3),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "ali khan",
                                                                                        style: TextStyle(color: ColorApp.colorblack),
                                                                                      ),
                                                                                      Text(
                                                                                        "Project Manger",
                                                                                        style: TextStyle(color: ColorApp.colorblackgalf),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.share),
                                                                                Icon(Icons.add)
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              12,
                                                                        ),
                                                                        Text(
                                                                          "Fun and enveronment",
                                                                          style: TextStyle(
                                                                              color: ColorApp.colorblack,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 19),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              12,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                                width: 29,
                                                                                height: 20,
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorApp.colorprimary,
                                                                                  borderRadius: BorderRadius.circular(2),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    '$index++',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                )),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: s.width * 0.06),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.calendar_today_outlined,
                                                                                    size: 14,
                                                                                  ),
                                                                                  RichText(
                                                                                      text: TextSpan(children: [
                                                                                    TextSpan(text: 'Monday ', style: TextStyle(fontWeight: FontWeight.w400, color: ColorApp.colorblackgalf, fontStyle: FontStyle.italic)),
                                                                                    TextSpan(text: 'May 03,2023 ', style: TextStyle(fontStyle: FontStyle.italic, color: ColorApp.colorblackgalf)),
                                                                                  ])),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "Salary -",
                                                                              style: TextStyle(color: ColorApp.colorblackgalf),
                                                                            ),
                                                                            Text(
                                                                              "Salary about details",
                                                                              style: TextStyle(color: ColorApp.colorblackgalf),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: RichText(
                                                                                text: TextSpan(children: [
                                                                                  TextSpan(text: 'Prons :', style: TextStyle(color: ColorApp.colorblack)),
                                                                                  TextSpan(text: 'In this article, we will take a look that the RichText and TextSpan widgets', style: TextStyle(color: ColorApp.colorblackgalf)),
                                                                                ]),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: RichText(
                                                                                text: TextSpan(children: [
                                                                                  TextSpan(text: 'Coin :', style: TextStyle(color: ColorApp.colorblack)),
                                                                                  TextSpan(text: 'Every website and mobile app, more or less, contains text. In Flutter, you can display a paragraph text that has multiple different styles by using a RichText widget and a tree of TextSpan widgets in combination. The text may be on a single line or multiple lines based on the layout constraints.', style: TextStyle(color: ColorApp.colorblackgalf)),
                                                                                ]),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Was this Helpfull ?"),
                                                                            SizedBox(
                                                                              width: s.width * 0.05,
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all()),
                                                                              child: Row(
                                                                                children: [
                                                                                  Icon(Icons.add),
                                                                                  Icon(Icons.share)
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              2,
                                                                          top:
                                                                              2),
                                                                      child:
                                                                          Divider(
                                                                        thickness:
                                                                            3,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            })),
                                                    Text("hello data"),
                                                    Text("hello data")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      controller: _tabController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: s.height * 0.37),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
