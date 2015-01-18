<?php

require("mailchimp-api-master/vendor/autoload.php");
$MailChimp = new \Drewm\MailChimp('614d68de97bc6c437f09ab924b2ab95e-us7');

/*

http://us7.api.mailchimp.com/1.3/?method=listMemberInfo
    &apikey=614d68de97bc6c437f09ab924b2ab95e-us7
    &id=6459a6757c
    &email_address=tatesan8@yahoo.co.jp
    &merge_vars=
    &output=php


$result = $MailChimp->call('lists/subscribe', array(
                'id'                => '6459a6757c',
                'email'             => array('email'=>'dev@tatematsu.jp'),
                'merge_vars'        => array('FNAME'=>'直文', 'LNAME'=>'立松'),
                'double_optin'      => false,
                'update_existing'   => true,
                'replace_interests' => false,
                'send_welcome'      => false,
            ));
print "<hr>";
print_r($result);
*/
//print"<hr>";
//print_r($MailChimp->call('lists/locations',array('id','6459a6757c') ));
//print"<hr>";
$members_array = $MailChimp->call('lists/members',array('id','6459a6757c') );

//現在時刻取得
$now_time = date("Y-m-d H:i:s");

//キュー配列用意
$step_01_que = array();
$step_02_que = array();
$step_03_que = array();
$step_04_que = array();
$step_05_que = array();
$step_06_que = array();
$step_07_que = array();

foreach ( $members_array['data'] as $value ){
	if( !$value['id'] || !$value['email'] || !$value['timestamp'] ){
		continue;
	}
//	print_r ( $value );
/*	print ( $value['id'] );
	print ( $value['email'] );
	print ( $value['timestamp'] );
*/
	//時刻判定変数を用意
	$span_time_1 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +3 day"));
	$span_time_2 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +6 day"));
	$span_time_3 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +9 day"));
	$span_time_4 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +12 day"));
	$span_time_5 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +15 day"));
	$span_time_6 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +18 day"));
	$span_time_7 = date("Y-m-d H:i:s",strtotime($value['timestamp']." +21 day"));

	//3日目まで
	if( $span_time_1 > $now_time ){
		print "メルマガ#1キューに入れる";
		array_push( $step_01_que , $value['id'] );
	}
	if( $span_time_1 < $now_time and $now_time < $span_time_2 ){
		print "メルマガ#2キューに入れる";
		array_push( $step_02_que , $value['id'] );
	}
	if( $now_time < $span_time_7 ){ //21日目以降なら
		print "メルマガ#3キューに入れる";
		array_push( $step_03_que , $value['id'] );
	}
	echo "<hr>";

}
print_r($step_01_que);
//一回目用のキャンペーンに送信指示

//キャンペーンを作成
//送信する。
//$result = $MailChimp->call('campaigns/send',array('cid','7006b9161e') );
//$obj = new stepmail_obj();
//二回目用のキャンペーンに送信指示

/*
class stepmail_obj {
	private $db_host ="";


}*/

?>