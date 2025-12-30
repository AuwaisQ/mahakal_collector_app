// services/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  bool _isConnected = true;
  bool _showNoInternet = false;

  bool get isConnected => _isConnected;
  bool get showNoInternet => _showNoInternet;

  // Initialize connectivity monitoring
  void initialize() {
    _checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus as void Function(List<ConnectivityResult> event)?,
    ) as StreamSubscription<ConnectivityResult>?;
  }

  // Check initial connectivity
  Future<void> _checkConnectivity() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      _updateConnectionStatus(connectivityResult as ConnectivityResult);
    } catch (e) {
      print('Error checking connectivity: $e');
    }
  }

  // Update connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    bool wasConnected = _isConnected;

    if (result == ConnectivityResult.none) {
      _isConnected = false;
      _showNoInternet = true;
    } else {
      _isConnected = true;
      _showNoInternet = false;
    }

    // Notify only if status changed
    if (wasConnected != _isConnected) {
      notifyListeners();
    }
  }

  // Manually check connection
  Future<bool> checkConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Dispose
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}