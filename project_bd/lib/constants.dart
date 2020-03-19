import 'package:flutter/material.dart';

const kTextFieldDecoraction = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  // fillColor: Color.fromRGBO(144, 238, 144, .1),
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(118, 192, 68, .1), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(118, 192, 68, .1), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

const kTextTitle = TextStyle(
  letterSpacing: 2.5,
  color: Colors.black54,
  fontWeight: FontWeight.bold,
);

const kTextCategorie = TextStyle(
  fontSize: 12, 
  letterSpacing: 0.5, 
  color: Colors.black54,
);