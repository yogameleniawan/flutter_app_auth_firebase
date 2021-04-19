import 'package:flutter/material.dart';

class Model {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  bool _passwordVisible = false;

  bool get passwordVisible => this._passwordVisible;

  set passwordVisible(bool value) => this._passwordVisible = value;

  TextEditingController get userIdController => this._userIdController;

  set userIdController(TextEditingController value) =>
      this._userIdController = value;

  TextEditingController get passwordController => this._passwordController;

  set passwordController(TextEditingController value) =>
      this._passwordController = value;

  clearAllModels() {
    _passwordController = TextEditingController();
    _userIdController = TextEditingController();
    _passwordVisible = false;
  }
}
