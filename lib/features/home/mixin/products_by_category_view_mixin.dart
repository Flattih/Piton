import 'package:flutter/material.dart';
import 'package:piton/features/home/views/books_by_category_view.dart';

mixin ProductsByCategoryViewMixin on State<BooksByCategoryView> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
