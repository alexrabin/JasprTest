import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/header.dart';
import 'pages/about.dart';
import 'pages/home.dart';
import 'pages/post.dart';

// A simple [StatelessComponent] with a [build] method.
class App extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'main', [
      const Header(),
      Router(routes: [
        Route(
            path: '/',
            name: '/',
            title: 'Home',
            builder: (context, state) => const Home()),
        Route(
            path: '/about',
            title: 'About',
            builder: (context, state) => const About()),
        Route(
            path: '/post/:postId',
            title: 'Post',
            redirect: (context, state) async {
              if (state.params['postId'] == '1') {
                await Future.delayed(const Duration(seconds: 1));
                return '/';
              }
              return null;
            },
            builder: (context, state) =>
                PostPage(id: state.params['postId'] ?? '')),
      ]),
    ]);
  }

  static get styles => [
        css('.main', [
          css('&')
              .box(height: 100.vh)
              .flexbox(direction: FlexDirection.column, wrap: FlexWrap.wrap),
          css('section').flexItem(flex: Flex(grow: 1)).flexbox(
                direction: FlexDirection.column,
                justifyContent: JustifyContent.center,
                alignItems: AlignItems.center,
              ),
        ]),
        ...Header.styles,
        ...Home.styles,
        ...About.styles,
      ];
}
