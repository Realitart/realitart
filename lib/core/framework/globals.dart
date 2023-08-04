import 'dart:math';

String loremIpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

String generateRandomLoremIpsum(int size) {
  int random = Random().nextInt(loremIpsum.length - size);
  String result = loremIpsum.substring(random, random + size);
  return result;
}

String generateRandomImgUrl() {
  int random = Random().nextInt(50);
  String result = 'https://picsum.photos/id/$random/200/300';
  return result;
}
