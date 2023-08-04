class DataModel {
  String title;
  int port;
  String branchName;
  String date;

  DataModel({
    required this.title,
    required this.port,
    required this.branchName,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'port': port,
      'branch': branchName,
      'date': date,
    };
  }
}
