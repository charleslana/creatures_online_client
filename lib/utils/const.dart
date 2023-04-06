import 'package:flutter/material.dart';

final List<Shadow> shadows = [
  const Shadow(
    // bottomLeft
    offset: Offset(-2, -2), color: Colors.black,
  ),
  const Shadow(
    // bottomRight
    offset: Offset(2, -2), color: Colors.black,
  ),
  const Shadow(
    // topRight
    offset: Offset(2, 2), color: Colors.black,
  ),
  const Shadow(
    // topLeft
    offset: Offset(-2, 2), color: Colors.black,
  ),
];
