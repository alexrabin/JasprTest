import 'package:jaspr/jaspr.dart';

import '../styles.dart';
import 'flutter_counter.dart'
    if (dart.library.io) 'flutter_counter_fallback.dart';

class Counter extends StatefulComponent {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();

  static get styles => _CounterState.styles;
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'counter', [
      button(
        onClick: () {
          setState(() => count--);
        },
        [text('-')],
      ),
      span([text('$count')]),
      button(
        attributes: {'data-ripple-light': 'true'},
        classes:
            "middle none rounded-lg bg-gray-900 py-3 px-6 text-center align-middle font-sans text-xs font-bold uppercase text-white shadow-md shadow-gray-900/10 transition-all hover:shadow-lg hover:shadow-gray-900/20 focus:opacity-[0.85] focus:shadow-none active:opacity-[0.85] active:shadow-none disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none",
        onClick: () {
          setState(() => count++);
        },
        [text('+')],
      ),
    ]);

    yield FlutterCounter(
      count: count,
      onChange: (value) {
        setState(() => count = value);
      },
    );
  }

  static get styles => [
        css('.counter', [
          css('&').flexbox(alignItems: AlignItems.center).box(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                border: Border.symmetric(
                    vertical:
                        BorderSide.solid(color: primaryColor, width: 1.px)),
              ),
          // css('button', [
          //   css('&')
          //       .text(fontSize: 2.rem)
          //       .box(width: 2.em, height: 2.em, border: Border.unset, cursor: Cursor.pointer)
          //       .box(radius: BorderRadius.all(Radius.circular(2.em)))
          //       .flexbox(justifyContent: JustifyContent.center, alignItems: AlignItems.center)
          //       .background(color: Colors.transparent),
          //   css('&:hover').background(color: const Color.hex('#0001')),
          // ]),
          css('span') //
              .box(
                  padding: EdgeInsets.symmetric(horizontal: 2.rem),
                  boxSizing: BoxSizing.borderBox,
                  minWidth: 2.5.em)
              .text(
                  color: primaryColor,
                  fontSize: 4.rem,
                  align: TextAlign.center),
        ]),
      ];
}
