// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:gank_flutter_app/main.dart';

void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(new MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });

  var str = "{\'id\': \'cBwQaPTl/SX4QgaINAqcngB1cCx9xB+ebthiIN1vxPk=_165fb60d9d4:9e923:3da9d93\', 'originId': 'https://daily.zhihu.com/story/9696731', 'fingerprint': 'c6a2c0c4', 'title': '想让人工智能翻译更准确？其实有多少人工，才有多少智能', 'crawled': 1537520753108, 'published': 1537520738000, 'origin': {'streamId': 'feed/http://feeds.feedburner.com/zhihu-daily', 'title': '知乎日报', 'htmlUrl': 'https://news-at.zhihu.com/api/4/stories/latest?client=0'}, 'alternate': [{'href': 'https://daily.zhihu.com/story/9696731', 'type': 'text/html'}], 'summary': {'content': '<div>\\n<div><div></div><div>\\n<a href=\"https://zhuanlan.zhihu.com/p/45010541\">\\n<div>相关新闻</div>\\n<div>同传译员揭发科大讯飞 AI 同传造假：用人类翻译冒充 AI</div>\\n<i></i>\\n</a>\\n</div></div><div><div>\\n<h2>机器翻译技术的进展已经或将要对人工翻译市场带来什么样的影响？</h2><div><div>\\n<img src=\"http://pic1.zhimg.com/v2-84940f0b07eb76e019f5a1b0ea7d7708_is.jpg\">\\n<span>高勤，</span><span>谷歌翻译</span>\\n</div><div>\\n<p>机器翻译技术和其他所有机器 XX 技术（如纺纱，挖煤）对人工 XX 技术的影响我认为是一样的。我们可以回忆一下当年政治课学习过的纺织工人砸蒸汽机厂的故事。为什么他们要砸呢？因为蒸汽纺纱比起人工，虽然质量可能差一些，却可以快速上规模，以极低的价格冲击市场。而大多数人都只需要普通质量的便宜货。机器翻译也是一样，它的发展已经到了可以以极低的价格提供“还过得去”的翻译。那么我们就可以类比翻译市场以后的情况会是如何。</p><p>首先，翻译市场并不会萎缩，就像纺织机器使得纺织市场扩大了一样。一些只需要“差不多”翻译的应用，例如一些电商网站的本地化，本来可能因为人工翻译的成本过高而直接被放弃——毕竟商家不会做亏本的生意——在机器翻译下可能就会上马。而这些中又可能会使用人工翻译审看翻译结果，做质量控制。这就像纺织工人转行做纺织厂的质检一样。对比一下：在只有人工翻译的时候，这个生意并不存在，在机器翻译下，反而有了一些人工翻译的生意。不仅机器翻译市场，人工翻译市场也扩大了。</p><p>其次，高端的人工翻译不会消亡。即使到了今天，一份手绣的双面蜀绣仍然价格不菲。毕竟有些翻译是一件创造性的劳动。 “本产品售价 180 元人民币”这样的翻译，用机器翻译自然毫无问题（我估计也不会有人想每天翻译这种句子赚钱吧），而想把“过去就像攥在手中的一把干沙，自以为攥得很紧，其实早就从指缝中流光了。记忆是一条早已干涸的河流，只在毫无生气的河床中剩下零落的砾石。”这样的句子翻译好可就不是容易的事了。即使机器可以翻译得准确，人类也不会满意的。俗话说文无第一，人工翻译当然还要保留人类的自豪——文人相轻嘛。</p><p>最后，技术提升往往带来效率的提升，让人可以更高效地完成工作。蒸汽机会带来搬砖效率的提高，但是它仍然需要驾驶员；而驾驶员如果不用蒸汽机，一天也搬不了几块砖。人们常说有多少人工，就有多少智能，机器翻译也不例外。技术的发展会带来围绕机器翻译的各种职位，如译后编辑，质量控制等等。事实上 CAT（机器辅助翻译）已经开始成了许多翻译学校的必修课。如果能够熟练掌握这些技术，会在市场占有先机。拥有先进生产力的企业和个人会占据先机。</p><p>人类的技术从来不会停下来等待，不断用机器增强人类的能力，解放生产力是必然趋势。人工翻译市场拥抱和利用机器翻译也是必然的。最后还是用我们熟悉的古文结束：登高而招，臂非加长也，而见者远；顺风而呼，声非加疾也，而闻者彰。假舆马者，非利足也，而致千里；假舟楫者，非能水也，而绝江河。君子性非异也，善假于物也。</p>\\n</div>\\n</div><div><a href=\"http://www.zhihu.com/question/51097484\">查看知乎讨论<span></span></a></div></div><div>\\n<h2>人工智能应用在翻译上，准确率还有待进一步提升，难在哪些方面？</h2><div><div>\\n<img src=\"http://pic1.zhimg.com/v2-ab0823edff00dc49ddda33bb3aacc318_is.jpg\">\\n<span>青格乐，</span><span>二语习得博士</span>\\n</div><div>\\n<p>前面有回答提到语气、情感、情绪方面的问题，且不说这些语义因素。就说普通的准确率问题，人工智能在翻译上还和专业的人脑译者有很大的差距，这个差距在商务、商业、学科专业方面的翻译上可能相对小一些，但是在人文社科类例如文学著作的翻译方面差距就非常之大了。</p><p>但是翻译真正难的地方，不就在于译者的审美、品位和认知不同所带来的差异吗？</p><p>很多词语在语境中所构成的复杂的意义的解读是考察译者功力的难点。举一个例子（这个例子是专门和从事翻译研究的同事要来的）：</p><p><img alt src=\"http://pic1.zhimg.com/70/v2-a2e99cd3f69ad37c5b28b0079048b9e0_b.jpg\"></p><p>这是她在翻译课上给学生留的作业中的一段，里面的这个 ironies 和 cynicism 大部分学生都翻成了“讽刺”和“愤世嫉俗”，而好的翻译应该是“反差”和“趣味”，从讽刺和愤世嫉俗到反差和趣味，需要译者的对整段文字的把握，并能给一个非常恰当贴切的中文对应。大部分学生做不到，而机器更做不到。</p><p>这一段英文中还有一个 the trained eye of a resident，我当时也问了同事，这个怎么翻呢？“经受了熏陶的居民眼光吗？”，她告诉我，正式出版时，这里翻译成了“老上海人”。多么简洁而精妙！</p><p>所以，每当问起她担不担心自己的饭碗被抢走，她都满不在乎，她说：</p><p><img alt src=\"http://pic4.zhimg.com/70/v2-29a3872acf2c807bb4a5caf5392d99c7_b.jpg\"></p>\\n</div>\\n</div><div><a href=\"http://www.zhihu.com/question/264870303\">查看知乎讨论<span></span></a></div></div></div>\\n</div>', 'direction': 'ltr'}, 'visual': {'url': 'none'}, 'canonicalUrl': 'http://daily.zhihu.com/story/9696731', 'unread': True, 'engagement': 0}";
  var t = json.decode(str);
  print(t);
}
