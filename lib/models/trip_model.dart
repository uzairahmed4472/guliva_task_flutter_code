class Trip {
  int? id;
  String? createdAt;
  String? tripStartDate;
  String? tripEndDate;
  String? origin;
  String? destination;
  double? distanceCovered;
  double? amountBilled;
  int? userId;

  Trip({
    this.id,
    this.createdAt,
    this.tripStartDate,
    this.tripEndDate,
    this.origin,
    this.destination,
    this.distanceCovered,
    this.amountBilled,
    this.userId,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      createdAt: json['createdAt'],
      tripStartDate: json['tripStartDate'],
      tripEndDate: json['tripEndDate'],
      origin: json['origin'],
      destination: json['destination'],
      distanceCovered: (json['distanceCovered'] as num?)?.toDouble(),
      amountBilled: (json['amountBilled'] as num?)?.toDouble(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'tripStartDate': tripStartDate,
      'tripEndDate': tripEndDate,
      'origin': origin,
      'destination': destination,
      'distanceCovered': distanceCovered,
      'amountBilled': amountBilled,
      'userId': userId,
    };
  }
}
