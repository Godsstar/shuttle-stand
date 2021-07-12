import 'package:google_directions_api/google_directions_api.dart';

void main() {
  DirectionsService.init('AIzaSyAUdzstv-HNibyhGbitYP2gAl5CtMYCq5A');

  final directionsService = DirectionsService();

  final request = DirectionsRequest(
    origin: 'Chicago, IL',
    destination: 'San Francisco, CA',
    travelMode: TravelMode.driving,
  );

  directionsService.route(request, (DirectionsResult response, DirectionsStatus? status) {
        if (status == DirectionsStatus.ok) {
          print(response);
          // do something with successful response
        } else {
          print(response.status);
          print(response.errorMessage);
          // do something with error response
        }
      });
}

