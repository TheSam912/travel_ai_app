import 'package:map_launcher/map_launcher.dart';

class HomeItem {
  String title;
  String image;
  String location;
  bool isFavorite;
  Coords coords;

  HomeItem(this.title, this.image, this.location, this.isFavorite, this.coords);
}
