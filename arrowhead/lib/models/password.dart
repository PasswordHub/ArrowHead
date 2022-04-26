class Password {
  final String _id;
  final String _password;
  final String _name;
  final String _description;
  final String _url;
  final String _login;

  const Password(this._id, this._password, this._name, this._description,
      this._url, this._login);

  String get id => this._id;
  String get password => this._password;
  String get name => this._name;
  String get description => this._description;
  String get url => this._url;
  String get login => this._login;
}
