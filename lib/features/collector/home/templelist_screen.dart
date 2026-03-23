import 'package:collectorapp/features/collector/home/model/collectortemplelist_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'collectordetails_screen.dart';
import 'controller/collectortemplelist_controller.dart';

class TempleListScreen extends StatefulWidget {
  final String templeId;
  const TempleListScreen({Key? key, required this.templeId}) : super(key: key);

  @override
  State<TempleListScreen> createState() => _TempleListScreenState();
}

class _TempleListScreenState extends State<TempleListScreen> {
  bool _isGridView = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CollectorTempleListController>().fetchCollectorTempleList(
        widget.templeId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CollectorTempleListController>(
        builder: (BuildContext context, controller, child) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          final data = controller.filterTempleList;
          final selectedFilter = controller.selectedFilter;

          return CustomScrollView(
            slivers: [

              // Header Section (same as before)...
              SliverAppBar(
                expandedHeight: 200,
                collapsedHeight: 80,
                automaticallyImplyLeading: false,
                floating: false,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF6B35),
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
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    "Temple Directory",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                // // View Toggle
                                // Container(
                                //   width: 40,
                                //   height: 40,
                                //   decoration: BoxDecoration(
                                //     color: Colors.white.withOpacity(0.2),
                                //     borderRadius: BorderRadius.circular(12),
                                //   ),
                                //   child: IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         _isGridView = !_isGridView;
                                //       });
                                //     },
                                //     icon: Icon(
                                //       _isGridView
                                //           ? Icons.view_list_rounded
                                //           : Icons.grid_view_rounded,
                                //       color: Colors.white,
                                //       size: 20,
                                //     ),
                                //     padding: EdgeInsets.zero,
                                //   ),
                                // ),
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
                                        Icons.temple_buddhist_rounded,
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
                                          "Total Temples",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.9),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${data.length}",
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
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.schedule_rounded,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Live Status",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                  ),
                ),
              ),

              // Floating stats cards (appears below header when scrolled)
              SliverPersistentHeader(
                pinned: true,
                delegate: _StatsHeaderDelegate(),
              ),

              if (data.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Showing ${data.length} temple${data.length == 1 ? '' : 's'} ${selectedFilter != 'All' ? '($selectedFilter)' : ''}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

              // Empty State or Temple List
              if (data.isEmpty)
                SliverFillRemaining(
                  child: _buildEmptyState(selectedFilter),
                )
              else if (_isGridView)
                _buildGridView(data)
              else
                _buildListView(data),

              // Bottom spacing (only when there's data)
              if (data.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
            ],
          );
        },
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState(String selectedFilter) {
    String message = "No temples found";
    IconData icon = Icons.temple_buddhist_outlined;
    String subtitle = "Try changing your search or filter";

    if (selectedFilter == 'Open Now') {
      message = "No temples are open right now";
      icon = Icons.access_time_filled_rounded;
      subtitle = "Check back during temple hours";
    } else if (selectedFilter == 'Closed Now') {
      message = "All temples are currently open";
      icon = Icons.check_circle_outline_rounded;
      subtitle = "Great! All temples are accessible";
    } else if (selectedFilter == 'Morning') {
      message = "No morning temples found";
      icon = Icons.wb_sunny_outlined;
      subtitle = "Try different filters";
    } else if (selectedFilter == 'Evening') {
      message = "No evening temples found";
      icon = Icons.nightlight_round_outlined;
      subtitle = "Try different filters";
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 50,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 30),
              Text(
                message,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              if (selectedFilter != 'All')
                ElevatedButton(
                  onPressed: () {
                    context.read<CollectorTempleListController>().applyFilter('All');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6B35),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    "Show All Temples",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Grid View Builder
  Widget _buildGridView(List<TempleList> templeList) {
    return SliverPadding(
      padding: EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.60,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final temple = templeList[index];
            return TempleGridCard(temple: temple, index: index);
          },
          childCount: templeList.length,
        ),
      ),
    );
  }

  // List View Builder
  Widget _buildListView(List<TempleList> templeList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final temple = templeList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: TempleListCard(temple: templeList, index: index),
          );
        },
        childCount: templeList.length,
      ),
    );
  }
}

class _StatsHeaderDelegate extends SliverPersistentHeaderDelegate {

  _StatsHeaderDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isScrolled = shrinkOffset > 0;

