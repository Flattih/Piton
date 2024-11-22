import 'package:flutter/material.dart';
import 'package:piton/features/home/home_view.dart';

mixin HomeViewMixin on State<HomeView> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
