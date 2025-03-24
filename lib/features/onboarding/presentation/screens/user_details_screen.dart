import 'package:eventplanner/core/utils/validators.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/constants/strings.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../blocs/update_user_details/update_user_details_bloc.dart';
import '../../../user/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDetailsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => UpdateUserDetailsBloc(context.read<UserRepository>()),
          child: BlocConsumer<UpdateUserDetailsBloc, UpdateUserDetailsState>(
            listener: (context, state) {
              if (state is UpdateUserDetailsSuccess) {
                context.read<AuthBloc>().add(ProfileUpdated(updatedUser: state.updatedUser));
              }
            },
            builder: (context, state) {
              return GestureDetector(
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Personal Info",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  "You can add your personal data now or do it later",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _firstNameController,
                                  decoration: const InputDecoration(
                                    labelText: "First Name",
                                  ),
                                  validator: Validators.nameValidator,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _lastNameController,
                                  decoration: const InputDecoration(
                                    labelText: "Last Name",
                                  ),
                                  validator: Validators.nameValidator
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                  ),
                                  initialValue:
                                      authState is Authenticated
                                          ? authState.user.email
                                          : null,
                                  readOnly: true,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(
                                    labelText: "Phone Number",
                                  ),
                                  validator: Validators.requiredValidator,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                    labelText: "Mailing Address",
                                  ),
                                  validator: Validators.requiredValidator,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: state is UpdateUserDetailsLoading ? null : () {
                                context.go(AppRoutes.profilePicture);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back),
                                  SizedBox(width: 8),
                                  Text(AppStrings.backButton),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: FilledButton(
                              onPressed: state is UpdateUserDetailsLoading ? null :  () {
                                _submitForm(context);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppStrings.nextButton),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
      context.read<UpdateUserDetailsBloc>().add(
        UpdateUserDetailsRequested(updatedUser: updatedUser),
      );
    }
  }
}
