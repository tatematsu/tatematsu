<?php

define('WP_USE_THEMES', false);
require('wp-blog-header.php'); // 共通関数を使うため

// メール形式のチェック
require_once("./lib_php/mail_check.php");

// 電話番号のチェック
require_once("./lib_php/telnum_check.php");

// 都道府県データ
require_once("./lib_php/pref_data.inc");

// メール設定ファイル
require_once("./lib_php/mail_config_lp.inc");

// 楽メール設定
//$rakumail_apply_url ="http://www.tatematsu.jp/mail_dist/distribute/cgi-bin/apply.cgi";
//$plan_id ="129224568657702";

//MAILCHIMP API KEY
$mailchimp_api_key="614d68de97bc6c437f09ab924b2ab95e-us7";
//MAILCHIMP LIST ID
$list_id = "6459a6757c";

$PHP = $_SERVER['SCRIPT_NAME'];

// モード
$mode = $_POST["mode"];

// 各項目読み込み
$name = htmlspecialchars( $_POST["name"] );
$email = htmlspecialchars( $_POST["email"] );
$url = htmlspecialchars( $_POST["url"] );
$tel = htmlspecialchars( $_POST["tel"] );
//$mtel = htmlspecialchars( $_POST["mtel"] );
$address = htmlspecialchars( $_POST["address"] );
$ask = $_POST['ask'];
if( $_POST['ask_contents'] ){
	$ask_contents = $_POST['ask_contents'];
}
$memo = htmlspecialchars( $_POST["memo"] );

//print_r($_POST);

if( !$mode ){ // 確認画面

?>
<!DOCTYPE html>
<!--[if IE 6]>
<html id="ie6" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 7]>
<html id="ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html id="ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 6) | !(IE 7) | !(IE 8)  ]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
	<title>ご入力内容のご確認 | <?php bloginfo('name'); ?></title>
<link rel="profile" href="http://gmpg.org/xfn/11" />
<!--link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>" //-->
<link rel="stylesheet" type="text/css" media="all" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/tatematsuJP_style.css" />
<link rel="stylesheet" type="text/css" media="print" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/print.css" />
<link rel="pingback" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/" />
<!--[if lt IE 9]>
<script src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/js/html5.js" type="text/javascript"></script>
<![endif]-->
<?php
	if ( is_singular() && get_option( 'thread_comments' ) )
		wp_enqueue_script( 'comment-reply' );

	wp_head();
