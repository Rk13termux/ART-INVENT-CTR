import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'inventory_item_model.g.dart';

@JsonSerializable()
class InventoryItem {
  final String id;
  final String productId;
  final String productName;
  final double quantity;
  final String unit;
  final double weightKilos;
  final double purchasePrice;
  final double sellingPrice;
  final String supplier;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final String batchNumber;
  final String location;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  InventoryItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unit,
    required this.weightKilos,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.supplier,
    required this.purchaseDate,
    required this.expiryDate,
    required this.batchNumber,
    required this.location,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InventoryItem.create({
    required String productId,
    required String productName,
    required double quantity,
    required String unit,
    required double weightKilos,
    required double purchasePrice,
    required double sellingPrice,
    required String supplier,
    required DateTime purchaseDate,
    required DateTime expiryDate,
    required String batchNumber,
    required String location,
    String? notes,
  }) {
    final now = DateTime.now();
    return InventoryItem(
      id: const Uuid().v4(),
      productId: productId,
      productName: productName,
      quantity: quantity,
      unit: unit,
      weightKilos: weightKilos,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      supplier: supplier,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate,
      batchNumber: batchNumber,
      location: location,
      status: _calculateStatus(expiryDate),
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  static String _calculateStatus(DateTime expiryDate) {
    final now = DateTime.now();
    final daysUntilExpiry = expiryDate.difference(now).inDays;
    
    if (daysUntilExpiry < 0) return 'expired';
    if (daysUntilExpiry <= 2) return 'critical';
    if (daysUntilExpiry <= 5) return 'warning';
    return 'fresh';
  }

  InventoryItem copyWith({
    String? id,
    String? productId,
    String? productName,
    double? quantity,
    String? unit,
    double? weightKilos,
    double? purchasePrice,
    double? sellingPrice,
    String? supplier,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    String? batchNumber,
    String? location,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      weightKilos: weightKilos ?? this.weightKilos,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      supplier: supplier ?? this.supplier,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      batchNumber: batchNumber ?? this.batchNumber,
      location: location ?? this.location,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isExpired => status == 'expired';
  bool get isCritical => status == 'critical';
  bool get needsAttention => isExpired || isCritical || status == 'warning';
  
  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;
  
  double get totalValue => quantity * sellingPrice;

  factory InventoryItem.fromJson(Map<String, dynamic> json) => _$InventoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  @override
  String toString() {
    return 'InventoryItem(id: $id, productName: $productName, quantity: $quantity $unit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InventoryItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
