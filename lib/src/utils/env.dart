import 'package:flutter_dotenv/flutter_dotenv.dart';

const String flavor = String.fromEnvironment('FLAVOR');

final devVariables = {
  'api_key': dotenv.env['API_KEY'],
};

final prodVariables = {
  'api_key': dotenv.env['API_KEY'],
};

Map<String, dynamic> get environment {
  if (flavor == 'dev') {
    return devVariables;
  } else {
    return prodVariables;
  }
}
