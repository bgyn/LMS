import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/params/update_profile_params.dart';
import 'package:lms/core/utils/image_picker.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_event.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';
import 'package:lms/feature/profile/presentation/widgets/profile_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileModel profile;
  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;

  @override
  void initState() {
    _nameController.text = widget.profile.name ?? "";
    _bioController.text = widget.profile.bio ?? "";
    super.initState();
  }

  void pickProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        _profileImage = File(res.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Edit Profile'),
        elevation: 0,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            context.pop();
          }
        },
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.06.w(context),
            ),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Profile Image
                      Stack(
                        children: [
                          _profileImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _profileImage!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : widget.profile.profileImage != null
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: UrlConstant.mediaUrl +
                                            widget.profile.profileImage!,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error, size: 50),
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 60,
                                      child: Icon(Icons.person, size: 50),
                                    ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => pickProfileImage(),
                              child: CircleAvatar(
                                backgroundColor:
                                    Colors.grey.withValues(alpha: 0.8),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 0.04.h(context)),
                      ProfileTextfield(
                        title: 'Name',
                        controller: _nameController,
                      ),
                      // Bio
                      SizedBox(height: 0.02.h(context)),
                      ProfileTextfield(
                        title: 'Bio',
                        controller: _bioController,
                      ),
                      // Save Button
                      SizedBox(height: 0.04.h(context)),
                      state is ProfileLoading
                          ? const CircularProgressIndicator(
                              color: ColorPalette.primaryColor,
                            )
                          : Button(
                              title: Strings.save,
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context
                                      .read<ProfileBloc>()
                                      .add(ProfileUpdate(UpdateProfileParams(
                                        name: _nameController.text,
                                        bio: _bioController.text,
                                        profileImage: _profileImage,
                                      )));
                                }
                              })
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }
}
