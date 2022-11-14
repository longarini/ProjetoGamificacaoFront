class GroupData {
  final String id;
  final String nomeGrupo;

  const GroupData({
    required this.id,
    required this.nomeGrupo,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['_id'] as String,
      nomeGrupo: json['nomeGrupo'] as String,
    );
  }
}
