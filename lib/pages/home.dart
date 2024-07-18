import 'package:jaspr/jaspr.dart';

import '../components/counter.dart';

@client
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      div([
        img(classes: 'h-20 w-20', src: 'images/logo.png'),
      ]),
      h1([text('Welcome')]),
      p([text('You successfully create a new Jaspr site.')]),
      div(styles: Styles.box(height: 100.px), []),
      const Counter(),
    ]);
  }

  static get styles => [
        ...Counter.styles,
      ];
}
