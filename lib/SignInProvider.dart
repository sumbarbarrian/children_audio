import 'package:children_audio/http/client.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum signInType {
  GOOGLE,
  MICROSOFT
}


class SignInProvider {

  final signInType _type;

  SignInProvider(this._type);

  Future<HttpClient> signIn(scopes) async {
    if (this._type == signInType.GOOGLE) {
      final signIn = GoogleSignIn.standard(scopes: scopes);
      final GoogleSignInAccount account = await signIn.signIn();
      final Map<String, String> headers = await account.authHeaders;
      return Future.value(new HttpClient(headers));
    } else {
      return Future.error(throw('Provider is not implemented'));
    }
  }


}