<?php

// メールアドレスチェック
function isValidInetAddress($data, $strict = false){

	    $regex = $strict ? '/^([.0-9a-z_+-]+)@(([0-9a-z-]+\.)+[0-9a-z]{2,})$/i' : '/^([*+!.&#$|\'\\%\/0-9a-z^_`{}=??:-]+)@(([0-9a-z-]+\.)+[0-9a-z]{2,})$/i';
	    if (preg_match($regex, trim($data), $matches)) {
	        return array($matches[1], $matches[2]);
	    } else {
	        return false;
	    }

}

?>