?>
</head>
<!-- GA Code -->
<script type="text/javascript">

	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-333460-1']);
	_gaq.push(['_trackPageview']);
	(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
</script>
<!-- GA Code -->
<body <?php body_class(); ?>>

<div id="wrapper">
<div id="header">
<a href="http://www.tatematsu.jp/"><img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/headers/site-logo.png" class="site_logo" border=0/></a>
<div id="web_license">
	<img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/adwords_license.jpg">
	<img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/yahoo_pro2012.jpg">
</div><!-- end of license //-->
</div>



<?php

// 入力エラーチェック
$err_flg = NULL;
$err_msg = array("");

if ( !$name ){
array_push( $err_msg , "お名前が入力されていません。\n");
$err_flg = TRUE;
}
// if ( !$postal_code ){
// array_push( $err_msg , "郵便番号が入力されていません。\n");
// $err_flg = TRUE;
// }
if ( !$address ){
array_push( $err_msg , "ご住所が入力されておりません。\n");
$err_flg = TRUE;
}
// if ( !$street ){
// array_push( $err_msg , "番地（建物名〜号室）が入力されていません。\n");
// $err_flg = TRUE;
// }
if ( !$tel ){
array_push( $err_msg , "電話番号が入力されていません。\n");
$err_flg = TRUE;
}
if ( !isTelNumber($tel) ){
array_push( $err_msg , "電話番号をハイフン「-」付でご入力ください。\n");
$err_flg = TRUE;
}

if ( !$email ){
array_push( $err_msg , "メールアドレスが入力されていません。\n");
$err_flg = TRUE;
}
// メールアドレス確認と照合チェック
// if( $email != $email_confirm ){
// array_push( $err_msg , "確認メールアドレスと異なります。\n");
// $err_flg = TRUE;
// }
// メール形式チェック
if( isValidInetAddress($email) == FALSE ){
array_push( $err_msg , "メールアドレスの形式が正しくありません。\n");
$err_flg = TRUE;
}
//echo $ask."/".$ask_contents;
if ( $ask == "" && $ask_contents =="" ){
	array_push( $err_msg , "該当するお問い合わせ内容にチェックしてください\n");
	$err_flg = TRUE;
}else{
	if( $ask || $ask_contents =="" ){
		$ask_target = TRUE;
		foreach( $ask as $value ){
			$ask_contents .= $value."/";
		}
		$ask_contents = rtrim( $ask_contents ,"/");
	}
}

// 入力漏れ時の処理
if( $err_flg == TRUE ){
print<<<HTML
<div id="content">
<h3 class="inquiry_h3">ご入力内容のご確認</h3>
<div id="reinput">
<div id="error_info">
<h4>以下のご入力内容をもう一度ご確認ください。</h4>
HTML;
// エラー内容の表示
foreach ( $err_msg as $key => $value ){
print "<p class=\"warning\">".$value."</p>\n";
}
print<<<HTML
必要事項・ご入力内容を再度ご確認の上、「問い合わせる」ボタンをクリックしてください。
</div>
<div id="inquiry_form"><form action=$PHP method="post">
<label for="name">お名前 <sup class="need">※</sup></label><br>
<input class="name" type="text" name="name" value='$name' /><br>
<label for="email">メールアドレス<sup class="need">※</sup>　例）mail＠your.com</label><br>
<input class="email" type="text" name="email" value='$email' /><br>
<label for="url">URL（サイトをお持ちの場合）　例）www.homepage.com</label><br>
<input class="url" type="text" name="url" value='$url' /><br>
<label for="tel">お電話番号 <sup class="need">※</sup>ハイフン「-」付　例）052-000-0000</label><br>
<input style="width: 210px;" type="text" name="tel" value='$tel' /><br>
<label for="address">ご住所　例）名古屋市中区栄1-1-1</label><br>
<input style="width: 360px;" type="text" name="address" value='$address' /><br>
<div class="ask_area">
HTML;

if( $ask_target == false ){

// 通常のお問い合わせ
print<<<HTML
<label for="ask">お問い合わせ内容 <sup class="need">※</sup></label><br>
<input type="checkbox" name="ask[5]" value='withcソリューション（詳細にパッケージ名をご記入下さい）' class="checkbox">withcソリューション（詳細にパッケージ名をご記入下さい）<br>
<input type="checkbox" name="ask[0]" value='無料サイト集客力診断' class="checkbox">無料サイト集客力診断<br>
<input type="checkbox" name="ask[1]" value='リスティング広告メニュー' class="checkbox">リスティング広告メニュー <br>
<input type="checkbox" name="ask[2]" value='ウェブ集客コンサルティングメニュー' class="checkbox">ウェブ集客コンサルティングメニュー <br>
<input type="checkbox" name="ask[3]" value='セミナー/ワークショップ' class="checkbox">セミナー/ワークショップ<br>
<input type="checkbox" name="ask[4]" value='その他ご相談・お問い合わせ' class="checkbox">その他ご相談・お問い合わせ
<br><br>
HTML;

}else{

// 目的プラン・ターゲットがある場合
print<<<HTML
<label for="ask">お問い合わせ内容</label><br />
	<strong class="remark">$ask_contents</strong>
<input type="hidden" name="ask_contents" value='$ask_contents' />
<br><br>
HTML;

}

print<<<HTML
<label for="memo">お聞きになりたいこと・その他ご相談の詳細等ございましたらご記入ください</label>
<textarea name="memo" rows="7" cols="50">$memo</textarea>
</div><!-- ask //-->
ありがとうございました。クリックして送信してください→　<input class="inquiry_btn inquiry_submit" type="submit" value="問い合わせる" />
</form></div>

</div>
</div><!-- reinput -->
&nbsp;
HTML;

// 入力した内容を確認表示
}else{

print<<<HTML
<div id="content">
<div id="form_confirm">
<h3 class="inquiry_h3">ご入力内容の確認</h3>
<div class="cen">
<form method="POST" action=$PHP>
<p class="pre_send">ご記入頂きました事項にお間違えがないかご確認頂けましたら
【送信する】ボタンを１回押してください。</p>

<table width="700px" id="formmail" cellspacing="3" cellpadding="3"
border="0" class="contact">
<tr><th>お名前</th><td>$name</td></tr>
<tr><th>メールアドレス</th><td>$email</td></tr>
<tr><th>URL</th><td>$url</td></tr>
<tr><th>ご住所</th><td>$address</td></tr>
<tr><th>お電話番号</th><td>$tel</td></tr>
<tr><th>お問合せ内容</th><td>$ask_contents</td></tr>
<tr><th>その他・詳細内容</th><td>$memo</td></tr>
</table><div class="cen">

<div class="mess_button">
<a href="#" onclick="javascript:history.back()" class="back_confirm">前の画面に戻る</a>
<input type="submit" value="送信する" class="inquiry_btn"></div>

</div>
<input type="hidden" name="name" value='$name'>
<input type="hidden" name="email" value='$email'>
<input type="hidden" name="address" value='$address'>
<input type="hidden" name="url" value='$url'>
<input type="hidden" name="tel" value='$tel'>
<input type="hidden" name="mode" value='send'>
<input type="hidden" name="ask_contents" value='$ask_contents'>
<input type="hidden" name="memo" value='$memo'>
</form>
</div>
</div>
<!--**********************************************************///
contents-end ///-->

HTML;

}

//get_footer();

?>
<div class="clearfix"></div>
</div>

<div id="footer">
<div class="copyright" style="padding:none;">
<ul>
<li><a href="http://www.tatematsu.jp/privacy/">プライバシーポリシー</a></li>
<li><a href="http://www.tatematsu.jp/profile/">サイト運営者情報/プロフィール</a></li>
</ul>
</div>
</div>
</div>
<?php wp_footer(); ?>

<script src="http://f1.nakanohito.jp/lit/index.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">try { var lb = new Vesicomyid.Bivalves("119039"); lb.init(); } catch(err) {} </script>

</body>
</html>

<?php





}else if( $mode == "send" ){ // メール送信モード

mb_language('ja');
mb_internal_encoding( 'UTF-8' );

$message = "<< お名前 >>\n"
.$name."\n\n"
."<< メールアドレス >>\n"
.$email."\n\n"
."<< ご住所 >>\n"
.$address."\n\n"
."<< URL >>\n"
.$url."\n\n"
."<< 電話番号 >>\n"
.$tel."\n\n"
."<< お問い合わせ内容 >>\n"
.$ask_contents."について。\n\n"
."<< その他・詳細内容 >>\n"
.$memo."\n\n";

// ヘッダ情報管理者向け
$header = "From: $email\n";
$header .= "X-Mailer: Tatematsu_Mail_AutoSender". phpversion(). "\n";

// メッセージお客様向け
$message_customer .= $message;
$message_customer .="\n"
."======================================================================\n"
.$business_name."と末永いお付き合いのほど、よろしくお願いいたします。\n\n"
.$business_email."　【お電話 050-5866-6511】\n"
.$business_url."\n"
."=======================================================================";

// ヘッダお客様向け情報
$header_customer = "From: $from\n";
$header_customer .= "X-Mailer: Tatematsu_Mail_AutoSender". phpversion().
"\n";

	try {
		// 管理者へメール
//		echo $message;
		if ( !wp_mail( $to, $subject , $message , $header ) ){
			$error = "お客様窓口へのメール送信に失敗しました。";
			throw new Exception($error);
		}

		// 問合せしてきたお客様へメール送信
		if( !wp_mail( $email , $subject_autosender , $message_customer , $header_customer ) ){
			$error = "お客様のお控えメールの送信に失敗しました。";
			throw new Exception($error);
		}

		// Add to MailChimp List
		require("mailchimp-api-master/vendor/autoload.php");
		$MailChimp = new \Drewm\MailChimp( $mailchimp_api_key );
		$result = $MailChimp->call('lists/subscribe', array(
                'id'                => $list_id,
                'email'             => array('email'=> $email ),
                'merge_vars'        => array('FNAME'=> $name ),
                'double_optin'      => false,
                'update_existing'   => true,
                'replace_interests' => false,
                'send_welcome'      => false,
         ));
		 if( $result["status"] == "error" ){
			$mailchimp_error_msg = $name."《".$email."》からのメルマガが登録できませんでした。(".date("Y-m-d").")";
			wp_mail( $to , "MailChimp 登録エラー" , $mailchimp_error_msg , $header );
		 }

		// 楽メールへバックグラウンド登録
//		$rakumail_url = sprintf( "%s?name=%s&mail=%s&md=guest&id=%s&cd=文字", $rakumail_apply_url , $name , $email , $plan_id )."&from=tatematsu_jp&reged=1";

		// 登録URLたたく
//		$result = file_get_contents( $rakumail_url );

		// サンクスページへ飛ぶ
		header('Location: http://www.tatematsu.jp/thanks/');

	}catch( Exception $e ){
		
		print "メールが送れませんでした。:".$e->getMessage()."\n";
	}
}
exit;