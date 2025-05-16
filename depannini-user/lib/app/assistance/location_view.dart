import 'package:depannini_user/app/assistance/location_api.dart';
import 'package:depannini_user/app/assistance/location_view_model.dart';
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
  final _vm = LocationVM();
  final _location = Location();

  @override
  void initState() {
    super.initState();
    _vm.setPath(_vm.userLocation, _vm.assistantLocation);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Obx(() =>
          Column(
            children: [
              SizedBox(
                height: size.height * 0.7,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController ctrl) {
                    _ctrl = ctrl;
                    _location.onLocationChanged.listen((LocationData loc) =>
                        _ctrl.animateCamera(CameraUpdate.newLatLng(
                            LatLng(loc.latitude!, loc.longitude!)
                        )));
                  },
                  initialCameraPosition: CameraPosition(
                    target: _vm.userLocation,
                    zoom: 18,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    Marker(
                      markerId: MarkerId('assistant'),
                      position: _vm.assistantLocation,
                      infoWindow: InfoWindow(title: "Assistant"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    ),
                  },
                  polylines: _vm.path,
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assistant phone number: ${_vm.assistantPhoneNum}',
                    style: theme.textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () => MyHelpers.makePhoneCall(_vm.assistantPhoneNum),
                    child: Text(
                      'Call',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: MyConstants.primaryC,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assistance status: ',
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    _vm.assistanceStatus,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02,),
              _vm.assistanceStatus == 'on-going' ? Container() :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * 0.25, size.height * 0.064),
                      backgroundColor: _vm.assistanceStatus == 'arrived' ?
                      MyConstants.primaryC :
                      theme.scaffoldBackgroundColor == Colors.white ?
                      MyConstants.lightGrey :
                      MyConstants.darkGrey,
                      side: BorderSide(
                        color: _vm.assistanceStatus == 'arrived' ?
                        MyConstants.primaryC :
                        theme.scaffoldBackgroundColor == Colors.white ?
                        MyConstants.darkGrey! :
                        MyConstants.lightGrey!,
                      ),
                    ),
                    child: Text(
                      'Completed',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * 0.25, size.height * 0.064),
                      backgroundColor: theme.scaffoldBackgroundColor == Colors.white ?
                      MyConstants.lightGrey : MyConstants.darkGrey,
                      side: BorderSide(
                        color: theme.scaffoldBackgroundColor == Colors.white ?
                        MyConstants.darkGrey! : MyConstants.lightGrey!,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}