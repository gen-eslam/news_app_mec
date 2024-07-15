abstract class EndPoints {
  static const String baseUrl = 'https://newsapi.org';
  static const String appleNews =
      "/v2/everything?q=apple&from=2024-07-04&to=2024-07-04&sortBy=popularity&apiKey=ac2243e6963d473ca6aff6457a9d213d";
}

abstract class StoreEndPoint {
  static const String baseUrl = 'https://fakestoreapi.com';
  //prodycts
  static const String products = "/products";

  static const String categories = "/products/categories";
  static String productsInASpecificCategory ({required String category})=> "/products/category/$category";
}
