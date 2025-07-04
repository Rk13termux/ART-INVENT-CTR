import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'client_model.g.dart';

@JsonSerializable()
class Client {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? identification;
  final String clientType; // 'regular', 'wholesale', 'retail'
  final double creditLimit;
  final double currentDebt;
  final bool isActive;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Client({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.identification,
    this.clientType = 'regular',
    this.creditLimit = 0.0,
    this.currentDebt = 0.0,
    this.isActive = true,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Client.create({
    required String name,
    String? phone,
    String? email,
    String? address,
    String? identification,
    String clientType = 'regular',
    double creditLimit = 0.0,
    String? notes,
  }) {
    final now = DateTime.now();
    return Client(
      id: const Uuid().v4(),
      name: name,
      phone: phone,
      email: email,
      address: address,
      identification: identification,
      clientType: clientType,
      creditLimit: creditLimit,
      currentDebt: 0.0,
      isActive: true,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }

  Client copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? identification,
    String? clientType,
    double? creditLimit,
    double? currentDebt,
    bool? isActive,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      identification: identification ?? this.identification,
      clientType: clientType ?? this.clientType,
      creditLimit: creditLimit ?? this.creditLimit,
      currentDebt: currentDebt ?? this.currentDebt,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasDebt => currentDebt > 0;
  bool get isNearCreditLimit => currentDebt >= (creditLimit * 0.8);
  bool get isOverCreditLimit => currentDebt > creditLimit;
  double get availableCredit => creditLimit - currentDebt;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);

  @override
  String toString() {
    return 'Client(id: $id, name: $name, debt: $currentDebt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Client && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
