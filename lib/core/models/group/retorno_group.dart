class RetornoGroup {
  final String user;
  final String nomeGrupo;
  final List<dynamic> adminUsers;
  final List<dynamic> comunUsers;
  final List<dynamic> tasks;
  final bool ativo;
  final String id;
  final String createdAt;
  final String updatedAt;

  RetornoGroup({
    required this.user,
    required this.nomeGrupo,
    required this.adminUsers,
    required this.comunUsers,
    required this.tasks,
    required this.ativo,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RetornoGroup.fromJson(Map<String, dynamic> json) {
    return RetornoGroup(
      user: json['user'] as String,
      nomeGrupo: json['nomeGrupo'] as String,
      adminUsers: json['adminUsers'] as List<dynamic>,
      comunUsers: json['comunUsers'] as List<dynamic>,
      tasks: json['tasks'] as List<dynamic>,
      ativo: json['ativo'] as bool,
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
