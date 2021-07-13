import 'package:shuttle_tracker/repo/constants.dart';

void main() async {
  await kAuth.signInWithEmailAndPassword(email: 'n_random@yopmail.com', password: 'n_random@yopmail.com');
  await kDB.collection('testing').doc('new').set({'FirstName' : 'Oboghene', 'LastName' : 'Agbawhe'});

}

