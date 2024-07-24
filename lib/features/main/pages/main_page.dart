import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/search/search_page.dart';
import '../../../core/utils/nav_bar_cubit.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../cart/persentation/pages/cart_page.dart';
import '../../home/persentation/pages/home_page.dart';
import '../../favorite/presentation/pages/favorite_page.dart';
import 'package:shopera/features/settings/pages/settings_page.dart';
import 'package:shopera/features/home/persentation/cubit/home_cubit.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';

class MainPage extends StatefulWidget {
  static const routeName = 'main page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getCurrentUser();
    context.read<HomeCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
        builder: (context, state) {
          switch (state) {
            case NavigationBarState.home:
              return const HomePage();
            case NavigationBarState.search:
              return const SearchPage();
            case NavigationBarState.wishList:
              return const FavoritePage();
            case NavigationBarState.cart:
              return const CartPage();
            case NavigationBarState.settings:
              return const SettingsPage();
            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
