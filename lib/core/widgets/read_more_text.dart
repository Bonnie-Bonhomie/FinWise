import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ReadMoreText({super.key, required this.text,
    this.maxLines = 2,
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isOverflowing = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final textSpan = TextSpan(
          text: widget.text,
          style: const TextStyle(fontSize: 14)
      );
      final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr
      )
        ..layout(
            maxWidth: constraints.maxWidth
        );
      isOverflowing = textPainter.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text, maxLines: isExpanded ? null : widget.maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),),
          if(isOverflowing)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(padding: const EdgeInsets.only(top: 6),
              child: Text(isExpanded? 'Read less': 'Read More', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),),
              ),
            )
        ],
      );
    });
  }
}
