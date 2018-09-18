import 'package:flutter/material.dart';

class Const {
	static const String typeWelfare = '福利';
	static const String typeAndroid = 'Android';
	static const String typeIOS = 'iOS';
	static const String typeVideo = '休息视频';
	static const String typeExpand = '拓展资源';
	static const String typeFrontEnd = '前端';
	static const String typeAll = "all";

	static final Category welfare = Category.sample('福利');
	static final Category android = Category.sample('Android');
	static final Category ios = Category.sample('iOS');
	static final Category video = Category.sample('休息视频');
	static final Category front = Category.sample('前端');
	static final Category all = Category.sample('all');

	static final Category classification = Category(name: '分类数据', code: 'data', subCategory: [
		all,
		welfare,
		android,
		ios,
		video,
		front
	]);

	static final Category xiandu = Category(name: '闲读', code: 'xiandu');
	static final Category today = Category(name: '今日干货', code: 'day');
}

class Category {
	String code;
	String name;

	List<Category> subCategory;

	Category({this.name, this.code, this.subCategory});

	factory Category.sample(name) => new Category(name: name, code: name);

}
