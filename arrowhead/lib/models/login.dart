class Login {
  static const ID_KEY = 'id';
  static const NAME_KEY = 'name';
  static const EMAIL_KEY = 'email';
  static const PASSWORD_KEY = 'password';

  final String _id;
  final String _name;
  final String _email;
  final String _password;

  const Login(this._id, this._name, this._email, this._password);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        json[ID_KEY], json[NAME_KEY], json[EMAIL_KEY], json[PASSWORD_KEY]);
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> get toJson => {
        ID_KEY: id,
        NAME_KEY: name,
        EMAIL_KEY: email,
        PASSWORD_KEY: name,
      };
}
