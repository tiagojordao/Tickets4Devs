class Ticket {

  final String id;
  final String userId;
  final String eventId;
  final DateTime purchaseDate;
  final double price;

  Ticket({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.purchaseDate,
    required this.price,
  });
}
