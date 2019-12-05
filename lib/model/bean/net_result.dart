class NetResult {
	int code;
	dynamic info;
	bool get successful => code == 0;

	NetResult ({this.code, this.info});

	factory NetResult.fromJson(Map<String, dynamic> map) {
		return NetResult(
			code: map['code'],
			info: map['info']
		);
	}
}