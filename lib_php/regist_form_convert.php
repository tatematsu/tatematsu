<?php
// @Auther N.Tatematsu 2010/07/30 Ver.1.2
// �y���[���pUTF8��SJIS�����R�[�h�ϊ��v���O����
// �����R�[�h�Ɗy���[���i�[�p��URL�p�����[�^��
// �쐬���Ȃ����B

	$email = $_GET["mail"];
	$name = htmlspecialchars( $_GET["name"] , ENT_QUOTES);
	$md = $_GET["md"];
//	$guest = $_GET["guest"];
	$id = $_GET["id"];
	$cd = $_GET["cd"];
	$free1 = htmlspecialchars( $_GET["from"] , ENT_QUOTES);

	$corp_name = htmlspecialchars( $_GET["co"] , ENT_QUOTES);
	$tel = $_GET["tel"];
	$pref = htmlspecialchars( $_GET["pref"] , ENT_QUOTES);

	// SHIFT-JIS�ɕϊ�
	$name_sjis = mb_convert_encoding( $name, "SJIS" , "UTF-8");
	$free1_sjis = mb_convert_encoding( $free1, "SJIS" , "UTF-8");

	$ext_prm = "";
	if( $corp_name ){	// ��Ж��������
		$corp_name_sjis = mb_convert_encoding( $corp_name, "SJIS" , "UTF-8");
		$ext_prm .= sprintf("&co=%s", urlencode( $corp_name_sjis ) );
	}
	if( $tel ){	// �d�b�ԍ��������
		// �d�b�ԍ��`�F�b�N
		$tel = preg_replace("/-/", "", $tel);
		if( preg_match( "/^\d{10}$/", $tel ) || preg_match("/^\d{11}$/", $tel ) ){

		}else{
			$tel = "not_tel_no";
		}
		$ext_prm .= sprintf("&tel=%s",$tel);
	}
	if( $pref ){	// �Z���i���������
		$pref_sjis = mb_convert_encoding( $pref, "SJIS" , "UTF-8");
		$ext_prm .= sprintf("&address=%s", urlencode( $pref_sjis ) );
	}

$url = 'http://www.rentakun.info/cgi-bin/dmail01/distribute/cgi-bin/apply.cgi'
		.sprintf("?name=%s", urlencode($name_sjis) )
		.sprintf("&mail=%s", $email )
		.sprintf("&free1=%s" , urlencode( $free1_sjis ) )
		.sprintf("&md=%s", $md )
//		.sprintf("&guest=%s", $guest )
		.sprintf("&id=%s" , $id )
		.sprintf("&cd=%s",urlencode( $cd ))
		.$ext_prm;

	// �t�H�[���ɓ]��
	header( "Location: $url");
// echo $url;
?>