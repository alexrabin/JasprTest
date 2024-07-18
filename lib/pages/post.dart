import 'package:jaspr/server.dart';
import 'dart:math';

class PostPage extends AsyncStatelessComponent {
  const PostPage({required this.id, super.key});

  final String id;

  @override
  Stream<Component> build(BuildContext context) async* {
    final post = await Future.delayed(const Duration(seconds: 1), () {
      final random = Random();
      final randomNumber = random.nextInt(1001);
      return Post(
        id: id,
        title: 'Post $id',
        body: 'This is the body of post $id. With value $randomNumber',
      );
    });
    yield div([
      h1([text(post.title)]),
      p([text(post.body)]),
    ]);
  }
}

class Post {
  const Post({required this.id, required this.title, required this.body});

  final String id;
  final String title;
  final String body;
}
