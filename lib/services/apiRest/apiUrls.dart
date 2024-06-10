
class ApiUrl {
  static String getVehiculoUrl() {
    return "${_loadApiUrlBase()}/vehiculos";
  }
  static String checkPicoPlacaUrl() {
    return "${_loadApiUrlBase()}/checkPicoPlaca";
  }
  static String updateVehiculoUrl(int idCar) {
    return "${_loadApiUrlBase()}/vehiculos/${idCar}";
  }

  static String _loadApiUrlBase() {
    String urlBase = "http://localhost:8000/api";
    return urlBase;
  }
}
