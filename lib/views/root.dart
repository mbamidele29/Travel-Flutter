import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/utils/color.dart';
import 'package:travel_app/utils/enum.dart';
import 'package:travel_app/views/dashboard.dart';
import 'package:travel_app/views/generic.dart';
import 'package:travel_app/views/search.dart';

class HomeScreenRootWidget extends StatefulWidget {
  const HomeScreenRootWidget({super.key});

  @override
  State<HomeScreenRootWidget> createState() => _HomeScreenRootWidgetState();
}

class _HomeScreenRootWidgetState extends State<HomeScreenRootWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  BottomNavigationBarEnum currentTab = BottomNavigationBarEnum.home;

  @override
  void initState() {
    var animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController, curve: const Interval(.75, 1)));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // this is done so that screens are recreated and animations replayed when tabs are switched
      body: currentTab == BottomNavigationBarEnum.home
          ? const DashboardScreenWidget()
          : currentTab == BottomNavigationBarEnum.search
              ? const SearchScreenRootWidget()
              : GenericScreenWidget(name: currentTab.name),

      // body: IndexedStack(
      //   index: currentTab.index,
      //   children: const [
      //     SearchScreenRootWidget(),
      //     GenericScreenWidget(name: 'Notification'),
      //     DashboardScreenWidget(),
      //     GenericScreenWidget(name: 'Favorite'),
      //     GenericScreenWidget(name: 'Profile'),
      //   ],
      // ),
      bottomNavigationBar: SlideTransition(
        position: _animation,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
          margin: EdgeInsets.only(left: 55.w, right: 55.w, bottom: 40.h),
          decoration: BoxDecoration(
            color: AppColors.x2b2b2b,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: BottomNavigationBarEnum.values
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GestureDetector(
                      onTap: () {
                        currentTab = e;
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: e == currentTab ? 25.w : 20.w,
                        backgroundColor: e == currentTab
                            ? AppColors.xefa23d
                            : AppColors.x232220,
                        child: Center(child: SvgPicture.asset(e.icon)),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
