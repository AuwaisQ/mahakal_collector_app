import 'package:cached_network_image/cached_network_image.dart';
import 'package:collectorapp/features/sdm/home/controller/sdmdetails_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../ui_helpers/empty_widget.dart';
import '../../../ui_helpers/noimage_widget.dart';
import '../../../ui_helpers/placeholder_widget.dart';
import '../../../ui_helpers/rupeeamount_widget.dart';
import '../../collector/home/controller/collectoramountfilter_controller.dart' hide FilterType;
import '../../collector/home/model/amountfilter_model.dart';
import '../../login/controller/auth_controller.dart';
import 'controller/sdmamount_controller.dart';
import 'model/sdmamountfilter_model.dart';
import 'model/sdmdetails_model.dart';

class SDMDetailsScreen extends StatefulWidget {
  final String mandirId;

  SDMDetailsScreen({required this.mandirId});

  @override
  State<SDMDetailsScreen> createState() => _SDMDetailsScreenState();
}

class _SDMDetailsScreenState extends State<SDMDetailsScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SDMDetailsController>().fetchCollectorDetails(
        widget.mandirId,
      );
    });
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) return "-";
    try {
      // Parse the 24-hour format string
      final parsedTime = DateFormat("HH:mm:ss").parse(time);
      // Format to 12-hour AM/PM
      return DateFormat.jm().format(parsedTime); // Example: 05:00 AM
    } catch (e) {
      return time; // Agar koi error ho to original string return kare
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _mainAppBar("Mandir Details"),
      body: Consumer<SDMDetailsController>(
        builder: (BuildContext context, sdmDetailsController, Widget? child) {
          if (sdmDetailsController.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          final data = sdmDetailsController.sdmDetailsModel;

          if (data == null || data.temple == null) {
            return const EmptyState(
              message: "No mandir data found!",
              icon: Icons.collections_bookmark_outlined,
            );
          }

          return RefreshIndicator(
            color: Colors.deepOrange,
            onRefresh: () async{
              Future.microtask(() {
                context.read<SDMDetailsController>().fetchCollectorDetails(
                  widget.mandirId,
                );
              });
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TEMPLE NAME SECTION
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Background Image with Gradient Overlay
                          CachedNetworkImage(
                            imageUrl: "${data.temple?.thumbnail}",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const PlaceholderImage(),
                            errorWidget: (context, url, error) => const NoImageWidget(),
                          ),

                          // Dark Gradient Overlay for better text visibility
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),

                          // Temple Name with beautiful styling
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Temple Name with Icon
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.temple_hindu_rounded,
                                          color: Colors.orange,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          '${data.temple?.name}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 10,
                                                color: Colors.black,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Decorative top right corner
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.star_border_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),

                          // Subtle pattern overlay for depth
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: RadialGradient(
                                  center: Alignment.center,
                                  radius: 1.5,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.05),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // City & State Row
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.orange,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "${data.temple?.cities?.city}, ${data.temple?.states?.name}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Opening & Closing Time Row
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.green,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Open: ${formatTime("${data.temple?.openingTime}")}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4B5563),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.access_time_outlined,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Close: ${formatTime("${data.temple?.closeingTime}")}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4B5563),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// PAYMENT SUMMARY
                  _titleWidget("Payment Summary", Icons.currency_rupee),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child:Column(
                      children: [
                        AmountCardsWithFilter(
                          data: data, // Your collector details data
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// VISITOR SUMMARY
                  _titleWidget("Visitor Analytics", Icons.analytics_outlined),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _visitorStatCard(
                          title: "Verified",
                          count: "180",
                          color: const Color(0xFF10B981),
                          iconBg: const Color(0xFFD1FAE5),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _visitorStatCard(
                          title: "Unverified",
                          count: "25",
                          color: const Color(0xFFEF4444),
                          iconBg: const Color(0xFFFEE2E2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _visitorStatCard(
                          title: "Total",
                          count: "${data.collectionSummary?.totalUser}",
                          color: const Color(0xFF3B82F6),
                          iconBg: const Color(0xFFDBEAFE),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// STATS OVERVIEW
                  _titleWidget("Collection Summary", Icons.analytics),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _quickStatItem(
                                label: "Puja Amount",
                                value: "${data.collectionSummary?.pujaAmount}",
                                icon: Icons.yard,
                                color: const Color(0xFF3B82F6),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _quickStatItem(
                                label: "Darshan Amount",
                                value: "${data.collectionSummary?.darshanAmount}",
                                icon: Icons.remove_red_eye_rounded,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: _quickStatItem(
                                label: "Locker Amount",
                                value: "${data.collectionSummary?.lockerAmount}",
                                icon: Icons.lock_clock,
                                color: const Color(0xFF8B5CF6),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _quickStatItem(
                                label: "Bhojan Amount",
                                value: "${data.collectionSummary?.bhojanAmount}",
                                icon: Icons.emoji_food_beverage,
                                color: const Color(0xFFF59E0B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _paymentStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color iconBg,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title on top
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Icon
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 10),

        // Value
        RupeeAmountText(
          amount: value,
          fontSize: 22,
          color: color,
          fontWeight:FontWeight.bold,
        )
      ],
    );
  }

  Widget _visitorStatCard({
    required String title,
    required String count,
    required Color color,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.people_rounded, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

        ],
      ),
    );
  }


  // ---------------------------------------------------
  Widget _quickStatItem({
    required String label,
    required String value, // <-- FIX: num instead of String
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),

          // IMPORTANT: Expanded to prevent overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RupeeAmountText(
                  amount: value,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _titleWidget(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        SizedBox(width: 8),
        Text(
          "$title",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _mainAppBar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.deepOrange
        ),
      ),

      title: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // // Right Icon
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(.25),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: const Icon(
          //     Icons.notifications_none,
          //     color: Colors.white,
          //     size: 22,
          //   ),
          // ),
        ],
      ),
    );
  }
}


class AmountCardsWithFilter extends StatefulWidget {
  final SdmDetailsModel data;

  const AmountCardsWithFilter({Key? key, required this.data}) : super(key: key);

  @override
  State<AmountCardsWithFilter> createState() => _AmountCardsWithFilterState();
}

class _AmountCardsWithFilterState extends State<AmountCardsWithFilter> {
  DateTime? _selectedDate;
  FilterType _currentFilter = FilterType.daily;
  bool _isFiltered = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _onTabSelected(_currentFilter);
      print("Amount Filter Called");
    });
   // _onTabSelected(_currentFilter);
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });

      // Apply filter with new date
      _onTabSelected(FilterType.daily);
    }
  }

  void _applyFilter(BuildContext context) {
    setState(() {
      _isFiltered = true;
    });

    final filterController = context.read<SDMAmountFilterController>();
    filterController.fetchAmountFilter(
      filterType: _currentFilter,
      selectedDate: _selectedDate!, templeId: '${widget.data.temple?.id}',
    );
  }

  void _onTabSelected(FilterType type) {
    setState(() {
      _currentFilter = type;
      _isFiltered = true;
    });
    _applyFilter(context);
  }

  void _clearFilter() {
    setState(() {
      _selectedDate = DateTime.now();
      _isFiltered = false;
      _currentFilter = FilterType.daily;
    });

    context.read<SDMAmountFilterController>().clearFilter();
  }

  // Helper methods to get display data
  dynamic _getDisplayData(SDMAmountFilterController filterController) {

    if (_isFiltered && filterController.amountFilterModel != null) {
      print("Display Data Worked${filterController.amountFilterModel!.sdmDetail?.cashAmount}");
      return filterController.amountFilterModel!;
    } else {
      print("Display Data Worked Else${widget.data.collectionSummary?.cashAmount}");
      return widget.data;
    }
  }

  String _getCashAmount(dynamic data) {
    if (data is SdmAmountFilterModel) {

      print("Cash Collector Worked ${data.sdmDetail?.cashAmount}");
      return "${data.sdmDetail?.cashAmount ?? 0}";

    } else if (data is SdmDetailsModel) {
      print("Cash SDMDetail Worked ${data.collectionSummary?.cashAmount}");
      return "${data.collectionSummary?.cashAmount ?? 0}";
    }
    return "0";
  }

  String _getOnlineAmount(dynamic data) {
    print("Online Worked");
    if (data is SdmAmountFilterModel) {
      return "${data.sdmDetail?.onlineAmount ?? 0}";
    } else if (data is SdmDetailsModel) {
      return "${data.collectionSummary?.onlineAmount ?? 0}";
    }
    return "0";
  }

  String _getTotalAmount(dynamic data) {
    print("Total Worked");
    if (data is SdmAmountFilterModel) {
      return "${data.sdmDetail?.totalAmount ?? 0}";
    } else if (data is SdmDetailsModel) {
      return "${data.collectionSummary?.totalAmount ?? 0}";
    }
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SDMAmountFilterController>(
      builder: (context, filterController, child) {
        final displayData = _getDisplayData(filterController);

        return Column(
          children: [
            // Tabs Section
            _buildFilterTabs(),
            const SizedBox(height: 12),

            // Filter Header
            _buildFilterHeader(filterController),
            const SizedBox(height: 12),

            filterController.isLoading && _isFiltered
                ? _buildLoadingCards()
                : _buildCards(displayData),
          ],
        );
      },
    );
  }

  // Filter Tabs Widget
  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildFilterTab(
            label: 'Daily',
            type: FilterType.daily,
            icon: Icons.today,
          ),
          _buildFilterTab(
            label: 'Weekly',
            type: FilterType.weekly,
            icon: Icons.date_range,
          ),
          _buildFilterTab(
            label: 'Monthly',
            type: FilterType.monthly,
            icon: Icons.calendar_view_month,
          ),
          _buildFilterTab(
            label: 'Yearly',
            type: FilterType.yearly,
            icon: Icons.event_note,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab({
    required String label,
    required FilterType type,
    required IconData icon,
  }) {
    final isSelected = _currentFilter == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.red.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.red : Colors.grey[600],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.red : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated Filter Header
  Widget _buildFilterHeader(SDMAmountFilterController filterController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _isFiltered ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isFiltered ? Colors.orange.withOpacity(0.3) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Selected Date & Filter Info
          Row(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(6),
              //   decoration: BoxDecoration(
              //     color: _isFiltered ? Colors.orange : Colors.grey[300],
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Icon(
              //     _getFilterIcon(),
              //     size: 18,
              //     color: _isFiltered ? Colors.white : Colors.grey[700],
              //   ),
              // ),
              // const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getFilterTitle(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _isFiltered ? Colors.orange[800] : Colors.grey[700],
                    ),
                  ),
                  Text(
                    _isFiltered ? '${_getFilterTypeText()} Filter' : 'All Time Data',
                    style: TextStyle(
                      fontSize: 11,
                      color: _isFiltered ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Filter Buttons
          Row(
            children: [
              // if (_isFiltered)
              //   GestureDetector(
              //     onTap: _clearFilter,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //       decoration: BoxDecoration(
              //         color: Colors.red[50],
              //         borderRadius: BorderRadius.circular(8),
              //         border: Border.all(color: Colors.red),
              //       ),
              //       child: Row(
              //         children: [
              //           Icon(Icons.clear, size: 16, color: Colors.red),
              //           SizedBox(width: 4),
              //           Text(
              //             'Clear',
              //             style: TextStyle(
              //               fontSize: 12,
              //               color: Colors.red,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // const SizedBox(width: 8),
              // Date Picker Button
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper methods for filter UI
  IconData _getFilterIcon() {
    switch (_currentFilter) {
      case FilterType.daily:
        return Icons.today;
      case FilterType.weekly:
        return Icons.date_range;
      case FilterType.monthly:
        return Icons.calendar_view_month;
      case FilterType.yearly:
        return Icons.event_note;
    }
  }

  String _getFilterTypeText() {
    switch (_currentFilter) {
      case FilterType.daily:
        return 'Daily';
      case FilterType.weekly:
        return 'Weekly';
      case FilterType.monthly:
        return 'Monthly';
      case FilterType.yearly:
        return 'Yearly';
    }
  }

  String _getFilterTitle() {
    if (!_isFiltered) return 'All Time Data';

    if (_selectedDate == null) return 'Select Date';

    switch (_currentFilter) {
      case FilterType.daily:
        return DateFormat('dd MMM yyyy').format(_selectedDate!);
      case FilterType.weekly:
      // Get Monday of the week
        final startOfWeek = _selectedDate!.subtract(Duration(days: _selectedDate!.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return '${DateFormat('dd MMM').format(startOfWeek)} - ${DateFormat('dd MMM ').format(endOfWeek)}';
      case FilterType.monthly:
        return DateFormat('MMMM yyyy').format(_selectedDate!);
      case FilterType.yearly:
        return _selectedDate!.year.toString();
    }
  }

  // Loading State Cards
  Widget _buildLoadingCards() {
    return Row(
      children: [
        Expanded(child: _buildShimmerCard()),
        Container(width: 1, height: 50, color: Colors.grey[200]),
        Expanded(child: _buildShimmerCard()),
        Container(width: 1, height: 50, color: Colors.grey[200]),
        Expanded(child: _buildShimmerCard()),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ],
    );
  }

  // Actual Cards
  Widget _buildCards(dynamic displayData) {
    return Row(
      children: [
        Expanded(
          child: _paymentStatCard(
            title: "Cash",
            value: _getCashAmount(displayData),
            icon: Icons.currency_rupee_rounded,
            color: const Color(0xFF10B981),
            iconBg: const Color(0xFFD1FAE5),
          ),
        ),
        Container(width: 1, height: 50, color: Colors.grey[200]),
        Expanded(
          child: _paymentStatCard(
            title: "Online",
            value: _getOnlineAmount(displayData),
            icon: Icons.phone_iphone,
            color: const Color(0xFF3B82F6),
            iconBg: const Color(0xFFDBEAFE),
          ),
        ),
        Container(width: 1, height: 50, color: Colors.grey[200]),
        Expanded(
          child: _paymentStatCard(
            title: "Total",
            value: _getTotalAmount(displayData),
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF8B5CF6),
            iconBg: const Color(0xFFEDE9FE),
          ),
        ),
      ],
    );
  }

  Widget _paymentStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color iconBg,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 10),
        RupeeAmountText(
          amount: value,
          fontSize: 22,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

// class AmountCardsWithFilter extends StatefulWidget {
//   final SdmDetailsModel data; // Your collector details data
//
//   const AmountCardsWithFilter({Key? key, required this.data}) : super(key: key);
//
//   @override
//   State<AmountCardsWithFilter> createState() => _AmountCardsWithFilterState();
// }
//
// class _AmountCardsWithFilterState extends State<AmountCardsWithFilter> {
//   DateTime? _selectedDate;
//   bool _isFiltered = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = DateTime.now();
//   }
//
//   Future<void> _showDatePicker(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000), // Starting from year 2000
//       lastDate: DateTime.now(), // Today's date as last date
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Colors.orange,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//             dialogBackgroundColor: Colors.white,
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _isFiltered = true;
//       });
//
//       final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
//       context.read<AmountFilterController>().fetchAmountFilter(formattedDate);
//     }
//   }
//
//   void _clearFilter() {
//     setState(() {
//       _selectedDate = DateTime.now();
//       _isFiltered = false;
//     });
//   }
//
//   // Helper method to get display data
//   dynamic _getDisplayData(AmountFilterController filterController) {
//     if (_isFiltered && filterController.amountFilterModel != null) {
//       return filterController.amountFilterModel!;
//     } else {
//       return widget.data;
//     }
//   }
//
//   // Helper method to get cash amount
//   String _getCashAmount(dynamic data) {
//     if (data is AmountFilterModel) {
//       return "${data.collectorDetail?.cashAmount ?? 0}";
//     } else if (data is SdmDetailsModel) {
//       return "${data.collectionSummary?.cashAmount ?? 0}";
//     }
//     return "0";
//   }
//
//   // Helper method to get online amount
//   String _getOnlineAmount(dynamic data) {
//     if (data is AmountFilterModel) {
//       return "${data.collectorDetail?.onlineAmount ?? 0}";
//     } else if (data is SdmDetailsModel) {
//       return "${data.collectionSummary?.onlineAmount ?? 0}";
//     }
//     return "0";
//   }
//
//   // Helper method to get total amount
//   String _getTotalAmount(dynamic data) {
//     if (data is AmountFilterModel) {
//       return "${data.collectorDetail?.totalAmount ?? 0}";
//     } else if (data is SdmDetailsModel) {
//       return "${data.collectionSummary?.totalAmount ?? 0}";
//     }
//     return "0";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AmountFilterController>(
//       builder: (context, filterController, child) {
//         final displayData = _getDisplayData(filterController);
//
//         return Column(
//           children: [
//
//             // Filter Header with Animation
//             _buildFilterHeader(filterController),
//             const SizedBox(height: 12),
//
//             filterController.isLoading && _isFiltered
//                 ? _buildLoadingCards()
//                 : _buildCards(displayData),
//           ],
//         );
//       },
//     );
//   }
//
//   // Filter Header Widget
//   Widget _buildFilterHeader(AmountFilterController filterController) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: _isFiltered ? Colors.orange.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: _isFiltered ? Colors.orange.withOpacity(0.3) : Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Selected Date Info
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: _isFiltered ? Colors.orange : Colors.grey[300],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   Icons.calendar_month,
//                   size: 18,
//                   color: _isFiltered ? Colors.white : Colors.grey[700],
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _selectedDate != null
//                         ? DateFormat('dd MMM yyyy').format(_selectedDate!)
//                         : 'Select Date',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: _isFiltered ? Colors.orange[800] : Colors.grey[700],
//                     ),
//                   ),
//                   Text(
//                     _isFiltered ? 'Filter Applied' : 'Showing All Data',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: _isFiltered ? Colors.green : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           // Filter Buttons
//           Row(
//             children: [
//               if (_isFiltered)
//                 GestureDetector(
//                   onTap: _clearFilter,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.red[50],
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.red),
//                     ),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.clear, size: 16, color: Colors.red),
//                       ],
//                     ),
//                   ),
//                 ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () => _showDatePicker(context),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: _isFiltered
//                           ? [Colors.blue, Colors.blueAccent]
//                           : [Colors.orange, Colors.deepOrangeAccent],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: (_isFiltered ? Colors.blue : Colors.orange).withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         _isFiltered ? Icons.edit_calendar : Icons.filter_alt,
//                         size: 18,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Loading State Cards
//   Widget _buildLoadingCards() {
//     return Row(
//       children: [
//         Expanded(child: _buildShimmerCard()),
//         Container(width: 1, height: 50, color: Colors.grey[200]),
//         Expanded(child: _buildShimmerCard()),
//         Container(width: 1, height: 50, color: Colors.grey[200]),
//         Expanded(child: _buildShimmerCard()),
//       ],
//     );
//   }
//
//   Widget _buildShimmerCard() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 40,
//           height: 12,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: 80,
//           height: 20,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(6),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Actual Cards - FIXED: Now accepts dynamic data
//   Widget _buildCards(dynamic displayData) {
//     return Row(
//       children: [
//         Expanded(
//           child: _paymentStatCard(
//             title: "Cash",
//             value: _getCashAmount(displayData),
//             icon: Icons.currency_rupee_rounded,
//             color: const Color(0xFF10B981),
//             iconBg: const Color(0xFFD1FAE5),
//           ),
//         ),
//         Container(width: 1, height: 50, color: Colors.grey[200]),
//         Expanded(
//           child: _paymentStatCard(
//             title: "Online",
//             value: _getOnlineAmount(displayData),
//             icon: Icons.phone_iphone,
//             color: const Color(0xFF3B82F6),
//             iconBg: const Color(0xFFDBEAFE),
//           ),
//         ),
//         Container(width: 1, height: 50, color: Colors.grey[200]),
//         Expanded(
//           child: _paymentStatCard(
//             title: "Total",
//             value: _getTotalAmount(displayData),
//             icon: Icons.account_balance_wallet,
//             color: const Color(0xFF8B5CF6),
//             iconBg: const Color(0xFFEDE9FE),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Your existing paymentStatCard with improvements
//   Widget _paymentStatCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//     required Color iconBg,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Color(0xFF6B7280),
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: iconBg,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Icon(icon, color: color, size: 22),
//         ),
//         const SizedBox(height: 10),
//         RupeeAmountText(
//           amount: value,
//           fontSize: 22,
//           color: color,
//           fontWeight: FontWeight.bold,
//         ),
//       ],
//     );
//   }
// }