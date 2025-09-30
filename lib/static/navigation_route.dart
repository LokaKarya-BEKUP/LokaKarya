enum NavigationRoute {
  splashRoute("/"),
  signInRoute("/signin"),
  signUpRoute("/signup"),
  homeRoute("/home");

  const NavigationRoute(this.name);
  final String name;
}
