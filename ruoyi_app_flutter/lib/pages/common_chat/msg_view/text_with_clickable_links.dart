import 'dart:developer';

import 'package:flutter/material.dart';

class TextWithClickableLinks extends StatelessWidget {
  final String content;
  final double fontSize;
  final Color? textColor;
  final String? fontFamily;
  final Color linkColor;
  final String? searchKeyword;
  final bool? isHighlightSearchKeyword;
  final double lineHeight;

  const TextWithClickableLinks({
    super.key,
    required this.content,
    this.fontSize = 12.0,
    this.textColor,
    this.fontFamily,
    required this.linkColor,
    this.searchKeyword,
    this.isHighlightSearchKeyword,
    this.lineHeight = 1.35,
  });

  List<InlineSpan> _buildTextSpans() {
    final List<InlineSpan> spans = [];
    final RegExp urlRegex = RegExp("(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
    int currentPosition = 0;

    for (final match in urlRegex.allMatches(content)) {
      if (match.start > currentPosition) {
        final textBefore = content.substring(currentPosition, match.start);
        spans.add(_buildHighlightedTextSpan(textBefore));
      }

      final url = match.group(0)!;
      spans.add(
        WidgetSpan(
          child: _buildClickableUrlWidget(url),
        ),
      );

      currentPosition = match.end;
    }

    if (currentPosition < content.length) {
      spans.add(_buildHighlightedTextSpan(content.substring(currentPosition)));
    }

    return spans;
  }

  Widget _buildClickableUrlWidget(String url) {
    final List<TextSpan> urlSpans = [];
    int urlStart = 0;

    if (searchKeyword?.isNotEmpty ?? false) {
      final keywordRegex = RegExp(
        RegExp.escape(searchKeyword!),
        caseSensitive: false,
      );

      for (final match in keywordRegex.allMatches(url)) {
        if (match.start > urlStart) {
          urlSpans.add(TextSpan(
            text: url.substring(urlStart, match.start),
            style: _linkTextStyle(),
          ));
        }

        urlSpans.add(TextSpan(
          text: url.substring(match.start, match.end),
          style: _linkTextStyle().copyWith(
            color: Colors.black,
            backgroundColor: const Color(0xFFE0E0E0),
          ),
        ));

        urlStart = match.end;
      }
    }

    if (urlStart < url.length) {
      urlSpans.add(TextSpan(
        text: url.substring(urlStart),
        style: _linkTextStyle(),
      ));
    }

    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(2),
      hoverColor: const Color(0xFFEEEEEE).withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
        child: RichText(
          text: TextSpan(children: urlSpans),
          softWrap: true,
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.visible,
          textWidthBasis: TextWidthBasis.parent,
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    log('Launching URL: $url');
  }

  TextSpan _buildHighlightedTextSpan(String text) {
    if (searchKeyword?.isEmpty ?? true) {
      return TextSpan(
        text: text,
        style: _normalTextStyle(),
      );
    }

    final List<TextSpan> spans = [];
    int start = 0;
    final keywordRegex = RegExp(
      RegExp.escape(searchKeyword!),
      caseSensitive: false,
    );

    for (final match in keywordRegex.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: _normalTextStyle(),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: _normalTextStyle().copyWith(
          color: Colors.black,
          backgroundColor: const Color(0xFFE0E0E0),
          fontWeight: isHighlightSearchKeyword == true ? FontWeight.bold : FontWeight.w300,
        ),
      ));

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: _normalTextStyle(),
      ));
    }

    return TextSpan(children: spans);
  }

  TextStyle _normalTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      color: textColor ?? const Color(0xFF212121),
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      height: lineHeight,
    );
  }

  TextStyle _linkTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      color: linkColor,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
      height: lineHeight,
      decoration: TextDecoration.underline,
      decorationColor: linkColor.withOpacity(0.7),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: _buildTextSpans()),
      maxLines: null,
      overflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}