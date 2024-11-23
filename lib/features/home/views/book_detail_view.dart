import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/common/app_loader.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/features/home/view_models/book_detail_view_model.dart';
import 'package:piton/features/home/widgets/book_detail_bottom_bar.dart';
import 'package:piton/features/home/widgets/book_details_section.dart';
import 'package:piton/features/home/widgets/custom_sliver_app_bar.dart';

class BookDetailView extends ConsumerStatefulWidget {
  final int bookId;
  static const routeName = "/book_detail_view";
  const BookDetailView({super.key, required this.bookId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends ConsumerState<BookDetailView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(bookDetailViewModelPr.notifier).getBookById(widget.bookId));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(bookDetailViewModelPr).when(
        data: (book) {
          return Scaffold(
            bottomNavigationBar: BookDetailBottomBar(
              book: book,
            ),
            body: CustomScrollView(
              slivers: [
                const CustomSliverAppBar(text: "Book Details"),
                BookDetailsSection(
                  book: book,
                ),

                // Kitap Özeti
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                  child: Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).toSliver,

                // Kitap Açıklaması
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    book.description ?? "Kitap açıklaması",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B87),
                    ),
                  ),
                ).toSliver,
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return ErrorView(
            errorMessage: error.toString(),
            onRetry: () {
              ref.read(bookDetailViewModelPr.notifier).getBookById(widget.bookId);
            },
          );
        },
        loading: () => const LoadingView());
  }
}
