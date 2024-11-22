import 'package:flutter/material.dart';
import 'package:piton/features/home/widgets/top_category.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TopCategory(
            type: TopCategoryType.all,
          ),
          TopCategory(
            type: TopCategoryType.classics,
          ),
          TopCategory(
            type: TopCategoryType.horror,
          ),
          TopCategory(
            type: TopCategoryType.romance,
          ),
        ],
      ),
    );
  }
}
