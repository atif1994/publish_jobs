import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_color.dart';

class GeneralProfileShimmerEFFECR extends StatelessWidget {
  const GeneralProfileShimmerEFFECR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: s.width,
        color: isDarkMode == false
            ? Colors.white
            : const Color(0xff38373c),
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white30,
          child: isDarkMode?
          Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets
                          .fromLTRB(
                          15, 8, 8, 0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                                50),
                            border: Border.all(
                                width: 1,
                                color: Colors
                                    .white)),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                          AppColors
                              .colorgray,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  top: 25),
                              child: Container(
                                width: 60.0,
                                height: 8.0,
                                color: Colors
                                    .white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                          const EdgeInsets
                              .fromLTRB(
                              0, 3, 0, 1),
                          child: Row(
                            children: [
                              Container(
                                width: 80.0,
                                height: 8.0,
                                color: Colors
                                    .white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(
                      left: 12),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 6, 3, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 3, 0, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 3, 0, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(8, 3,
                                0, 10),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ):
          Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets
                          .fromLTRB(
                          15, 8, 8, 0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                                50),
                            border: Border.all(
                                width: 1,
                                color: Colors
                                    .white)),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                          AppColors
                              .colorgray,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  top: 25),
                              child: Container(
                                width: 60.0,
                                height: 8.0,
                                color: Colors
                                    .white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                          const EdgeInsets
                              .fromLTRB(
                              0, 3, 0, 1),
                          child: Row(
                            children: [
                              Container(
                                width: 80.0,
                                height: 8.0,
                                color: Colors
                                    .white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(
                      left: 12),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 6, 3, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 3, 0, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(
                                8, 3, 0, 1),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets
                                .fromLTRB(8, 3,
                                0, 10),
                            child: Container(
                              width: 80.0,
                              height: 8.0,
                              color:
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
