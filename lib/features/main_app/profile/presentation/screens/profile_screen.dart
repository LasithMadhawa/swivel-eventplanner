import 'dart:io';

import '../../../../../core/models/user_model.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../blocs/profile/profile_bloc.dart';
import '../../../../user/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  XFile? _image;
  bool _readOnly = true;

  @override
  Widget build(BuildContext context) {
    final UserModel currentUser =
        (context.read<AuthBloc>().state as Authenticated).user;
    _firstNameController.text = currentUser.firstName ?? "";
    _lastNameController.text = currentUser.lastName ?? "";
    _emailController.text = currentUser.email;
    _phoneNumberController.text = currentUser.phoneNumber ?? "";
    _addressController.text = currentUser.address ?? "";
    return BlocProvider(
      create:
          (context) => ProfileBloc(
            userRepository: context.read<UserRepository>(),
            user: (context.read<AuthBloc>().state as Authenticated).user,
          ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            context.read<AuthBloc>().add(
              ProfileUpdated(updatedUser: state.user),
            );
            setState(() {
              _readOnly = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            context.read<ProfileBloc>().add(ResetProfileBloc());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _readOnly ? null : () {
                                _handleImageUpload(context);
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    _image != null
                                        ? FileImage(File(_image!.path))
                                        : state.user.profilePictureUrl != null
                                        ? NetworkImage(
                                          state.user.profilePictureUrl!,
                                        )
                                        : null,
                                child:
                                    _readOnly
                                        ? null
                                        : const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                        ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _firstNameController,
                                    decoration: const InputDecoration(
                                      labelText: "First Name",
                                    ),
                                    readOnly: _readOnly,
                                  ),
                                  const SizedBox(height: 12.0),
                                  TextFormField(
                                    controller: _lastNameController,
                                    decoration: const InputDecoration(
                                      labelText: "Last Name",
                                    ),
                                    readOnly: _readOnly,
                                  ),
                                  const SizedBox(height: 12.0),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                    ),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 12.0),
                                  TextFormField(
                                    controller: _phoneNumberController,
                                    decoration: const InputDecoration(
                                      labelText: "Phone Number",
                                    ),
                                    readOnly: _readOnly,
                                  ),
                                  const SizedBox(height: 12.0),
                                  TextFormField(
                                    controller: _addressController,
                                    decoration: const InputDecoration(
                                      labelText: "Mailing Address",
                                    ),
                                    readOnly: _readOnly,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!_readOnly)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _readOnly = true;
                            });
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed:
                            state is ProfileUpdating
                                ? null
                                : () {
                                  if (!_readOnly) {
                                    _submitForm(context);
                                  } else {
                                    setState(() {
                                      _readOnly = false;
                                    });
                                  }
                                },
                        child: Text(_readOnly ? "Edit" : "Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthBloc>().state;
      final updatedUser = (authState as Authenticated).user.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneNumberController.text,
        address: _addressController.text,
      );
      context.read<ProfileBloc>().add(
        ProfileUpdateRequested(updatedUser: updatedUser, image: _image),
      );
    }
  }

  Future<void> _handleImageUpload(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
}
