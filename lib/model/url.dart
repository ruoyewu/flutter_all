class URL {
	static const QINGMANG_HOST = 'http://ripple.qingmang.me';
	static const WEB_HOST = 'http://www.wuruoye.com/proxy';

	static const SEARCH = QINGMANG_HOST + '/api/v2/apps/search.json';
	static const APP_DETAIL = QINGMANG_HOST + '/api/v2/apps/appsupdatetime.json';
	static const ARTICLE = QINGMANG_HOST + '/api/v2/feed.json';
	static const RECOMMEND = QINGMANG_HOST + '/api/v2/apps/index.json';
	static const ALL_SECTION = QINGMANG_HOST + '/api/v2/apps/allsections.json';
	static const SECTION = QINGMANG_HOST + "/api/v2/apps/sections.json";
	static const RECOMMEND_LIST = '/api/v2/apps/manualbox.json';

	static const PROXY_ARTICLE = WEB_HOST + '/api/v2/feed.json';
	static const PROXY_APP_DETAIL = WEB_HOST + '/api/v2/apps/appsupdatetime.json';
	static const PROXY_SEARCH = WEB_HOST + '/api/v2/apps/search.json';
	static const PROXY_RECOMMEND = WEB_HOST + '/api/v2/apps/index.json';
	static const PROXY_ALL_SECTION = WEB_HOST + '/api/v2/apps/allsections.json';
	static const PROXY_SECTION = WEB_HOST + "/api/v2/apps/sections.json";
	static const PROXY_RECOMMEND_LIST = WEB_HOST + '/api/v2/apps/manualbox.json';
}