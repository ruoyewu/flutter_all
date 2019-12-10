class Result {
  List<dynamic> entityList;
  bool hasMore;
  String nextUrl;
  int pbVersion;
  int sessionId;
  int status;
  int timestamp;

  bool get isSuccessful => status == 200;

  bool get hasData => entityList != null && entityList.length > 0;

  Result(
      {this.entityList,
      this.hasMore,
      this.nextUrl,
      this.pbVersion,
      this.sessionId,
      this.status,
      this.timestamp});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      entityList: json['entity'] != null ? (json['entity'] as List) : null,
      hasMore: json['has_more'],
      nextUrl: json['next_url'],
      pbVersion: json['pb_version'],
      sessionId: json['session_id'],
      status: json['status'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_more'] = this.hasMore;
    data['next_url'] = this.nextUrl;
    data['pb_version'] = this.pbVersion;
    data['session_id'] = this.sessionId;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    if (this.entityList != null) {
      data['entity'] = this.entityList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
