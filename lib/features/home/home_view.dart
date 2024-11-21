import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piton/core/constants/image_constants.dart';
import 'package:piton/core/constants/shared_pref.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/extension/padding_extension.dart';
import 'package:piton/core/extension/widget_extension.dart';
import 'package:piton/features/home/widgets/category.dart';
import 'package:piton/features/splash/splash_view.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                expandedHeight: 150,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // SliverAppBar'ın yüksekliğini takip et
                    final percentCollapsed = (constraints.maxHeight - kToolbarHeight) / 100.0;
                    final isCollapsed = percentCollapsed <= 0;
                    const logo = Images.logo;

                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      title: AnimatedOpacity(
                        opacity: isCollapsed ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0), // Hafif üst boşluk için
                          child: Center(
                            child: Image.asset(
                              logo,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      background: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                logo,
                                height: 40,
                                fit: BoxFit.contain,
                              ).paddingOnly(top: 8),
                              const Text(
                                "AppBar Text",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [Category()],
              ).toSliver,
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                  childCount: 100,
                ),
              ),
            ],
          ).paddingSymmetric(
            horizontal: 16,
          )) ??
          GestureDetector(
            onTap: () {
              SharedPref.removeToken(ref).then(
                (value) {
                  context.toNamedAndRemoveUntil(SplashView.routeName);
                },
              );
            },
            child: const Center(
              child: Text('Logout'),
            ),
          ),
    );
  }
}
