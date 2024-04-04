
class Category{
  String? id;
  String? name;
  int? loai;
  String? image;

  Category(this.id, this.name, this.loai, this.image);




  Category fromJson(Map<String, dynamic> json){
    return Category(
      json['id'],
      json['name'],
      json['loai'],
      json['image'],
    );
  }
}