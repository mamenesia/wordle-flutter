import 'package:flutter/material.dart';
import 'package:wordle/wordle/wordle.dart';

const _qwerty = [
  ["Q", "w", "E", "R", "T", "Y", "U", "I", "O", "P"],
  ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
  ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "DEL"]
];

class Keyboard extends StatelessWidget {
  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<Letter> letters;
  const Keyboard({
    Key? key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty
          .map(
            (keyRow) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyRow.map(
                (letter) {
                  if (letter == 'DEL') {
                    return _KeyBoardButton.delete(onTap: onDeleteTapped);
                  } else if (letter == 'ENTER') {
                    return _KeyBoardButton.enter(onTap: onEnterTapped);
                  }

                  final letterKey = letters.firstWhere(
                    (e) => e.val == letter,
                    orElse: () => Letter.empty(),
                  );

                  return _KeyBoardButton(
                    onTap: () => onKeyTapped(letter),
                    letter: letter,
                    backgroudColor: letterKey != Letter.empty()
                        ? letterKey.backgroundColor
                        : Colors.grey,
                  );
                },
              ).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyBoardButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color backgroudColor;
  final String letter;
  const _KeyBoardButton({
    Key? key,
    this.height = 48,
    this.width = 30,
    required this.onTap,
    required this.backgroudColor,
    required this.letter,
  }) : super(key: key);

  factory _KeyBoardButton.delete({required onTap}) => _KeyBoardButton(
        width: 56,
        onTap: onTap,
        backgroudColor: Colors.grey,
        letter: 'DEL',
      );

  factory _KeyBoardButton.enter({required onTap}) => _KeyBoardButton(
        width: 56,
        onTap: onTap,
        backgroudColor: Colors.grey,
        letter: 'ENTER',
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 2.0,
      ),
      child: Material(
          color: backgroudColor,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: Text(letter,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          )),
    );
  }
}
