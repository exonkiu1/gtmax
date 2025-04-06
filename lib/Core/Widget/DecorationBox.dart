import 'package:flutter/material.dart';

Decoration decoration({bool color = false}) => BoxDecoration(
    color: color ? Color.fromARGB(255, 29, 40, 54) : null,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20));
