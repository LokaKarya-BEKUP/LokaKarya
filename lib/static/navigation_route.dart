enum NavigationRoute {
  splashRoute("/"),
  signInRoute("/signin"),
  signUpRoute("/signup"),
  mainRoute("/main"),
  detailRoute("/detail");

  const NavigationRoute(this.name);
  final String name;
}
