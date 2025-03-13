import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0test/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String? idToken;
  const Home({super.key, this.idToken});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Auth0 auth0;
  bool isLoading = false;
  String? idToken;

  final String domain = 'dev-3or80za1jx5523rh.us.auth0.com';
  final String clientId = '0EoobKJ7DtyWJA2a677hi9sLmfxtfmQJ';
  // final String redirectUri = 'com.example.app://login-callback';
  final String redirectUri = 'com.example.auth0test://login-callback';


  Future<void> _logout() async {
    if (idToken == null) {
      print('ID Token não encontrado!');
      return;
    }

    final String logoutUrl =
        'https://$domain/oidc/logout?id_token_hint=$idToken&post_logout_redirect_uri=$redirectUri';

    try {
      final response = await http.get(Uri.parse(logoutUrl));

      if (response.statusCode == 200) {
        setState(() {
          idToken = null;
        });
        print('Logout bem-sucedido!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
      );
      } else {
        print('Erro ao fazer logout: ${response.body}');
      }
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-3or80za1jx5523rh.us.auth0.com', '0EoobKJ7DtyWJA2a677hi9sLmfxtfmQJ');
    idToken = widget.idToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              Text("Usuario logado. Bem-vindo!"),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Center(
                  child:
                      isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                            child: Text(
                              "Deslogar",
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
                              _logout();
                            },
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
