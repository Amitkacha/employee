import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di.dart';
import '../components/slide_left_route.dart';
import '../resources/color_manager.dart';

abstract class BaseStatefulState<StateMVC extends StatefulWidget>
    extends State<StateMVC> {
  bool shouldShowProgress = false;
  bool shouldHaveSafeArea = true;
  bool resizeToAvoidBottomInset = true;
  final rootScaffoldKey = GlobalKey<ScaffoldState>();
  late Size screenSize;
  bool isBackgroundImage = false;
  bool extendBodyBehindAppBar = false;
  Color? scaffoldBgColor;
  String? scaffoldBgImage;
  FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  void pushAndClearStack(BuildContext context,
      {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Future.delayed(const Duration(milliseconds: 200)).then((value) =>
        Navigator.of(context, rootNavigator: shouldUseRootNavigator)
            .pushAndRemoveUntil(
                SlideLeftRoute(page: enterPage), (route) => false));
  }

  void pushReplacement(BuildContext context,
      {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Future.delayed(const Duration(milliseconds: 200)).then((value) =>
        Navigator.of(context, rootNavigator: shouldUseRootNavigator)
            .pushReplacement(SlideLeftRoute(page: enterPage)));
  }

  Future<void> push(BuildContext context,
      {required Widget enterPage,
      bool shouldUseRootNavigator = false,
      Function? callback}) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    FocusScope.of(context).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 200)).then((value) =>
        Navigator.of(context, rootNavigator: shouldUseRootNavigator)
            .push(SlideLeftRoute(page: enterPage))
            .then((value) {
          callback?.call(value);
        }));
  }

  void clearStackAndPush(BuildContext context, String targetScreenName,
      {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Navigator.of(context, rootNavigator: shouldUseRootNavigator)
        .popUntil((route) {
      // Check if the current route is the target screen
      return route.settings.name == targetScreenName;
    });

    Navigator.of(context, rootNavigator: shouldUseRootNavigator)
        .push(SlideLeftRoute(page: enterPage));
  }

  Future<dynamic> pushForResult(
    BuildContext context, {
    required Widget enterPage,
    bool shouldUseRootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: shouldUseRootNavigator).push(
      SlideLeftRoute(page: enterPage),
    );
  }

  void goBack([val]) {
    Navigator.pop(rootScaffoldKey.currentContext!, val);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = buildBody(context);
    if (shouldHaveSafeArea) {
      bodyContent = SafeArea(
        bottom: true,
        child: !isBackgroundImage
            ? bodyContent
            : SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: bodyContent,
              ),
      );
    } else if (isBackgroundImage) {
      bodyContent = SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: bodyContent,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(rootScaffoldKey.currentContext!)
          .requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        key: rootScaffoldKey,
        extendBody: false,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        backgroundColor: scaffoldBgColor ?? ColorManager.white,
        appBar: buildAppBar(context),
        drawerEnableOpenDragGesture: false,
        drawer: buildDrawer(context),
        body: bodyContent,
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButton: buildFloatingActionButton(context),
        floatingActionButtonLocation: floatingActionButtonLocation ??
            FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @protected
  Widget? buildDrawer(BuildContext context) {
    return null;
  }

  void openDrawer(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(rootScaffoldKey.currentContext!).hideCurrentSnackBar();
    FocusScope.of(rootScaffoldKey.currentContext!).requestFocus(FocusNode());
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => rootScaffoldKey.currentState?.openDrawer());
  }

  Widget buildBody(BuildContext context) {
    return widget;
  }

  Widget? buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }
}

class BaseStatefulCubitState<T extends Cubit, StateMVC extends StatefulWidget>
    extends BaseStatefulState<StateMVC> {
  T model = getIt<T>();

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return super.buildAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent =
        BlocProvider(create: (context) => model, child: buildBody(context));

    if (shouldHaveSafeArea) {
      bodyContent = SafeArea(
        bottom: true,
        child: bodyContent,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(rootScaffoldKey.currentContext!)
          .requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        key: rootScaffoldKey,
        extendBody: false,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        backgroundColor: scaffoldBgColor ?? ColorManager.white,
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),
        drawerEnableOpenDragGesture: false,
        body: bodyContent,
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButton: buildFloatingActionButton(context),
        floatingActionButtonLocation: floatingActionButtonLocation ??
            FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
