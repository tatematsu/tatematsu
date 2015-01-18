<?php

define('WP_USE_THEMES', false);
require('wp-blog-header.php'); // 共通関数を使うため

//屋合名
$business_name = "ウェブコンサルティングタテマツ";

// メール形式のチェック
require_once("./lib_php/mail_check.php");

// 電話番号のチェック
require_once("./lib_php/telnum_check.php");

// 都道府県データ
require_once("./lib_php/pref_data.inc");

// メール設定ファイル
require_once("./lib_php/mail_config.inc");

// 楽メール（ステップ）設定ファイル
require_once("./lib_php/rakumail_config.php");

$PHP = $_SERVER['SCRIPT_NAME'];

// モード
$mode = $_POST["mode"];

// 各項目読み込み
$name = htmlspecialchars( $_POST["name"] );
$email = htmlspecialchars( $_POST["email"] );
$url = htmlspecialchars( $_POST["url"] );
$tel = htmlspecialchars( $_POST["tel"] );
$mtel = htmlspecialchars( $_POST["mtel"] );
$address = $_POST["address"];
$ask = $_POST['ask'];
$memo = htmlspecialchars( $_POST["memo"] );


if( !$mode ){ // 確認画面

get_header();

//print_r( $_POST );

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
if ( !$ask ){
array_push( $err_msg , "該当するお問い合わせ内容にチェックしてください\n");
$err_flg = TRUE;
}

// 入力漏れ時の処理
if( $err_flg == TRUE ){
print<<<HTML
<h3 class="inquiry_h3">ご入力内容のご確認</h3>
<div id="error_info">
<h4>エラーで送信できませんでした。以下のご入力内容をご確認ください。</h4>
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
<label for="mtel">携帯電話　例）090-0000-0000</label><br>
<input style="width: 210px;" type="text" name="mtel" value='$mtel' /><br>
<label for="address">ご住所　例）名古屋市中区栄1-1-1</label><br>
<input style="width: 360px;" type="text" name="address" value='$address' /><br>
<div class="ask_area">
<label for="ask">お問い合わせ内容 <sup class="need">※</sup></label><br>
HTML;

print"<input type=\"checkbox\" name=\"ask[0]\" value=\"無料サイト集客力診断\" class=\"checkbox\"";
$ask[0] == TRUE ?print" checked":print"";
print">無料サイト集客力診断<br>\n";

print"<input type=\"checkbox\" name=\"ask[1]\" value=\"リスティング広告メニュー\" class=\"checkbox\"";
$ask[1] == TRUE ?print" checked":print"";
print">リスティング広告メニュー <br>\n";
print"<input type=\"checkbox\" name=\"ask[2]\" value=\"ウェブ集客コンサルティングメニュー\" class=\"checkbox\"";
$ask[2] == TRUE ?print" checked":print"";
print">ウェブ集客コンサルティングメニュー <br>\n";
print"<input type=\"checkbox\" name=\"ask[3]\" value=\"セミナー/ワークショップ\" class=\"checkbox\"";
$ask[3] == TRUE ?print" checked":print"";
print">セミナー/ワークショップ<br>\n";
print"<input type=\"checkbox\" name=\"ask[4]\" value=\"その他ご相談・お問い合わせ\"";
$ask[4] == TRUE ?print" checked":print"";
print"class=\"checkbox\">その他ご相談・お問い合わせ";

print<<<HTML
<br>
<br>
<label for="memo">お聞きになりたいこと・その他ご相談の詳細等ございましたらご記入ください</label>
<textarea name="memo" rows="7" cols="50">$memo</textarea>
</div><!-- ask //-->
ありがとうございました。クリックして送信してください→　<input class="inquiry_btn inquiry_submit" type="submit" value="問い合わせる" />
</form></div>
	
</div>

HTML;

// 入力した内容を確認表示
}else{

print<<<HTML
<!--**********************************************************///
contents-start ///-->
<div id="form_confirm">
<h3 class="inquiry_h3">ご入力内容の確認</h3>
<div class="cen">
<form method="POST" action=$PHP>
<p class="pre_send">ご記入頂きました事項にお間違えがないかご確認頂けましたら
【送信】ボタンを１回押してください。</p>

<table width="700px" id="formmail" cellspacing="3" cellpadding="3"
border="0" class="contact">
<tr><th>お名前</th><td>$name</td></tr>
<tr><th>メールアドレス</th><td>$email</td></tr>
<tr><th>URL</th><td>$url</td></tr>
<tr><th>ご住所</th><td>$address</td></tr>
<tr><th>携帯電話</th><td>$mtel</td></tr>
<tr><th>お電話番号</th><td>$tel</td></tr>
<tr><th>お問合せ内容</th><td>$ask[0]<br>$ask[1]<br>$ask[2]<br>$ask[3]<br>$ask[4]</td></tr>
<tr><th>その他・詳細内容</th><td>$memo</td></tr>
</table><div class="cen">

<div class="mess_button">
<a href="#" onclick="javascript:history.back()" class="back_confirm">前の画面に戻る</a>
<input type="submit" value="この内容で送信する" class="inquiry_btn"></div>

</div>
<input type="hidden" name="name" value='$name'>
<input type="hidden" name="email" value='$email'>
<input type="hidden" name="address" value='$address'>
<input type="hidden" name="url" value='$url'>
<input type="hidden" name="mtel" value='$mtel'>
<input type="hidden" name="tel" value='$tel'>
<input type="hidden" name="mode" value='send'>
<input type="hidden" name="ask" value='$ask[0],$ask[1],$ask[2],$ask[3],$ask[4]'>
<input type="hidden" name="memo" value='$memo'>
</form>
</div>
</div>
</div>
<!--**********************************************************///
contents-end ///-->

HTML;

}

get_footer();

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
."<< 携帯電話 >>\n"
.$mtel."\n\n"
."<< 電話番号 >>\n"
.$tel."\n\n"
."<< お問い合わせ内容 >>\n"
.$ask."について。\n\n"
."<< その他・詳細内容 >>\n"
.$memo."\n\n";

// ヘッダ情報
$header = "From: $email\n";
$header .= "X-Mailer: Tatematsu_Mail_AutoSender". phpversion(). "\n";

// 管理者へメール

//echo $message;
mb_send_mail($to, $subject , $message , $header);

// メッセージお客様向け
$message_customer .= $message;
$message_customer .="\n"
."======================================================================\n"
.$business_name."と末永いお付き合いのほど、よろしくお願いいたします。\n\n"
."info@tatematsu.jp\n"
."http://www.tatematsu.jp/\n"
."=======================================================================";

// ヘッダお客様向け情報
$header_customer = "From: $from\n";
$header_customer .= "X-Mailer: Tatematsu_Mail_AutoSender". phpversion().
"\n";

// 問合せしてきたお客様へメール送信
mb_send_mail($email, $subject_autosender, $message_customer,
$header_customer);


// 楽メールへバックグラウンド登録
// パラメータURLを作成して文字コード変換プログラムへ投げる configのid値
に注意する
//$rakumail_url = sprintf( "%s?name=%s&mail=%s&md=guest&id=%s&cd=文字",
//$rakumail_url , $name , $email , $plan_id )
."&from=tatematsu_jp"; // LP毎に書き換える

//echo $rakumail_url;
// 登録URLをたたく
// $result = file_get_contents( $rakumail_url );

// サンクスページへ飛ぶ
header('Location: /thanks/');

}
//debug
//print_r ($_POST);
exit;


?>