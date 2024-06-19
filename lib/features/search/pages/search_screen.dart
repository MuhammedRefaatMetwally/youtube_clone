import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/widgets/custom_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/content/Long_video/components/post.dart';
import 'package:youtube_clone/features/search/providers/search_providers.dart';
import 'package:youtube_clone/features/search/widgets/search_channel_tile_widget.dart';

import '../../content/long_video/model/video_model.dart';


class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List foundItems = [];

  Future<void> filterList(String keywordSelected) async {
    List<UserModel> users = await ref.watch(allChannelsProvider);

    List result = [];

    final foundChannels = users.where((user) {
      return user.displayName
          .toString()
          .toLowerCase()
          .contains(keywordSelected);
    }).toList();

    result.addAll(foundChannels);

    final List<VideoModel> videos = await ref.watch(allVideosProvider);

    final foundVideos = videos.where((video) {
      return video.title.toString().toLowerCase().contains(keywordSelected);
    }).toList();

    result.addAll(foundVideos);

    setState(() {
      result.shuffle();
      foundItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(
                    height: 43,
                    width: 279,
                    child: TextFormField(
                      onChanged: (value) async {
                        await filterList(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search You Tube...",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:  BorderRadius.all(
                            Radius.circular(18.r),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:  BorderRadius.all(
                            Radius.circular(18.r),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff2f2f2),
                        contentPadding:  EdgeInsets.only(
                          left: 13.w,
                          bottom: 12.h,
                        ),
                        hintStyle:  TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 43.h,
                    width: 55.w,
                    child: CustomButton(
                      iconData: Icons.search,
                      onTap: () {},
                      haveColor: true,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: foundItems.length,
                  itemBuilder: (context, index) {
                    List<Widget> itemsWigdets = [];
                    final selectedItem = foundItems[index];

                    if (selectedItem.type == "video") {
                      itemsWigdets.add(
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 16.0.h),
                          child: Post(video: selectedItem),
                        ),
                      );
                    }
                    if (selectedItem.type == "user") {
                      itemsWigdets.add(
                        SearchChannelTile(
                          user: selectedItem,
                        ),
                      );
                    }
                    if (foundItems.isEmpty) {
                      return const SizedBox();
                    }

                    return itemsWigdets[0];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
