class Repos{
  late int _id;
  late String _name;
  late bool _private;
  late String _avatarUrl;
  late String _htmlURL;

  Repos(this._id, this._name, this._private, this._avatarUrl,
      this._htmlURL);

  String get htmlURL => _htmlURL;

  set htmlURL(String value) {
    _htmlURL = value;
  }

  String get avatarUrl => _avatarUrl;

  set avatarUrl(String value) {
    _avatarUrl = value;
  }

  bool get private => _private;

  set private(bool value) {
    _private = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}