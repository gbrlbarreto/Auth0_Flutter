class Usuario{
  String _email;
  String _senha;

  Usuario({String email = '', String senha = ''})
      : _email = email,
        _senha = senha;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "email" : this.email
    };
    return map;
  }

  String get senha => _senha;

  set senha(String value){
    _senha = value;
  }

  String get email => _email;

  set email(String value){
    _email = value;
  }
}