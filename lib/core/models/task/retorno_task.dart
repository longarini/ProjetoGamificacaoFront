class RetornoTask {
  final String groupId;
  final String nomeTask;
  final String descricao;
  final int pontos;
  final bool ativo;
  final String id;
  final String createdAt;
  final String updatedAt;

  RetornoTask({
    required this.groupId,
    required this.nomeTask,
    required this.descricao,
    required this.pontos,
    required this.ativo,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RetornoTask.fromJson(Map<String, dynamic> json) {
    return RetornoTask(
      groupId: json['groupId'] as String,
      nomeTask: json['nomeTask'] as String,
      descricao: json['descricaoTask'] as String,
      pontos: json['pontosTask'] as int,
      ativo: json['ativo'] as bool,
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
