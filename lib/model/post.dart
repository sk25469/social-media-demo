class PostModel {
  String postId;
  String ownerId;
  String username;
  String description;
  String mediaUrl;

  PostModel({
    required this.postId,
    required this.ownerId,
    required this.description,
    required this.mediaUrl,
    required this.username,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        ownerId = json['ownerId'],
        username = json['username'],
        description = json['description'],
        mediaUrl = json['mediaUrl'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['ownerId'] = ownerId;
    data['description'] = description;
    data['mediaUrl'] = mediaUrl;

    data['username'] = username;
    return data;
  }
}
