class NetResult {
	bool result;
	dynamic info;

	NetResult ({this.result, this.info});

	factory NetResult.fromJson(Map<String, dynamic> map) {
		return NetResult(
			result: map['result'],
			info: map['info']
		);
	}
}