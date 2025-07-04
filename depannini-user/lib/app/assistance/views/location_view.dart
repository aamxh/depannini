import 'package:depannini_user/app/assistance/common/assistance_api.dart';
import 'package:depannini_user/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_user/app/assistance/view_models/location_view_model.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationV extends StatefulWidget {

  const LocationV({super.key});

  @override
  State<StatefulWidget> createState() => _LocationVS();

}

class _LocationVS extends State<LocationV> {

  late final GoogleMapController _ctrl;
  final _locationVM = Get.find<LocationVM>();
  final _assistanceVM = Get.find<AssistanceVM>();
  final _location = Location();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _assistanceVM.dispose();
    _locationVM.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    await _locationVM.initializeCurrentLocation();
    await _locationVM.setPath(_locationVM.userLocation, _locationVM.assistantLocation);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() =>
        _assistanceVM.state == 'canceled' ?
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The assistance has been canceled /:',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: size.height * 0.1,),
            ElevatedButton(
              onPressed: () {
                Get.delete<LocationVM>();
                Get.delete<AssistanceVM>();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.5, size.height * 0.064),
                elevation: 0,
              ),
              child: Text(
                'Return',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        )) :
        Column(
          children: [
            SizedBox(height: size.height * 0.1,),
            SizedBox(
              height: size.height * 0.64,
              child: GoogleMap(
                onMapCreated: (GoogleMapController ctrl) {
                  _ctrl = ctrl;
                  print("Map created - Assistant: ${_locationVM.userLocation}, Client: ${_locationVM.assistantLocation}");
                  print("Path polylines count: ${_locationVM.path.length}");
                  _location.onLocationChanged.listen((LocationData loc) =>
                      _ctrl.animateCamera(CameraUpdate.newLatLng(
                          LatLng(loc.latitude!, loc.longitude!)
                      )));
                },
                initialCameraPosition: CameraPosition(
                  target: _locationVM.userLocation,
                  zoom: 15,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId('assistant'),
                    position: _locationVM.assistantLocation,
                    infoWindow: InfoWindow(title: "Assistant"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  ),
                },
                polylines: _locationVM.path.toSet(),
              ),
            ),
            SizedBox(height: size.height * 0.01,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Assistant phone number: ${_assistanceVM.assistant!.phoneNumber}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => MyHelpers.makePhoneCall(_assistanceVM.assistant!.phoneNumber),
                        child: Text(
                          'Call',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: MyConstants.primaryC,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Assistance status: ',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        _assistanceVM.state,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03,),
                  _assistanceVM.state == 'ongoing' ?
                  Container() :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => AssistanceAPI.updateAssistanceState(
                          _assistanceVM.id.toString(),
                          'canceled',
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(size.width * 0.35, size.height * 0.064),
                          backgroundColor: theme.scaffoldBackgroundColor,
                          side: BorderSide(color: MyConstants.primaryC),
                        ),
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: MyConstants.primaryC,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => AssistanceAPI.updateAssistanceState(
                          _assistanceVM.id.toString(),
                          'ongoing',
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(size.width * 0.35, size.height * 0.064),
                          backgroundColor: _assistanceVM.state == 'ongoing' ?
                          theme.scaffoldBackgroundColor == Colors.white ?
                          MyConstants.lightGrey :
                          MyConstants.darkGrey :
                          MyConstants.primaryC,
                          side: BorderSide(
                            color: _assistanceVM.state == 'ongoing' ?
                            theme.scaffoldBackgroundColor == Colors.white ?
                            MyConstants.darkGrey! :
                            MyConstants.lightGrey! :
                            MyConstants.primaryC ,
                          ),
                        ),
                        child: Text(
                          'Arrived',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

}