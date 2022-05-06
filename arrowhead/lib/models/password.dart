class Password {
  static const ID_KEY = 'id';
  static const PASSWORD_KEY = 'password';
  static const DESCRIPTION_KEY = 'description';
  static const NAME_KEY = 'name';
  static const URL_KEY = 'url';
  static const LOGIN_KEY = 'login';

  final String _id;
  final String _password;
  final String _name;
  final String _description;
  final String _url;
  final String _login;

  const Password(this._id, this._password, this._name, this._description,
      this._url, this._login);

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(json[ID_KEY], json[PASSWORD_KEY], json[NAME_KEY],
        json[DESCRIPTION_KEY], json[URL_KEY], json[LOGIN_KEY]);
  }

  String get id => _id;
  String get password => _password;
  String get name => _name;
  String get description => _description;
  String get url => _url;
  String get login => _login;

  Map<String, dynamic> get toJson => {
        ID_KEY: id,
        PASSWORD_KEY: password,
        DESCRIPTION_KEY: description,
        NAME_KEY: name,
        URL_KEY: url,
        LOGIN_KEY: login,
      };
}
