# ÈÕ^OpTvf[^ð²®
sub make_mailtag_tmp
{
	
	@base = (
	'o^ÒID',             # o^ÒID
	'ïÐ¼',               # ïÐ¼
	'ïÐ¼tKi',       # ïÐ¼tKi
	'¨¼O',               # ¨¼O
	'¨¼OtKi',       # ¨¼OtKi
	'[AhX',  # [AhX
	'dbÔ',          # dbÔ
	'FAXÔ',          # FAXÔ
	'URL',# URL
	'XÖÔ',             # XÖÔ
	's¹{§',             # s¹{§
	'ZP',               # ZP
	'ZQ',               # ZQ
	'ZR',               # ZR
	't[ÚP',         # t[ÚP
	't[ÚQ',         # t[ÚQ
	't[ÚR',         # t[ÚR
	't[ÚS',         # t[ÚS
	't[ÚT',         # t[ÚT
	't[ÚU',         # t[ÚU
	't[ÚV',         # t[ÚV
	't[ÚW',         # t[ÚW
	't[ÚX',         # t[ÚX
	't[ÚPO',       # t[ÚPO
	't[ÚPP',       # t[ÚPP
	't[ÚPQ',       # t[ÚPQ
	't[ÚPR',       # t[ÚPR
	't[ÚPS',       # t[ÚPS
	't[ÚPT',       # t[ÚPT
	't[ÚPU',       # t[ÚPU
	't[ÚPV',       # t[ÚPV
	't[ÚPW',       # t[ÚPW
	't[ÚPX',       # t[ÚPX
	't[ÚQO',       # t[ÚQO
	'©',                   # ©
	'©tKi',           # ©tKi
	'¼',                   # ¼
	'¼tKi',           # ¼tKi
	't[ÚQP',       # t[ÚQP
	't[ÚQQ',       # t[ÚQQ
	't[ÚQR',       # t[ÚQR
	't[ÚQS',       # t[ÚQS
	't[ÚQT',       # t[ÚQT
	't[ÚQU',       # t[ÚQU
	't[ÚQV',       # t[ÚQV
	't[ÚQW',       # t[ÚQW
	't[ÚQX',       # t[ÚQX
	't[ÚRO',       # t[ÚRO
	);
	my @_tmp;
	$_tmp[0] = '';
	$_tmp[1] = '';
	$_tmp[2] = '';
	splice( @base, 19, 0, @_tmp );
	
	$base[51] = 'o^ú(N)';
	$base[52] = 'o^ú()';
	$base[53] = 'o^ú(ú)';
	$base[54] = 'zMú(N)';
	$base[55] = 'zMú()';
	$base[56] = 'zMú(ú)';
	$base[57] = 'NbNðN';
	
	# vr[pÉC³
	for( my $i=0; $i<=$#base; $i++ ){
		$temdata_base[$i] = qq|$base[$i]|;
		$temdata[$i] = qq|<em><font color="#336600">&lt;$base[$i]&gt;</font></em>|;
	}
	
	#my $now    = time;
	#my $result = 1;
}

