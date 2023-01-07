class Commits{
  late String _name;
  late DateTime _date;
  late String _email;
  late String _url;

  Commits(this._name, this._date, this._email, this._url);

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}