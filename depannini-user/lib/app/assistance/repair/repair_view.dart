import 'package:depannini_user/app/assistance/repair/repair_assistant_view.dart';
import 'package:depannini_user/app/assistance/repair/repair_view_model.dart';
import 'package:depannini_user/app/assistance/location_field_widget.dart';
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
                    onPressed: () {
                      //if (_vm.isReady) {
                        if (_formKey.currentState!.validate()) {
                          Get.to(() => RepairAssistantV());
                        }
                      //}
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