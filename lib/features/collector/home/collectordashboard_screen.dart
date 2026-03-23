import 'package:cached_network_image/cached_network_image.dart';
import 'package:collectorapp/features/login/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui_helpers/empty_widget.dart';
import '../../../ui_helpers/noimage_widget.dart';
import '../../../ui_helpers/placeholder_widget.dart';
import '../../../ui_helpers/rupeeamount_widget.dart';
import '../../login/LoginScreen.dart';
import 'collectordetails_screen.dart';
import 'collectorsdmlist_screen.dart';
import 'controller/collectordashboard_controller.dart';
import 'model/collectordashboard_model.dart';

class CollectorDashboardScreen extends StatefulWidget {
  const CollectorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CollectorDashboardScreen> createState() =>
      _CollectorDashboardScreenState();
}

class _CollectorDashboardScreenState extends State<CollectorDashboardScreen> {

  String userType = "";

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthController>();
    userType = auth.userType ?? '';

    Future.microtask(() {
      context.read<CollectorDashboardController>().fetchCollectorDashboard();
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            children: const [
              Icon(Icons.logout_rounded, color: Colors.deepOrange),
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?\nYou will need to login again.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                /// STEP 1: READ PROVIDER FIRST (IMPORTANT)
                final auth = context.read<AuthController>();

                /// STEP 2: CLOSE DIALOG
                Navigator.pop(dialogContext);

                /// STEP 3: REMOVE ALL SCREENS FIRST
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );

                /// STEP 4: LOGOUT (STATE CLEAR)
                await auth.logout();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Consumer<CollectorDashboardController>(
        builder: (BuildContext context, collectorController, Widget? child) {
          if (collectorController.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          final data = collectorController.collectorDashModel;

          if (data == null || data.data!.temples.isEmpty) {
            return const EmptyState(
              message: "No collector data found!",
              icon: Icons.collections_bookmark_outlined,
            );
          }

          return RefreshIndicator(
            color: Colors.deepOrange,
            onRefresh: () async{
              Future.microtask(() {
                context.read<CollectorDashboardController>().fetchCollectorDashboard();
              });
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: userType == "SDM" ? 130 : 150,
                  collapsedHeight: 80,
                  automaticallyImplyLeading: false,
                  floating: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      final top = constraints.biggest.height;
                      final isCollapsed = top <= 80;
                      return FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: false,
                        titlePadding: EdgeInsets.only(left: 20),
                        title: isCollapsed
                            ? Text(
                                "${collectorController.collectorDashModel?.data?.name?.split(' ').first ?? 'Collector'}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : null,
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
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 60,
                              right: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Welcome section with name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    ///  Welcome + Logout Row
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Welcome, ",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: isCollapsed ? 12 : 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  "${userType ?? 'Collector'}\n",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: isCollapsed ? 16 : 22,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  "${collectorController.collectorDashModel?.data?.name ?? 'User'}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: isCollapsed ? 14 : 20,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        /// Logout Button
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () => _showLogoutDialog(context),
                                            icon: const Icon(
                                              Icons.logout_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    ///  Email + Type Badge Row
                                    Row(
                                      children: [
                                        Icon(Icons.email_outlined, color: Colors.white, size: 16),
                                        const SizedBox(width: 6),

                                        Expanded(
                                          child: Text(
                                            "${collectorController.collectorDashModel?.data?.email ?? 'N/A'}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        ///  TYPE BADGE
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent.withOpacity(0.9),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            userType ?? 'Collector',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    ///  Reported By (Stylish subtle text)
                                    userType == "SDM" ? Row(
                                      children: [
                                        Icon(Icons.person_pin, color: Colors.white70, size: 14),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Reported to ${collectorController.collectorDashModel?.data?.reportingTo}",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.85),
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ) : SizedBox.shrink()
                                  ],
                                ),

                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Floating stats cards (appears below header when scrolled)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StatsHeaderDelegate(),
                ),

                // Grid of Mandirs
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final mandirList = collectorController.filteredTemples[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CollectorDetailsScreen(
                                mandirId: '${mandirList.id}',
                              ),
                            ),
                          );
                        },
                        child: _mandirCard(mandirList),
                      );
                    }, childCount: collectorController.filteredTemples.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                  ),
                ),

                // Bottom padding for better scrolling
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          );
        },
      ),
    );
  }

