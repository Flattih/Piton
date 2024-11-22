import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_book_categories_response.g.dart';

@JsonSerializable()
class GetBookCategoriesResponse with EquatableMixin {
  final List<BookCategory>? category;

  GetBookCategoriesResponse({
    this.category,
  });

  GetBookCategoriesResponse copyWith({
    List<BookCategory>? category,
  }) =>
      GetBookCategoriesResponse(
        category: category ?? this.category,
      );

  factory GetBookCategoriesResponse.fromJson(Map<String, dynamic> json) => _$GetBookCategoriesResponseFromJson(json);

  @override
  List<Object?> get props => [category];
}

@JsonSerializable()
class BookCategory with EquatableMixin {
  final int? id;
  final String? name;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  BookCategory({
    this.id,
    this.name,
    this.createdAt,
  });

  BookCategory copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
  }) =>
      BookCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );

  factory BookCategory.fromJson(Map<String, dynamic> json) => _$BookCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BookCategoryToJson(this);

  @override
  List<Object?> get props => [id, name, createdAt];
}
