import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:flutter/material.dart';

class ChangePasswordV extends StatefulWidget {

  const ChangePasswordV({super.key});

  @override
  State<ChangePasswordV> createState() => _ChangePasswordVState();

}

class _ChangePasswordVState extends State<ChangePasswordV> {

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.1,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField(
                controller: _oldPasswordController,
                label: 'Old Password',
                validator: (val) => MyHelpers.validatePassword(val!),
              ),
              SizedBox(height: size.height * 0.05),
              _buildPasswordField(
                controller: _newPasswordController,
                label: 'New Password',
                validator: (val) => MyHelpers.validatePassword(val!),
              ),
              SizedBox(height: size.height * 0.05),
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm New Password',
                validator: (val) {
                  if (val != _newPasswordController.text) {
                    return 'Passwords do not match!';
                  }
                  return MyHelpers.validatePassword(val!);
                },
              ),
              SizedBox(height: size.height * 0.15),
              ElevatedButton(
                  onPressed: _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.6, size.height * 0.064),
                    elevation: 0,
                  ),
                  child: Text(
                    'Change Password',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: true,
          buildCounter: (context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) => null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
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
          validator: validator,
        ),
      ],
    );
  }

}