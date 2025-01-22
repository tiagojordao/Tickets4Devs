class Event {
  final String id;
  final String title;
  final String description;
  final String localId;
  final String date;
  final String criador;
  final double price;
  final int totalTickets;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.localId,
    required this.date,
    required this.criador,
    required this.price,
    required this.totalTickets,
  });
}