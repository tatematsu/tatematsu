<?php
//電話番号チェック

function isTelNumber($strIn){
	
    if( preg_match( "/\d{2,4}-\d{2,4}-\d{4}/", $strIn )  ) {
        return true;
    } else {
        return false;
    }
}

?>