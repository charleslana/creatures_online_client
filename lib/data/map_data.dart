import 'package:flutter/material.dart';

import 'image_data.dart';

List<Widget> getMap1() {
  return [
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(areaBootcamp1),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text('Page 1'),
      ),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(areaBootcamp2),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text('Page 2'),
      ),
    ),
  ];
}
