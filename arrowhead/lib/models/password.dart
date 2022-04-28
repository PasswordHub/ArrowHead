class Password {
  final String _id;
  final String _password;
  final String _name;
  final String _description;
  final String _url;
  final String _login;

  const Password(this._id, this._password, this._name, this._description,
      this._url, this._login);

  String get id => _id;
  String get password => _password;
  String get name => _name;
  String get description => _description;
  String get url => _url;
  String get login => _login;
}
