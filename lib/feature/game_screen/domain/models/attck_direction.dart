class AttackDirection{
  final int row;
  final int column;

  @override
  String toString() {
    return 'AttackDirection{row: $row, column: $column}';
  }

  AttackDirection({required this.row, required this.column});
}