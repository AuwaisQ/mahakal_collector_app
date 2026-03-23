import 'package:collectorapp/features/collector/home/model/collectorsdmlist_model.dart';
import 'package:collectorapp/features/collector/home/templelist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui_helpers/empty_widget.dart';
import '../../login/controller/auth_controller.dart';
import 'controller/collectorsdmlist_controller.dart';

class SDMListScreen extends StatefulWidget {
  const SDMListScreen({Key? key,}) : super(key: key);

  @override
  State<SDMListScreen> createState() => _SDMListScreenState();
}

class _SDMListScreenState extends State<SDMListScreen> {

  String userType = "";

  @override
  void initState() {
    final auth = context.read<AuthController>();
    userType = auth.userType ?? '';

    print("UserType $userType");

    super.initState();
    Future.microtask(() {context.read<CollectorSDMListController>().fetchCollectorSDMList();});
  }

  Widget SDMCard({
    required List<SdmList> sdmListData,
    required int index,
    required colletId,
  }) {
    final sdm = sdmListData[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TempleListScreen(templeId: '${sdm.id}',),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///  NAME + DESIGNATION
            Row(
              children: [
                Expanded(
                  child: Text(
                    sdm.name ?? "",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                /// Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    sdm.designation ?? "",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ///  EMAIL
            Text(
              sdm.email ?? "",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            ///  MOBILE
            Text(
              sdm.mobile ?? "",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            ///  DEPARTMENT
            Text(
              sdm.department ?? "",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 12),

            /// VIEW TEXT (simple)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "View Details →",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  Reusable icon button
  Widget _iconBtn(IconData icon, Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Consumer<CollectorSDMListController>(
        builder: (BuildContext context, collectorSDMListController , child) {

          if (collectorSDMListController.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          final data = collectorSDMListController.collectorSdmListModel;

          if (data == null || data.data!.juniorOfficers.isEmpty) {
            return const EmptyState(
              message: "No Data found!",
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
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF6B35),
                          Color(0xFFFF8C42),
                          Color(0xFFFFA62E),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                                const SizedBox(width: 18),
                                Text(
                                  userType == "Collector" ? "SDM Management" : "Employee Management",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userType == "Collector" ? "Total SDMs" : "Total Employe's",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                         "${data.data!.totalJuniorOfficers}",
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
                delegate: _StatsHeaderDelegate(userType),
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
                        sdmListData: collectorSDMListController.filterCollectorSdmList,
                        index: index,
                        colletId: collectorSDMListController.collectorSdmListModel?.data!.seniorId
                      ),
                    );
                  },
                  childCount: collectorSDMListController.filterCollectorSdmList.length,
                ),
              ),

              // Bottom spacing
             // SliverToBoxAdapter(child: SizedBox(height: 100),),
            ],
          );
        },
      ),
    );
  }
}

class _StatsHeaderDelegate extends SliverPersistentHeaderDelegate {

  String userType = "";
  _StatsHeaderDelegate(this.userType);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Consumer<CollectorSDMListController>(
        builder: (BuildContext context, collectorSDMController, child) {
          return Column(
            children: [
              SizedBox(height: 40,),
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
                            collectorSDMController.searchSDMList(value);
                          },
                          decoration: InputDecoration(
                            hintText:  userType == "Collector" ? "Search SDM by name, email..." : "Search Employe by name, email...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                            ),
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
                          colors: [
                            Color(0xFFFF6B35),
                            Color(0xFFFFA62E),
                          ],
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
