import 'package:google_directions_api/google_directions_api.dart';

void main() {
  DirectionsService.init('AIzaSyCBtswCK8sqjQyMSOziKZdUcYSav7se-qU');

  final directionsService = DirectionsService();

  final request = DirectionsRequest(
    origin: '6.673630706388988,3.159202182598312',
    destination: '6.673420129663751,3.1627116782127516',
    alternatives: false,
    travelMode: TravelMode.driving,

  );

  directionsService.route(request,
          (DirectionsResult response, DirectionsStatus? status) {
        if (status == DirectionsStatus.ok) {

          response.routes![0].legs![0].steps!.forEach(
                  (element) {
                    print('${element.travelMode} => ${element.duration!.text![0]}');
                    }
                  );
          // print(response.routes![0].legs![0].duration!.text);
          // do something with successful response
        } else {
          // do something with error response
        }
      });
}