import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteX {
  final String pageName;
  final RouteX? parent;
  late final String path;
  late final String name;
  late String? paramsKey;

  RouteX({
    required this.pageName,
    this.parent,
    String? path,
    String? name,
    this.paramsKey,
  }) {
    this.name = name ?? pageName;
    this.path = path ?? _generatePath();
  }

  // Constructor for routes with matched parameters
  RouteX.matched({
    required String pageName,
    required String paramsKey,
    RouteX? parent,
  }) : this(
          pageName: '$pageName/:$paramsKey',
          parent: parent,
          name: pageName,
          paramsKey: paramsKey,
        );

  // Generates the path based on the parent route and page name
  String _generatePath() {
    if (pageName == '/') {
      return pageName;
    }
    return parent != null ? '${parent!.path}/$pageName' : '/$pageName';
  }

  // Method to get the parent route path
  String? get parentPath => parent?.path;
}

extension AppRouteNavigation on RouteX {
  /// Navigates to the route using `go`, optionally with parameters or extra data.
  void go(BuildContext context, {Object? extra, String? params}) {
    final String targetPath = (paramsKey != null && params != null)
        ? path.replaceAll(':$paramsKey', params)
        : path;
    context.go(targetPath, extra: extra);
  }

  /// Navigates to the route using `goNamed`, allowing for named routes and optional parameters.
  void goNamed(BuildContext context, {Object? extra, String? params}) {
    if (paramsKey != null && params != null) {
      context.goNamed(name, pathParameters: {paramsKey!: params}, extra: extra);
      return;
    } else {
      context.goNamed(name, extra: extra);
    }
  }

  /// Pushes a new route onto the stack using `push`, with optional parameters and extra data.
  Future<T?> push<T>(BuildContext context,
      {Object? extra, String? params}) async {
    final String targetPath = (paramsKey != null && params != null)
        ? path.replaceAll(':$paramsKey', params)
        : path;
    return await context.push(targetPath, extra: extra);
  }

  /// Pushes a new named route onto the stack using `pushNamed`, with optional parameters and extra data.
  Future<T?> pushNamed<T>(BuildContext context,
      {Object? extra, String? params}) async {
    if (paramsKey != null && params != null) {
      return await context.pushNamed(name,
          pathParameters: {paramsKey!: params}, extra: extra);
    } else {
      return await context.pushNamed(name, extra: extra);
    }
  }
}
