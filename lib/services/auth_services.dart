import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  // Google Sign in
  signInWithGoogle() async {
    // inicio interativo do processo de login

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtendo detalhes da requisição

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // criando uma nova credencial para o usuario

    final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
    );

    //finalizando o processo de login

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}