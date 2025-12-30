import 'package:collectorapp/features/sdm/home/controller/employeelist_controller.dart';
import 'package:collectorapp/features/sdm/home/model/sdmemployeelist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui_helpers/empty_widget.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EmployeeListController>().fetchEmployeeList();
    });
  }

  Widget SDMCard({
    required List<EmployeeList> employeeListData,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 25,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to SDM details screen
            //Navigator.push(context, MaterialPageRoute(builder: (_) => TempleListScreen(collectId: '${colletId}', sdmId: '${sdmListData[index].id}',)));
          },
          splashColor: Color(0xFFFF6B35).withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Avatar and Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with index
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFFFA62E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF6B35).withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "#${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),

                    // SDM Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Status
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${employeeListData[index].name}",
                                  style: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 10,
                              //     vertical: 4,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: Colors.green.withOpacity(0.1),
                              //     borderRadius: BorderRadius.circular(12),
                              //     border: Border.all(
                              //       color: Colors.green.withOpacity(0.3),
                              //     ),
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 8,
                              //         height: 8,
                              //         decoration: BoxDecoration(
                              //           color: Colors.green,
                              //           shape: BoxShape.circle,
                              //         ),
                              //       ),
                              //       SizedBox(width: 6),
                              //       Text(
                              //         "Active",
                              //         style: TextStyle(
                              //           color: Colors.green.shade800,
                              //           fontSize: 11,
                              //           fontWeight: FontWeight.w700,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Email
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.grey.shade600,
                                size: 14,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${employeeListData[index].email}",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),

                          // Phone
                          Row(
                            children: [
                              Icon(
                                Icons.phone_iphone_rounded,
                                color: Colors.grey.shade600,
                                size: 14,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${employeeListData[index].mobile}",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               // SizedBox(height: 20),

                // Stats and Actions
                // Container(
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade50,
                //     borderRadius: BorderRadius.circular(15),
                //     border: Border.all(color: Colors.grey.shade200),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       // Temples Count
                //       Column(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //               color: Colors.orange.withOpacity(0.1),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: Icon(
                //               Icons.temple_buddhist_rounded,
                //               color: Color(0xFFFF6B35),
                //               size: 22,
                //             ),
                //           ),
                //           SizedBox(height: 8),
                //           Text(
                //             "Temples",
                //             style: TextStyle(
                //               color: Colors.grey.shade600,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(height: 4),
                //           Text(
                //             "${employeeListData[index].id}",
                //             style: TextStyle(
                //               color: Colors.grey.shade900,
                //               fontSize: 18,
                //               fontWeight: FontWeight.w800,
                //             ),
                //           ),
                //         ],
                //       ),
                //
                //       // District
                //       Column(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //               color: Colors.blue.withOpacity(0.1),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: Icon(
                //               Icons.location_city_rounded,
                //               color: Colors.blue,
                //               size: 22,
                //             ),
                //           ),
                //           SizedBox(height: 8),
                //           Text(
                //             "District",
                //             style: TextStyle(
                //               color: Colors.grey.shade600,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(height: 4),
                //           Text(
                //             "${employeeListData[index].district}",
                //             style: TextStyle(
                //               color: Colors.grey.shade900,
                //               fontSize: 16,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //         ],
                //       ),
                //
                //       // Action Buttons
                //       Column(
                //         children: [
                //           Container(
                //             padding: EdgeInsets.all(8),
                //             decoration: BoxDecoration(
                //               color: Colors.purple.withOpacity(0.1),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: Icon(
                //               Icons.remove_red_eye_rounded,
                //               color: Colors.purple,
                //               size: 22,
                //             ),
                //           ),
                //           SizedBox(height: 8),
                //           Text(
                //             "View",
                //             style: TextStyle(
                //               color: Colors.grey.shade600,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           SizedBox(height: 4),
                //           Container(
                //             padding: EdgeInsets.symmetric(
                //               horizontal: 12,
                //               vertical: 4,
                //             ),
                //             decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 colors: [Color(0xFFFF6B35), Color(0xFFFFA62E)],
                //               ),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             child: Text(
                //               "Details",
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 11,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 16),

                // Bottom Actions
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     // Call Button
                //     Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Colors.green.withOpacity(0.1),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: IconButton(
                //         onPressed: () {
                //           // Call functionality
                //           // _makeCall(sdm['mobile']);
                //         },
                //         icon: Icon(
                //           Icons.call_outlined,
                //           color: Colors.green,
                //           size: 18,
                //         ),
                //         padding: EdgeInsets.zero,
                //       ),
                //     ),
                //
                //     SizedBox(width: 12),
                //
                //     // Message Button
                //     Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Colors.blue.withOpacity(0.1),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: IconButton(
                //         onPressed: () {
                //           // Message functionality
                //           // _sendMessage(sdm['mobile']);
                //         },
                //         icon: Icon(
                //           Icons.message_outlined,
                //           color: Colors.blue,
                //           size: 18,
                //         ),
                //         padding: EdgeInsets.zero,
                //       ),
                //     ),
                //
                //     SizedBox(width: 12),
                //
                //     // More Options
                //     Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Colors.grey.withOpacity(0.1),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: PopupMenuButton(
                //         itemBuilder: (context) => [
                //           PopupMenuItem(
                //             child: Row(
                //               children: [
                //                 Icon(Icons.edit, color: Colors.blue, size: 18),
                //                 SizedBox(width: 8),
                //                 Text("Edit"),
                //               ],
                //             ),
                //           ),
                //           PopupMenuItem(
                //             child: Row(
                //               children: [
                //                 Icon(Icons.delete, color: Colors.red, size: 18),
                //                 SizedBox(width: 8),
                //                 Text("Remove"),
                //               ],
                //             ),
                //           ),
                //         ],
                //         child: Icon(
                //           Icons.more_vert_rounded,
                //           color: Colors.grey.shade700,
                //           size: 20,
                //         ),
                //         padding: EdgeInsets.zero,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Consumer<EmployeeListController>(
        builder: (BuildContext context, employeeListController, child) {
          if (employeeListController.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          final data = employeeListController.employeeListModel;

          if (data == null || data.employeeList.isEmpty) {
            return const EmptyState(
              message: "No Employee data found!",
              icon: Icons.collections_bookmark_outlined,
            );
          }
          return CustomScrollView(
            slivers: [
              // Header Section
              SliverAppBar(
                expandedHeight: 200,
                automaticallyImplyLeading: false,
                floating: false,
                backgroundColor: Colors.white,
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.3),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back button and title
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "All Employee's",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Stats card
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.people_alt_rounded,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Employee's",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${data.totalEmployee}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Active",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _StatsHeaderDelegate(),
              ),

              //SDM Cards List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: SDMCard(
                        employeeListData:
                            employeeListController.filterEmployeeList,
                        index: index,
                      ),
                    );
                  },
                  childCount: employeeListController.filterEmployeeList.length,
                ),
              ),

              //Bottom spacing
            //  SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        },
      ),
    );
  }
}

class _StatsHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StatsHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Consumer<EmployeeListController>(
        builder: (BuildContext context, employeeListController, child) {
          return Column(
            children: [
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          onChanged: (value) {
                            employeeListController.searchEmployeeList(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Search Employee by name, email...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.search_rounded,
                              color: Color(0xFFFF6B35),
                              size: 22,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFFFA62E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF6B35).withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.filter_list_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 125;

  @override
  double get minExtent => 125;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