  // Mandir Card Widget
  Widget _mandirCard(TemplesDetail mandir) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================= IMAGE WITH GRADIENT OVERLAY =================
          Stack(
            children: [
              // Background Image with enhanced styling
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: mandir.thumbnail ?? '',
                    height: 110, // Increased height
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => PlaceholderImage(),
                    errorWidget: (context, url, error) => NoImageWidget(),
                  ),
                ),
              ),

              // Multi-layer Gradient Overlay for depth
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.85),
                      ],
                      stops: [0.0, 0.3, 0.6, 0.8, 1.0],
                    ),
                  ),
                ),
              ),

              // Temple Name with beautiful container
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      // Temple Icon Badge
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.temple_hindu_outlined,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Temple Name with multiple styles
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main Temple Name
                            Text(
                              mandir.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 15,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(18),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withOpacity(0.8),
                        Colors.orange.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ================= LOCATION =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 18,
                  color: Colors.deepOrange.shade400,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "${mandir.city}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // ================= BADGES / TAGS =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                _badge(
                  isMandirOpen(mandir.openingTime ?? '', mandir.closeingTime ?? '')
                      ? "Open"
                      : "Closed",
                  isMandirOpen(mandir.openingTime ?? '', mandir.closeingTime ?? '')
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          const Spacer(),

          //================= FOOTER STRIP =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(0.10),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      size: 18,
                      color: Colors.deepOrange.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "View Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.deepOrange.shade700,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.deepOrange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  bool isMandirOpen(String openingTime, String closingTime) {
    final now = TimeOfDay.now();

    final openParts = openingTime.split(':');
    final closeParts = closingTime.split(':');

    final openTime = TimeOfDay(
      hour: int.parse(openParts[0]),
      minute: int.parse(openParts[1]),
    );

    final closeTime = TimeOfDay(
      hour: int.parse(closeParts[0]),
      minute: int.parse(closeParts[1]),
    );

    // Check if current time is between open and close
    bool afterOpen =
        now.hour > openTime.hour ||
        (now.hour == openTime.hour && now.minute >= openTime.minute);
    bool beforeClose =
        now.hour < closeTime.hour ||
        (now.hour == closeTime.hour && now.minute <= closeTime.minute);

    return afterOpen && beforeClose;
  }
}

// Custom SliverPersistentHeaderDelegate for stats cards
class _StatsHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StatsHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isScrolled = shrinkOffset > 0;

    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Consumer<CollectorDashboardController>(
        builder: (BuildContext context, collectorDashboardController, child) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      Icons.people,
                      "Visitors Today",
                      "${collectorDashboardController.collectorDashModel?.data?.totalUser}",
                      isScrolled: isScrolled,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      Icons.temple_hindu,
                      "Total Mandirs",
                      "${collectorDashboardController.collectorDashModel?.data?.totalTemple}",
                      isScrolled: isScrolled,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      Icons.currency_rupee,
                      "Total Amount",
                      "${collectorDashboardController.collectorDashModel?.data?.totalAmount}",
                      isScrolled: isScrolled,
                      isAmount: true
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Main content area (hidden when collapsed)
              Column(
                children: [
                  //  ATTRACTIVE NAVIGATION BUTTON for SDMs
                  GestureDetector(
                    onTap: () {
                      // Navigate to SDMs list screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SDMListScreen()),
                      );
                      print("Navigate to SDMs list");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Color(0xFFF8F9FA)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.9),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side: Icon and text
                          Row(
                            children: [
                              // Icon with gradient background
                              Container(
                                width: 45,
                                height: 45,
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
                                      color: Colors.orange.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.people_alt_rounded,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),

                              // Text content
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MANAGE SDMs",
                                    style: TextStyle(
                                      color: Color(0xFFFF6B35),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "View all SDMs under jurisdiction",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      "20",
                                      //"${collectorDashboardController.collectorDashModel?.collectorDetail?.totalSdm} SDMs assigned",
                                      style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Right arrow
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF6B35), Color(0xFFFFA62E)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.white, Colors.red.shade50],
                  ),
                  border: Border.all(color: Colors.red.shade200, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.search_rounded,
                        color: Color(0xFFFF6B35),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          collectorDashboardController.upDateSearchQuery(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search mandir...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B35).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.filter_list_rounded,
                        color: Color(0xFFFF6B35),
                        size: 18,
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

  Widget _buildStatCard(
    BuildContext context,
    IconData icon,
    String title,
    String value, {
    bool isScrolled = false,
    bool isAmount = false,
      }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(isScrolled ? 12 : 14),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFF6B35).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color(0xFFFF6B35),
              size: isScrolled ? 20 : 22,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: isScrolled ? 11 : 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          /// 🔥 AMOUNT / NORMAL TEXT
          isAmount
              ? RupeeAmountText(
            amount: value,
            fontSize: isScrolled ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
              : Text(
            value,
            style: TextStyle(
              fontSize: isScrolled ? 16 : 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 340;

  @override
  double get minExtent => 325;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
