class DateUtil {
	static String formatMillis(int time, String format) {
		final date = DateTime.fromMillisecondsSinceEpoch(time);
		return _formatDateTime(date, format);
	}
	
	static String _formatDateTime(DateTime dateTime, String format) {
		return format
			.replaceFirst("YYYY", dateTime.year.toString())
			.replaceFirst('MM', dateTime.month.toString())
			.replaceFirst('dd', dateTime.day.toString())
			.replaceFirst('HH', dateTime.hour.toString())
			.replaceFirst('mm', dateTime.minute.toString())
			.replaceFirst('ss', dateTime.second.toString());
	}
}