import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/config/route/route_path.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/widgets/button.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:lms/feature/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image
                  state.profile?.profileImage != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: UrlConstant.mediaUrl +
                                state.profile!.profileImage!,
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
                  SizedBox(height: 0.015.h(context)),
                  // Name
                  Text(
                    state.profile?.name ?? '',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 0.02.h(context)),
                  // Email
                  Text(
                    state.profile?.email ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 0.024.h(context)),

                  // Bio Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      state.profile?.bio ?? 'No bio available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 0.032.h(context)),

                  // Edit Button (Optional)
                  Button(
                      width: 0.5.w(context),
                      title: Strings.editProfile,
                      onTap: () {
                        final profile = jsonEncode(state.profile!.toMap());
                        context.push(RoutePath.editProfile, extra: profile);
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