    return Consumer<CollectorTempleListController>(
      builder: (BuildContext context, collectorTempleListController , child) {

        final selectedFilter = collectorTempleListController.selectedFilter;
        final filters = collectorTempleListController.availableFilters;

        return Container(
          color: Colors.grey.shade50,
          child: Column(
            children: [

              SizedBox(height: 20,),

              // Search Bar
              Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(10),
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
                            collectorTempleListController.searchTempleList(value);
                          },
                          decoration: InputDecoration(
                            hintText: "Search SDM by name, email...",
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
              
              // Filter Chips
              Container(
                height: 40,
                margin: EdgeInsets.all(10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = selectedFilter == filter;

                    Color chipColor = Colors.grey;
                    if (filter == 'Open Now') chipColor = Colors.green;
                    if (filter == 'Closed Now') chipColor = Colors.red;
                    if (filter == 'Morning') chipColor = Colors.orange;
                    if (filter == 'Evening') chipColor = Colors.purple;

                    return GestureDetector(
                      onTap: () => collectorTempleListController.applyFilter(filter),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                            colors: [
                              Color(0xFFFF6B35),
                              Color(0xFFFFA62E),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: chipColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              filter,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  double get maxExtent => 190;

  @override
  double get minExtent => 175;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


class TempleGridCard extends StatelessWidget {
  final TempleList temple;
  final int index;

  const TempleGridCard({Key? key, required this.temple, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CollectorTempleListController>();
    final isOpen = controller.checkIfOpenNow(temple);
    final openingTime = controller.formatTime(temple.openingTime ?? '05:00:00');
    final closingTime = controller.formatTime(temple.closeingTime ?? '19:00:00');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
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
            // Navigate to temple details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CollectorDetailsScreen(
                  mandirId: '${temple.templeId}',
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Section (same as before)...
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      // Image loading...
                      // Open/Closed Badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isOpen
                                ? Colors.green.withOpacity(0.9)
                                : Colors.red.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                isOpen ? 'OPEN' : 'CLOSED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Section...
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          temple.name ?? 'Temple Name',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              color: Colors.grey.shade600,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '$openingTime - $closingTime',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF6B35),
                                Color(0xFFFFA62E),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class TempleListCard extends StatelessWidget {
  final List<TempleList> temple;
  final int index;

  const TempleListCard({Key? key, required this.temple, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final openingTime = temple[index].openingTime ?? '05:00:00';
    final closingTime = temple[index].closeingTime ?? '19:00:00';
    final isOpen = _checkIfOpen(openingTime, closingTime);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
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
            // Navigate to temple details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CollectorDetailsScreen(mandirId: '${temple[index].templeId}',),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: temple[index] != null
                        ? DecorationImage(
                      image: NetworkImage(temple[index].thumbnail ?? ''),
                      fit: BoxFit.cover,
                    )
                        : null,
                    color: Colors.grey.shade200,
                  ),
                  child: temple[index].thumbnail == null
                      ? Center(
                    child: Icon(
                      Icons.temple_buddhist_rounded,
                      color: Colors.grey.shade400,
                      size: 40,
                    ),
                  )
                      : null,
                ),

                SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Status
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              temple[index].name ?? 'Temple Name',
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isOpen
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isOpen
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.red.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: isOpen ? Colors.green : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  isOpen ? 'Open Now' : 'Closed',
                                  style: TextStyle(
                                    color: isOpen
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      // Timing
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            color: Colors.grey.shade600,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${_formatTime(openingTime)} - ${_formatTime(closingTime)}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
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
                              ),
                              child: Center(
                                child: Text(
                                  "View Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Direction functionality
                              },
                              icon: Icon(
                                Icons.directions_rounded,
                                color: Colors.orange,
                                size: 20,
                              ),
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

// Helper Functions
bool _checkIfOpen(String openingTime, String closingTime) {
  try {
    final now = TimeOfDay.now();
    final open = TimeOfDay.fromDateTime(
      DateFormat('HH:mm:ss').parse(openingTime),
    );
    final close = TimeOfDay.fromDateTime(
      DateFormat('HH:mm:ss').parse(closingTime),
    );

    final nowInMinutes = now.hour * 60 + now.minute;
    final openInMinutes = open.hour * 60 + open.minute;
    final closeInMinutes = close.hour * 60 + close.minute;

    return nowInMinutes >= openInMinutes && nowInMinutes <= closeInMinutes;
  } catch (e) {
    return false;
  }
}

String _formatTime(String timeString) {
  try {
    final time = DateFormat('HH:mm:ss').parse(timeString);
    return DateFormat('hh:mm a').format(time);
  } catch (e) {
    return timeString;
  }
}