import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../core/utils/responsive_layout.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState> drawerKey;
  final FloatingActionButton? floatingActionButton;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final List<Widget>? persistentFooterButtons;
  final bool resizeToAvoidBottomInset;

  // SidebarX specific options
  final SidebarXController? sidebarController;
  final List<SidebarXItem>? sidebarItems;
  final Widget? sidebarHeader;
  final Widget? sidebarFooter;
  final SidebarXTheme? sidebarTheme;

  // Responsive layout options
  final bool useDrawerOnTablet;
  final bool useDrawerOnDesktop;
  final double? drawerWidth;
  final bool showBottomNavOnTablet;
  final bool showBottomNavOnDesktop;
  final bool useSidebarX;

  final double? persistentBreakpoint;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    required this.drawerKey,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset = true,
    this.sidebarController,
    this.sidebarItems,
    this.sidebarHeader,
    this.sidebarFooter,
    this.sidebarTheme,
    this.useDrawerOnTablet = true,
    this.useDrawerOnDesktop = true,
    this.drawerWidth,
    this.showBottomNavOnTablet = false,
    this.showBottomNavOnDesktop = false,
    this.useSidebarX = true,
    this.persistentBreakpoint,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenInfo) {
        final showDrawer =
            (drawer != null ||
                (useSidebarX &&
                    (sidebarItems != null || sidebarController != null))) &&
            _shouldShowDrawer(screenInfo);
        final showBottomNav =
            bottomNavigationBar != null && _shouldShowBottomNav(screenInfo);
        if (showDrawer) {
          return _buildDrawerLayout(context, screenInfo, showBottomNav);
        } else {
          return _buildStandardLayout(context, showBottomNav);
        }
      },
    );
  }

  bool _shouldShowDrawer(ScreenInfo screenInfo) {
    if (persistentBreakpoint != null &&
        screenInfo.width < persistentBreakpoint!) {
      return false;
    }
    switch (screenInfo.deviceType) {
      case DeviceType.mobile:
        return false; // Always use standard drawer on mobile
      case DeviceType.tablet:
        return useDrawerOnTablet;
      case DeviceType.desktop:
      case DeviceType.tv:
        return useDrawerOnDesktop;
    }
  }

  bool _shouldShowBottomNav(ScreenInfo screenInfo) {
    switch (screenInfo.deviceType) {
      case DeviceType.mobile:
        return true;
      case DeviceType.tablet:
        return showBottomNavOnTablet;
      case DeviceType.desktop:
      case DeviceType.tv:
        return showBottomNavOnDesktop;
    }
  }

  Widget _buildDrawerLayout(
    BuildContext context,
    ScreenInfo screenInfo,
    bool showBottomNav,
  ) {
    final effectiveDrawerWidth =
        drawerWidth ??
        context.responsive(
          ResponsiveValue<double>(
            defaultValue: 250,
            mobile: 250,
            tablet: 280,
            desktop: 300,
            tv: 350,
          ),
        );

    // Use SidebarX if enabled and items are provided
    if (useSidebarX && (sidebarItems != null || sidebarController != null)) {
      return _buildSidebarXLayout(
        context,
        screenInfo,
        showBottomNav,
        effectiveDrawerWidth!,
      );
    }

    // Fallback to standard drawer
    return Scaffold(
      key: drawerKey,
      appBar: appBar,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Row(
        children: [
          // Persistent drawer
          SizedBox(
            width: effectiveDrawerWidth,
            child: Drawer(elevation: 0, child: drawer),
          ),
          // Vertical divider
          const VerticalDivider(width: 1, thickness: 1),
          // Main content
          Expanded(child: body),
        ],
      ),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav ? bottomNavigationBar : null,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget _buildSidebarXLayout(
    BuildContext context,
    ScreenInfo screenInfo,
    bool showBottomNav,
    double effectiveDrawerWidth,
  ) {
    final controller =
        sidebarController ??
        SidebarXController(
          selectedIndex: 0,
          extended: screenInfo.deviceType != DeviceType.mobile,
        );

    final defaultTheme = SidebarXTheme(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.responsive(
          ResponsiveValue<Color>(
            defaultValue: Colors.white,
            mobile: Colors.grey[50]!,
            desktop: Colors.grey[100]!,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      hoverColor: Colors.blueAccent.withOpacity(0.1),
      textStyle: TextStyle(color: Colors.black87, fontSize: 16),
      selectedTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      itemTextPadding: EdgeInsets.only(left: 30),
      selectedItemTextPadding: EdgeInsets.only(left: 30),
      itemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      selectedItemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.blue[600]!],
        ),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.28), blurRadius: 30),
        ],
      ),
      iconTheme: IconThemeData(color: Colors.black54, size: 20),
      selectedIconTheme: IconThemeData(color: Colors.white, size: 20),
    );

    return Scaffold(
      key: drawerKey,
      appBar: appBar,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Row(
        children: [
          SidebarX(
            controller: controller,
            theme: sidebarTheme ?? defaultTheme,
            extendedTheme: SidebarXTheme(
              width: effectiveDrawerWidth,
              decoration: (sidebarTheme ?? defaultTheme).decoration,
            ),
            headerBuilder: sidebarHeader != null
                ? (context, extended) => sidebarHeader!
                : (context, extended) =>
                      _buildDefaultSidebarHeader(context, extended),
            items: sidebarItems ?? [],
            footerBuilder: sidebarFooter != null
                ? (context, extended) => sidebarFooter!
                : null,
          ),
          Expanded(child: body),
        ],
      ),
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav ? bottomNavigationBar : null,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget _buildDefaultSidebarHeader(BuildContext context, bool extended) {
    return SizedBox(
      height: context.responsive(
        ResponsiveValue<double>(
          defaultValue: 200,
          mobile: 150,
          tablet: 180,
          desktop: 220,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: context.responsive(
                ResponsiveValue<double>(
                  defaultValue: 30,
                  mobile: 25,
                  desktop: 35,
                ),
              ),
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: context.responsive(
                  ResponsiveValue<double>(
                    defaultValue: 30,
                    mobile: 25,
                    desktop: 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (extended) ...[
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'User Name',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStandardLayout(BuildContext context, bool showBottomNav) {
    var effectiveDrawer = drawer;
    if (effectiveDrawer == null &&
        useSidebarX &&
        (sidebarItems != null || sidebarController != null)) {
      effectiveDrawer = _buildSidebarDrawer(context);
    }

    var effectiveAppBar = appBar;
    if (effectiveAppBar == null && effectiveDrawer != null) {
      effectiveAppBar = AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      );
    }
    return Scaffold(
      key: drawerKey,
      appBar: effectiveAppBar,
      drawer: effectiveDrawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav ? bottomNavigationBar : null,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget _buildSidebarDrawer(BuildContext context) {
    final controller =
        sidebarController ??
        SidebarXController(selectedIndex: 0, extended: true);

    final defaultTheme = SidebarXTheme(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.responsive(
          ResponsiveValue<Color>(
            defaultValue: Colors.white,
            mobile: Colors.grey[50]!,
            desktop: Colors.grey[100]!,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      hoverColor: Colors.blueAccent.withOpacity(0.1),
      textStyle: TextStyle(color: Colors.black87, fontSize: 16),
      selectedTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      itemTextPadding: EdgeInsets.only(left: 30),
      selectedItemTextPadding: EdgeInsets.only(left: 30),
      itemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      selectedItemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueAccent,
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.blue[600]!],
        ),
        boxShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.28), blurRadius: 30),
        ],
      ),
      iconTheme: IconThemeData(color: Colors.black54, size: 20),
      selectedIconTheme: IconThemeData(color: Colors.white, size: 20),
    );

    return Drawer(
      elevation: 0,
      width: drawerWidth ?? 280,
      child: SidebarX(
        controller: controller,
        theme: sidebarTheme ?? defaultTheme,
        extendedTheme: SidebarXTheme(
          width: drawerWidth ?? 280,
          decoration: (sidebarTheme ?? defaultTheme).decoration,
        ),
        headerBuilder: sidebarHeader != null
            ? (context, extended) => sidebarHeader!
            : (context, extended) =>
                  _buildDefaultSidebarHeader(context, extended),
        items: sidebarItems ?? [],
        footerBuilder: sidebarFooter != null
            ? (context, extended) => sidebarFooter!
            : null,
      ),
    );
  }
}
