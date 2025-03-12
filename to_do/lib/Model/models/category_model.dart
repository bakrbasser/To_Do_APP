class CategoryModel {
  final int id;
  final String name;
  final String color;

  Map<String, dynamic> toRow() {
    return {'name': name, 'color': color};
  }

  factory CategoryModel.fromJson(Map json) {
    return CategoryModel(
        id: json['id'], name: json['name'], color: json['color']);
  }

  CategoryModel({required this.id, required this.name, required this.color});
}
