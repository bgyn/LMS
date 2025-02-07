import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/config/theme/theme.dart';
import 'package:lms/core/constants/strings.dart';
import 'package:lms/core/extension/estension.dart';
import 'package:lms/core/utils/get_time_difference.dart';
import 'package:lms/feature/notifications/presentation/bloc/notification_bloc.dart';
import 'package:lms/feature/notifications/presentation/bloc/notification_event.dart';
import 'package:lms/feature/notifications/presentation/bloc/notification_state.dart';
import 'package:lms/feature/notifications/presentation/widgets/notification_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotification());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.notification),
        forceMaterialTransparency: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04.w(context),
          ),
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
            if (state is NotificationLoading) {
              return Column(
                children: List.generate(2, (index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.01.h(context)),
                      width: double.infinity,
                      padding: EdgeInsets.all(0.01.toRes(context)),
                      decoration: BoxDecoration(
                        color: ColorPalette.primaryColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  );
                }),
              );
            }
            if (state is NotificationLoaded) {
              if (state.notification.isEmpty) {
                return const Center(
                  child: Text("Notification not found"),
                );
              } else {
                return ListView.builder(
                    itemCount: state.notification.length,
                    itemBuilder: (context, index) {
                      final notification = state.notification[index];
                      return InkWell(
                        onTap: () {
                          notification.isRead! && notification.id != null
                              ? null
                              : context.read<NotificationBloc>().add(
                                  MarkAsReadNotification(
                                      notification.id.toString()));
                          showNotificationBottomSheet(context);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 0.01.h(context)),
                          width: double.infinity,
                          padding: EdgeInsets.all(0.01.toRes(context)),
                          decoration: BoxDecoration(
                            color: notification.isRead ?? false
                                ? ColorPalette.primaryColor.withAlpha(50)
                                : ColorPalette.primaryColor.withAlpha(100),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            spacing: 0.015.w(context),
                            children: [
                              Icon(
                                Icons.notifications,
                                color: notification.isRead ?? false
                                    ? Colors.grey
                                    : ColorPalette.primaryColor,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontSize: 0.014.toRes(context),
                                          ),
                                    ),
                                    Text(
                                      notification.body.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontSize: 0.012.toRes(context)),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    getTimeDifference(notification.createdAt!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontSize: 0.012.toRes(context),
                                        ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
            if (state is NotificationError) {
              return const Center(
                child: Text("Failed to fetch notification"),
              );
            }
            return const SizedBox.shrink();
          })),
    );
  }
}
