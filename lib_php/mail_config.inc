<?php
/* === メール関係の設定 ==*/

	$from = "naofumi@tatematsu.jp";
	
	// 返信先	
	$reply_to = 'naofumi@tatematsu.jp';
	
	// メール送信先
	$to = 'naofumi@tatematsu.jp';
	
// 集計データ受け取り用メールアドレス
//	$to_analytic = 'naofumi_tatematsu@toumei.co.jp';
//	$to_analytic = 'saori_yoshida@toumei.co.jp';

	// メールタイトル
	$subject = "tatematsu.jpからお問い合わせがありました。";

	// 自動返信タイトル
	$subject_autosender = "お問い合わせいただき、ありがとうございます。";

$message_customer = "
この度はウェブコンサルティングタテマツにお問い合わせ頂きまして、
誠にありがとうございます。

お問い合わせの回答・連絡は、
ご入力いただいたメールアドレスもしくはお電話にて返答させていただきます。

回答の目安は本日より遅くとも3日間となります。
1週間以上たっても連絡がない・メールが届かない場合は、
お手数ですが、再度ご連絡をお願い致します。

何卒よろしくお願い申し上げます。\n
";


?>