$mail_reflect_tag =<<"END";
                                                
                                                  <option value="">-- o^f[^}ü^O --</option>
                                                  <option value="&lt;%id%&gt;">o^ÒID@@@@@@&lt;%id%&gt;</option>
                                                  <option value="&lt;%co%&gt;">ïÐ¼@@@@@@&lt;%co%&gt;</option>
                                                  <option value="&lt;%_co%&gt;">ïÐ¼tKi@@&lt;%_co%&gt;</option>
                                                  <option value="&lt;%sei%&gt;">©@@@@@@@@&lt;%sei%&gt;</option>
                                                  <option value="&lt;%_sei%&gt;">©tKi@@@@&lt;%_sei%&gt;</option>
                                                  <option value="&lt;%mei%&gt;">¼@@@@@@@@&lt;%mei%&gt;</option>
                                                  <option value="&lt;%_mei%&gt;">¼tKi@@@@&lt;%_mei%&gt;</option>
                                                  <option value="&lt;%name%&gt;">¨¼O@@@@@@&lt;%name%&gt;</option>
                                                  <option value="&lt;%_name%&gt;">¨¼OtKi@@&lt;%_name%&gt;</option>
                                                  <option value="&lt;%mail%&gt;">[AhX@@&lt;%mail%&gt;</option>
                                                  <option value="&lt;%tel%&gt;">dbÔ@@@@@&lt;%tel%&gt;</option>
                                                  <option value="&lt;%fax%&gt;">FAXÔ @@@@@&lt;%fax%&gt;</option>
                                                  <option value="&lt;%url%&gt;">URL @@@@@@@&lt;%url%&gt;</option>
                                                  <option value="&lt;%code%&gt;">XÖÔ@@@@@&lt;%code%&gt;</option>
                                                  <option value="&lt;%address%&gt;">s¹{§@@@@@&lt;%address%&gt;</option>
                                                  <option value="&lt;%address1%&gt;">ZP@@@@@@&lt;%address1%&gt;</option>
                                                  <option value="&lt;%address2%&gt;">ZQ@@@@@@&lt;%address2%&gt;</option>
                                                  <option value="&lt;%address3%&gt;">ZR@@@@@@&lt;%address3%&gt;</option>
                                                  <option value="&lt;%free1%&gt;">t[ÚP@@@&lt;%free1%&gt;</option>
                                                  <option value="&lt;%free2%&gt;">t[ÚQ@@@&lt;%free2%&gt;</option>
                                                  <option value="&lt;%free3%&gt;">t[ÚR@@@&lt;%free3%&gt;</option>
                                                  <option value="&lt;%free4%&gt;">t[ÚS@@@&lt;%free4%&gt;</option>
                                                  <option value="&lt;%free5%&gt;">t[ÚT@@@&lt;%free5%&gt;</option>
                                                  <option value="&lt;%free6%&gt;">t[ÚU@@@&lt;%free6%&gt;</option>
                                                  <option value="&lt;%free7%&gt;">t[ÚV@@@&lt;%free7%&gt;</option>
                                                  <option value="&lt;%free8%&gt;">t[ÚW@@@&lt;%free8%&gt;</option>
                                                  <option value="&lt;%free9%&gt;">t[ÚX@@@&lt;%free9%&gt;</option>
                                                  <option value="&lt;%free10%&gt;">t[ÚPO@@&lt;%free10%&gt;</option>
                                                  <option value="&lt;%free11%&gt;">t[ÚPP@@&lt;%free11%&gt;</option>
                                                  <option value="&lt;%free12%&gt;">t[ÚPQ@@&lt;%free12%&gt;</option>
                                                  <option value="&lt;%free13%&gt;">t[ÚPR@@&lt;%free13%&gt;</option>
                                                  <option value="&lt;%free14%&gt;">t[ÚPS@@&lt;%free14%&gt;</option>
                                                  <option value="&lt;%free15%&gt;">t[ÚPT@@&lt;%free15%&gt;</option>
                                                  <option value="&lt;%free16%&gt;">t[ÚPU@@&lt;%free16%&gt;</option>
                                                  <option value="&lt;%free17%&gt;">t[ÚPV@@&lt;%free17%&gt;</option>
                                                  <option value="&lt;%free18%&gt;">t[ÚPW@@&lt;%free18%&gt;</option>
                                                  <option value="&lt;%free19%&gt;">t[ÚPX@@&lt;%free19%&gt;</option>
                                                  <option value="&lt;%free20%&gt;">t[ÚQO@@&lt;%free20%&gt;</option>
                                                  <option value="&lt;%free21%&gt;">t[ÚQP@@&lt;%free21%&gt;</option>
                                                  <option value="&lt;%free22%&gt;">t[ÚQQ@@&lt;%free22%&gt;</option>
                                                  <option value="&lt;%free23%&gt;">t[ÚQR@@&lt;%free23%&gt;</option>
                                                  <option value="&lt;%free24%&gt;">t[ÚQS@@&lt;%free24%&gt;</option>
                                                  <option value="&lt;%free25%&gt;">t[ÚQT@@&lt;%free25%&gt;</option>
                                                  <option value="&lt;%free26%&gt;">t[ÚQU@@&lt;%free26%&gt;</option>
                                                  <option value="&lt;%free27%&gt;">t[ÚQV@@&lt;%free27%&gt;</option>
                                                  <option value="&lt;%free28%&gt;">t[ÚQW@@&lt;%free28%&gt;</option>
                                                  <option value="&lt;%free29%&gt;">t[ÚQX@@&lt;%free29%&gt;</option>
                                                  <option value="&lt;%free30%&gt;">t[ÚRO@@&lt;%free30%&gt;</option>
                                                  <option value="&lt;%ryear%&gt;">o^úiNj@@@&lt;%ryear%&gt;</option>
                                                  <option value="&lt;%rmon%&gt;">o^úij@@@&lt;%rmon%&gt;</option>
                                                  <option value="&lt;%rday%&gt;">o^úiúj@@@&lt;%rday%&gt;</option>
                                                  <option value="&lt;%year%&gt;">zMúiNj@@@&lt;%year%&gt;</option>
                                                  <option value="&lt;%mon%&gt;">zMúij@@@&lt;%mon%&gt;</option>
                                                  <option value="&lt;%day%&gt;">zMúiúj@@@&lt;%day%&gt;</option>
                                                  <option value="&lt;%cancel%&gt;">NbNðN&lt;%cancel%&gt;</option>
END
# ®¹æÊp
$thanks_reflect_tag =<<"END";
                                                  <option value="">-- o^Òf[^}ü^O --</option>
                                                  <option value="&lt;%id%&gt;">o^ÒID@@@@@@&lt;%id%&gt;</option>
END
# üÍmFæÊp
$confirm_reflect_tag =<<"END";
                                                  <option value="">-- o^Òf[^}ü^O --</option>
                                                  <option value="&lt;%co%&gt;">ïÐ¼@@@@@@&lt;%co%&gt;</option>
                                                  <option value="&lt;%_co%&gt;">ïÐ¼tKi@@&lt;%_co%&gt;</option>
                                                  <option value="&lt;%sei%&gt;">©@@@@@@@@&lt;%sei%&gt;</option>
                                                  <option value="&lt;%_sei%&gt;">©tKi@@@@&lt;%_sei%&gt;</option>
                                                  <option value="&lt;%mei%&gt;">¼@@@@@@@@&lt;%mei%&gt;</option>
                                                  <option value="&lt;%_mei%&gt;">¼tKi@@@@&lt;%_mei%&gt;</option>
                                                  <option value="&lt;%name%&gt;">¨¼O@@@@@@&lt;%name%&gt;</option>
                                                  <option value="&lt;%_name%&gt;">¨¼OtKi@@&lt;%_name%&gt;</option>
                                                  <option value="&lt;%mail%&gt;">[AhX@@&lt;%mail%&gt;</option>
                                                  <option value="&lt;%tel%&gt;">dbÔ@@@@@&lt;%tel%&gt;</option>
                                                  <option value="&lt;%fax%&gt;">FAXÔ @@@@@&lt;%fax%&gt;</option>
                                                  <option value="&lt;%url%&gt;">URL @@@@@@@&lt;%url%&gt;</option>
                                                  <option value="&lt;%code%&gt;">XÖÔ@@@@@&lt;%code%&gt;</option>
                                                  <option value="&lt;%address%&gt;">s¹{§@@@@@&lt;%address%&gt;</option>
                                                  <option value="&lt;%address1%&gt;">ZP@@@@@@&lt;%address1%&gt;</option>
                                                  <option value="&lt;%address2%&gt;">ZQ@@@@@@&lt;%address2%&gt;</option>
                                                  <option value="&lt;%address3%&gt;">ZR@@@@@@&lt;%address3%&gt;</option>
                                                  <option value="&lt;%free1%&gt;">t[ÚP@@@&lt;%free1%&gt;</option>
                                                  <option value="&lt;%free2%&gt;">t[ÚQ@@@&lt;%free2%&gt;</option>
                                                  <option value="&lt;%free3%&gt;">t[ÚR@@@&lt;%free3%&gt;</option>
                                                  <option value="&lt;%free4%&gt;">t[ÚS@@@&lt;%free4%&gt;</option>
                                                  <option value="&lt;%free5%&gt;">t[ÚT@@@&lt;%free5%&gt;</option>
                                                  <option value="&lt;%free6%&gt;">t[ÚU@@@&lt;%free6%&gt;</option>
                                                  <option value="&lt;%free7%&gt;">t[ÚV@@@&lt;%free7%&gt;</option>
                                                  <option value="&lt;%free8%&gt;">t[ÚW@@@&lt;%free8%&gt;</option>
                                                  <option value="&lt;%free9%&gt;">t[ÚX@@@&lt;%free9%&gt;</option>
                                                  <option value="&lt;%free10%&gt;">t[ÚPO@@&lt;%free10%&gt;</option>
                                                  <option value="&lt;%free11%&gt;">t[ÚPP@@&lt;%free11%&gt;</option>
                                                  <option value="&lt;%free12%&gt;">t[ÚPQ@@&lt;%free12%&gt;</option>
                                                  <option value="&lt;%free13%&gt;">t[ÚPR@@&lt;%free13%&gt;</option>
                                                  <option value="&lt;%free14%&gt;">t[ÚPS@@&lt;%free14%&gt;</option>
                                                  <option value="&lt;%free15%&gt;">t[ÚPT@@&lt;%free15%&gt;</option>
                                                  <option value="&lt;%free16%&gt;">t[ÚPU@@&lt;%free16%&gt;</option>
                                                  <option value="&lt;%free17%&gt;">t[ÚPV@@&lt;%free17%&gt;</option>
                                                  <option value="&lt;%free18%&gt;">t[ÚPW@@&lt;%free18%&gt;</option>
                                                  <option value="&lt;%free19%&gt;">t[ÚPX@@&lt;%free19%&gt;</option>
                                                  <option value="&lt;%free20%&gt;">t[ÚQO@@&lt;%free20%&gt;</option>
                                                  <option value="&lt;%free21%&gt;">t[ÚQP@@&lt;%free21%&gt;</option>
                                                  <option value="&lt;%free22%&gt;">t[ÚQQ@@&lt;%free22%&gt;</option>
                                                  <option value="&lt;%free23%&gt;">t[ÚQR@@&lt;%free23%&gt;</option>
                                                  <option value="&lt;%free24%&gt;">t[ÚQS@@&lt;%free24%&gt;</option>
                                                  <option value="&lt;%free25%&gt;">t[ÚQT@@&lt;%free25%&gt;</option>
                                                  <option value="&lt;%free26%&gt;">t[ÚQU@@&lt;%free26%&gt;</option>
                                                  <option value="&lt;%free27%&gt;">t[ÚQV@@&lt;%free27%&gt;</option>
                                                  <option value="&lt;%free28%&gt;">t[ÚQW@@&lt;%free28%&gt;</option>
                                                  <option value="&lt;%free29%&gt;">t[ÚQX@@&lt;%free29%&gt;</option>
                                                  <option value="&lt;%free30%&gt;">t[ÚRO@@&lt;%free30%&gt;</option>
END
# _uIvgCp
$opt_in_reflect_tag = $confirm_reflect_tag . qq|\n<option value="&lt;%opt-in%&gt;">o^URLN@@&lt;%opu-in%&gt;</option>|;
# _uIvgAEgp
$opt_opt_reflect_tag = $confirm_reflect_tag . qq|\n<option value="&lt;%opt-out%&gt;">ðURLN@@&lt;%opu-out%&gt;</option>|;

sub remakeTag
{
	my $option = &Click'getTag();
	$mail_reflect_tag .= "\n". $option;
}
1;
