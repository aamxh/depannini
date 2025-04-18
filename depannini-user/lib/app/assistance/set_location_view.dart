import 'package:depannini_user/app/assistance/location_repo.dart';
import 'package:depannini_user/app/assistance/set_location_view_model.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SetLocationV extends StatefulWidget {

  const SetLocationV({super.key});

  @override
  State<StatefulWidget> createState() => _SetLocationVS();

}

class _SetLocationVS extends State<SetLocationV> {

  late final GoogleMapController _ctrl;
  final _vm = SetLocationVM();
  final _location = Location();
  Marker? _marker;

  Future<void> _initState() async {
    final locData = await MyLocationRepo.getCurrentLocation();
    if (locData == null) return;
    _vm.changeLocation(LatLng(locData.latitude ?? 0, locData.longitude ?? 0));
    _vm.changeAddress(LatLng(locData.latitude ?? 0, locData.longitude ?? 0));
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() =>
                _vm.location.value == LatLng(0, 0) ?
                Center(child: CircularProgressIndicator(
                  color: MyConstants.primaryC,
                )) :
                GoogleMap(
                  onMapCreated: (GoogleMapController ctrl) {
                    _ctrl = ctrl;
                    _location.onLocationChanged.listen((LocationData loc) =>
                    _ctrl.animateCamera(CameraUpdate.newLatLng(
                      LatLng(loc.latitude!, loc.longitude!)
                    )));
                  },
                  onTap: (LatLng position) {
                    _vm.changeLocation(position);
                    _vm.changeAddress(position);
                    _marker = Marker(
                      markerId: MarkerId('Selected Location'),
                      position: position,
                      infoWindow: InfoWindow(title: 'Selected Location'),
                    );
                  },
                  initialCameraPosition: CameraPosition(
                    target: _vm.location.value!,
                    zoom: 25,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _marker == null ? {} : {_marker!},
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.2,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            color: theme.scaffoldBackgroundColor,
            child: Obx(() => Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    _vm.address.value,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size(size.width * 0.5, size.height * 0.064),
                      backgroundColor:
                      _vm.isAddressValid.value ?
                      MyConstants.primaryC :
                      MyConstants.lightGrey,
                      side: BorderSide(
                        color: _vm.isAddressValid.value ?
                            MyConstants.primaryC :
                            MyConstants.mediumGrey!,
                      ),
                    ),
                    child: Text(
                      'Confirm location',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: _vm.isAddressValid.value ?
                        Colors.white :
                        theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}