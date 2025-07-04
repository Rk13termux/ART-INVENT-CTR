import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final String? imageUrl;
  final Map<String, double> unitWeights;
  final double basePrice;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.category,
    this.description = '',
    this.imageUrl,
    required this.unitWeights,
    required this.basePrice,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.create({
    required String name,
    required String category,
    String description = '',
    String? imageUrl,
    required Map<String, double> unitWeights,
    required double basePrice,
  }) {
    final now = DateTime.now();
    return Product(
      id: const Uuid().v4(),
      name: name,
      category: category,
      description: description,
      imageUrl: imageUrl,
      unitWeights: unitWeights,
      basePrice: basePrice,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    Map<String, double>? unitWeights,
    double? basePrice,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      unitWeights: unitWeights ?? this.unitWeights,
      basePrice: basePrice ?? this.basePrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
