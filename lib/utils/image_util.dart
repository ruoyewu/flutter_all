import 'dart:io';

import 'package:flutter/material.dart';

class ImageUtil {
	static const HTTP = "http";
	static const FILE = '/';

	static ImageProvider image(String pathOrUrl, {String placeHolder = ''}) {
		if (pathOrUrl == null || pathOrUrl == '') return AssetImage(placeHolder);
		try {
			if (pathOrUrl.startsWith(HTTP)) {
				return NetworkImage(pathOrUrl);
			} else {
				return FileImage(File(pathOrUrl));
			}
		} catch (e){
			return AssetImage(placeHolder);
		}
	}
}