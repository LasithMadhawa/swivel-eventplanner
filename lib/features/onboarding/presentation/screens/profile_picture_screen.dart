import 'dart:io';

import 'package:eventplanner/core/constants/routes.dart';
import 'package:eventplanner/core/constants/strings.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/onboarding/presentation/blocs/update_profile_picture/update_profile_picture_bloc.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureScreen extends StatelessWidget {
  const ProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    return BlocProvider(
      create:
          (context) => UpdateProfilePictureBloc(context.read<UserRepository>()),
      child: BlocConsumer<UpdateProfilePictureBloc, UpdateProfilePictureState>(
        listener: (context, state) {
          if (state is UpdateProfilePictureFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProfilePictureUploaded) {
            final authState = context.read<AuthBloc>().state;
            final currentUser = (authState as Authenticated).user;
            context.read<AuthBloc>().add(
              ProfileUpdated(
                updatedUser: currentUser.copyWith(
                  profilePictureUrl: state.imageUrl,
                ),
              ),
            );
            context.go(AppRoutes.userDetails);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.welcome,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            AppStrings.firstLoginProfilePictureUpload,
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            _handleImageUpload(context);
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                state is! ProfilePictureSelected &&
                                        state is! ProfilePictureUploading &&
                                        authState is Authenticated &&
                                        authState.user.profilePictureUrl != null
                                    ? NetworkImage(
                                      authState.user.profilePictureUrl!,
                                    )
                                    : (state is ProfilePictureSelected ||
                                        state is ProfilePictureUploading)
                                    ? FileImage(File(state.image!.path))
                                    : null,
                            child:
                                state is! ProfilePictureSelected &&
                                        state is! ProfilePictureUploading
                                    ? Icon(
                                      Icons.camera_alt_outlined,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                    : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed:
                              state is ProfilePictureUploading
                                  ? null
                                  : () {
                                    final authState =
                                        context.read<AuthBloc>().state;
                                    if (state is ProfilePictureSelected &&
                                        authState is Authenticated) {
                                      context
                                          .read<UpdateProfilePictureBloc>()
                                          .add(
                                            UploadImage(
                                              user: authState.user,
                                              image: state.image!,
                                            ),
                                          );
                                    } else {
                                      context.go(AppRoutes.userDetails);
                                    }
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
    );
  }

  Future<void> _handleImageUpload(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      context.read<UpdateProfilePictureBloc>().add(SelectImage(image));
    }
  }
}
