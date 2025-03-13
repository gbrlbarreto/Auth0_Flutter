import 'package:auth0test/Home.dart';
import 'package:auth0test/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'profile_view.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Credentials? _credentials;

  late Auth0 auth0;

  TextEditingController _controllerEmail = TextEditingController(text: 'gbrlbarreto7272@gmail.com');
  TextEditingController _controllerSenha = TextEditingController(text: 'Ls19031996!');
  bool isLoading = false;

  _logarUsuario() async {
    setState(() {
      isLoading = true;
    });

    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    Usuario usuario = Usuario();
    usuario.email = email;
    usuario.senha = senha;

    try {
      final result = await auth0.api.login(
        usernameOrEmail: usuario.email,
        password: usuario.senha,
        connectionOrRealm: 'Username-Password-Authentication',
        scopes: {'openid', 'profile', 'email', 'offline_access'},
      );
      print(result);

      // Verifica se o login foi bem-sucedido
      if (result != null && result.accessToken != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Caso o login falhe, exiba uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao realizar login. Tente novamente.')),
        );
      }
    } catch (e) {
      print("Erro no login: $e");
      // Exibe uma mensagem de erro em caso de falha
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-3or80za1jx5523rh.us.auth0.com', '0EoobKJ7DtyWJA2a677hi9sLmfxtfmQJ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(  
                  width: 300,  
                  child: TextField(
                    controller: _controllerEmail,
                    //autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 16), 
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),  
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                    ),
                  ),
                ),
              ),
                Container(  
                width: 300,
                child: TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 16), 
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),  
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: Center(
                    child:
                        isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.green,
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(32, 16, 32, 16),
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _logarUsuario();
                              },
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}