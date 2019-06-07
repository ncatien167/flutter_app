import 'api_config_detail.dart';
import 'api_config_type.dart';

class ApiConfig {
  static ApiConfigDetail createConnectionDetail(ApiConfigType type) {
    ApiConfigDetail connection = new ApiConfigDetail();
    if (type == null) {
      type = ApiConfigType.DEVELOP;
    }
    switch (type) {
      case ApiConfigType.DEVELOP:
        connection.setBaseUrl("https://api.themoviedb.org/3/");
        break;
      case ApiConfigType.STAGING:
        break;
      case ApiConfigType.PRELIVE:
        break;
      case ApiConfigType.LIVE:
        break;
      default:
        break;
    }
    return connection;
  }
}
