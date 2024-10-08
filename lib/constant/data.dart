import 'package:map_launcher/map_launcher.dart';
import 'package:travel_ai_app/models/item_home.dart';

List<String> countries = [
  'Germany',
  'Canada',
  'Italy',
  'Estonia',
  'Africa',
  'Dubai',
  'USA',
  'France',
  'UK',
  'Japan',
];
List<String> flags = [
  'assets/images/flags/germany_flag.png',
  'assets/images/flags/canada_flag.png',
  'assets/images/flags/italy_flag.png',
  'assets/images/flags/estonia_flag.png',
  'assets/images/flags/africa_flag.png',
  'assets/images/flags/emirates_flag.png',
  'assets/images/flags/usa_flag.png',
  'assets/images/flags/france_flag.png',
  'assets/images/flags/uk_flag.png',
  'assets/images/flags/japan_flag.png',
];

String loremIpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

List<HomeItem> homeItemList = [
  HomeItem(
      "Eiffel tower",
      "https://www.toureiffel.paris/themes/custom/tour_eiffel/build/images/home-discover-bg.jpg",
      "Paris, France",
      true,
      Coords(48.8584, 2.2945)),
  HomeItem(
      "Naples",
      "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?q=80&w=2675&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "Naples, Italy",
      false,
      Coords(40.8518, 14.2681)),
  HomeItem("Marienplatz", "https://cdn.foravisit.com/_munich/_/100010/i/w1368/marienplatz-1.jpg",
      "Munich, Germany", false, Coords(48.1374, 11.5754)),
  HomeItem(
      "Alexander Nevsky Cathedral",
      "https://images.unsplash.com/photo-1643888976443-9dbbb2e10bac?q=80&w=2728&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "Tallinn, Estonia",
      false,
      Coords(59.4358, 24.7392)),
  HomeItem(
      "Niagara",
      "https://imageio.forbes.com/specials-images/imageserve/62e5761e62f4cf7f929932d6/0x0.jpg?format=jpg&height=600&width=1200&fit=bounds",
      "Ontario, Canada",
      true,
      Coords(43.0896, 79.0849)),
  HomeItem(
      "Great Sphinx of Giza",
      "https://cdn.britannica.com/57/122157-004-D6B548F7/Side-view-Sphinx-Great-Pyramid-of-Khufu.jpg",
      "Giza, Egypt",
      true,
      Coords(29.9753, 31.1376)),
];
