class TCategorey {
  final int id;
  final String name;
  final String color;
  TCategorey({
    this.id,
    this.name,
    this.color,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

class TTask {
  final int id;
  final int categoreyId;
  final String name;
  final int completed;
  TTask({
    this.id,
    this.categoreyId,
    this.name,
    this.completed,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoreyId': categoreyId,
      'completed': completed,
    };
  }
}
