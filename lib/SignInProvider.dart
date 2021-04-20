import 'package:children_audio/http/client.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SignInType {
  GOOGLE,
  MICROSOFT
}


class SignInProvider {

  final SignInType _type;

  SignInProvider(this._type);

  Future<HttpClient> signIn(scopes) async {
    if (this._type == SignInType.GOOGLE) {
      final signIn = GoogleSignIn.standard(scopes: scopes);
      final GoogleSignInAccount account = await signIn.signIn();
      final Map<String, String> headers = await account.authHeaders;
      return Future.value(new HttpClient(headers));
    } else {
      return Future.error(throw('Provider is not implemented'));
    }
  }


}