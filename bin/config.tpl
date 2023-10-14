class Config {
  bool get debugMode => {{debug_mode}};
  String get baseAuth => '{{#base64}} {{base_auth}} {{/base64}}';
  int get port => {{port}};
}
