class AppVersionModel {

  final bool showUpdate;

  AppVersionModel({required this.showUpdate});

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']?.toString().trim().toLowerCase() ?? '';
    return AppVersionModel(showUpdate: data == 'show');
  }

  @override
  String toString() => 'AppVersionModel(showUpdate: $showUpdate)';
}