import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashController with ChangeNotifier {
  static SplashController? _instance;

  factory SplashController() {
    _instance ??= SplashController._internal();
    return _instance!;
  }

  SplashController._internal();

  bool _hasInternet = true;
  bool _isLoading = true;
  bool _showOverlay = false;
  String _connectionMessage = 'Checking connection...';
  Timer? _checkTimer;
  Timer? _toastTimer;

  bool get hasInternet => _hasInternet;
  bool get isLoading => _isLoading;
  bool get showOverlay => _showOverlay;
  String get connectionMessage => _connectionMessage;

  final Connectivity _connectivity = Connectivity();

  // Real internet check using socket connection
  Future<bool> _hasRealInternet() async {
    try {
      // Try to connect to Google DNS
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  // Initialize with better check
  Future<void> initialize() async {
    try {
      // First check connectivity status
      List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();

      // Then do real internet check
      bool realInternet = await _hasRealInternet();

      // Check if any connectivity result is not none
      bool hasConnectivity = connectivityResult.isNotEmpty &&
          connectivityResult.any((result) => result != ConnectivityResult.none);

      // Update status
      _hasInternet = realInternet && hasConnectivity;

      _connectionMessage = _hasInternet
          ? 'Connected to internet'
          : 'No internet connection';

      _showOverlay = !_hasInternet;
      _isLoading = false;

      notifyListeners();

      // Start listening to connectivity changes - FIXED HERE
      _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);

    } catch (e) {
      print('Error initializing: $e');
      _hasInternet = false;
      _connectionMessage = 'Connection error';
      _showOverlay = true;
      _isLoading = false;
      notifyListeners();
    }
  }

  // FIXED: Now accepts List<ConnectivityResult>
  void _onConnectivityChanged(List<ConnectivityResult> results) async {
    bool previousStatus = _hasInternet;

    // Do real internet check
    bool realInternet = await _hasRealInternet();

    // Check if any result is not none
    bool hasConnectivity = results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);

    _hasInternet = realInternet && hasConnectivity;

    if (!_hasInternet) {
      _connectionMessage = 'No internet connection';
      _showOverlay = true;

      if (previousStatus) {
        _showNoInternetToast();
        _startPeriodicCheck();
      }
    } else {
      _connectionMessage = 'Connected to internet';
      _showOverlay = false;

      if (!previousStatus) {
        _showConnectedToast();
        _stopPeriodicCheck();
      }
    }
    notifyListeners();
  }

  // Manual check with real internet test
  Future<bool> checkConnection() async {
    try {
      List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();
      bool realInternet = await _hasRealInternet();

      bool hasConnectivity = connectivityResult.isNotEmpty &&
          connectivityResult.any((result) => result != ConnectivityResult.none);

      return realInternet && hasConnectivity;
    } catch (e) {
      return false;
    }
  }

  void _startPeriodicCheck() {
    _stopPeriodicCheck();

    _checkTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      bool isConnected = await checkConnection();

      if (isConnected && !_hasInternet) {
        timer.cancel();
        _hasInternet = true;
        _connectionMessage = 'Connected';
        _showOverlay = false;
        notifyListeners();
        _showConnectedToast();
      }
    });
  }

  void _stopPeriodicCheck() {
    _checkTimer?.cancel();
    _checkTimer = null;
  }

  void _showNoInternetToast() {
    _toastTimer?.cancel();

    Fluttertoast.showToast(
      msg: "No internet connection",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    _toastTimer = Timer(Duration(seconds: 3), () => Fluttertoast.cancel());
  }

  void _showConnectedToast() {
    _toastTimer?.cancel();

    Fluttertoast.showToast(
      msg: "Connected to internet",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    _toastTimer = Timer(Duration(seconds: 2), () => Fluttertoast.cancel());
  }

  void dispose() {
    _checkTimer?.cancel();
    _toastTimer?.cancel();
    _instance = null;
  }
}