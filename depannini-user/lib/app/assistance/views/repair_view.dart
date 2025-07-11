import 'package:depannini_user/app/assistance/common/assistance_api.dart';
import 'package:depannini_user/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/app/assistance/view_models/repair_view_model.dart';
import 'package:depannini_user/app/assistance/widgets/location_field_widget.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairV extends StatelessWidget {

  RepairV({super.key});

  final _descCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _vm = Get.find<RepairVM>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              Center(
                child: Text(
                  'Repair service',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              LocationFieldW(id: 2),
              SizedBox(height: size.height * 0.05),
              Text(
                'Description',
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Give a short description of the problem you are facing',
                  hintStyle: theme.textTheme.bodyLarge!.copyWith(
                    color: MyConstants.mediumGrey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: MyConstants.primaryC,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (val) => _vm.desc = val,
                style: theme.textTheme.bodyLarge,
                validator: (val) {
                  if (val!.isEmpty) return 'Description field cannot be empty!';
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.1),
              Center(
                child: Obx(() =>
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Get.dialog(
                          Center(
                            child: CircularProgressIndicator(
                              color: MyConstants.primaryC,
                            ),
                          ),
                          barrierDismissible: false,
                        );
                        final res = await AssistanceAPI.requestAssistance(AssistanceRequest(
                          assistanceType: 'repair',
                          vehicleType: 'light',
                          pickup: {
                            "lat": _vm.location.latitude,
                            "lng": _vm.location.longitude
                          },
                          dropoff: {
                            "lat": _vm.location.latitude,
                            "lng": _vm.location.longitude
                          },
                          description: _descCtrl.text,
                        ));
                        Get.back();
                        await Future.delayed(Duration(milliseconds: 100));
                        if (res != null) {
                          final assistanceVM = Get.find<AssistanceVM>();
                          assistanceVM.state = 'requested';
                          assistanceVM.channel = res;
                          assistanceVM.startListening();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * 0.6, size.height * 0.064),
                      elevation: 0,
                      backgroundColor: _vm.isReady ? MyConstants.primaryC :
                      theme.scaffoldBackgroundColor == Colors.white ?
                      MyConstants.lightGrey :
                      MyConstants.darkGrey,
                      side: BorderSide(
                        color: _vm.isReady ? MyConstants.primaryC :
                        theme.scaffoldBackgroundColor == Colors.white ?
                        MyConstants.darkGrey! :
                        MyConstants.lightGrey!,
                      ),
                    ),
                    child: Text(
                      'Request assistant',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: _vm.isReady ? Colors.white :
                        theme.scaffoldBackgroundColor == Colors.white ?
                        MyConstants.darkGrey :
                        MyConstants.lightGrey,
                      ),
                    ),
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