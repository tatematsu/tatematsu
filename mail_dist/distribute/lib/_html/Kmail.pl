package Kmail;

$POP3 = 1;

$ERR{'1'} = qq|POP3サーバーが見つからないため接続できませんでした。<br>POP3サーバー名をご確認ください。|;
$ERR{'2'} = qq|認証が拒否されたため接続できませんでした。<br>「アカウント名」「パスワード」をご確認ください。|;

sub main
{
	my $line = shift;
	my $action = $main'param{'act'};
	my( $title, $main );
	
	# メール受信
	local $root = $main'myroot;
	my $libpop3 = "${'root'}lib/netpop3_pl.cgi";
	eval{ require $libpop3; };
	if( $@ ){
		$POP3 = 0;
	}
	
	if( defined $main'param{'receive'} ){
		( $title, $main ) = &result();
		return $title, $main;
	}elsif( $action eq 'config' ){
		( $title, $main ) = &config($line);
		return $title, $main;
	}elsif( $action eq 'renew' ){
		( $title, $main )= &renew();
		return $title, $main;
	}
}

sub check
{
	if( !$POP3 ){
		&main'make_plan_page( 'plan', '', 'エラーが発生しました。<br><br>perlモジュールがインストールされていないため空メール機能は利用できません。<br><br>モジュール: Net/POP3.pm（perlモジュール）<br><br>詳しくは、サーバー管理者様にお問い合わせください。' );
		exit;
	}
}

sub config
{
	&check();
	
	my $line = shift;
	my $on1 = $line->[92] ? ' checked="checked"': '';
	my $pop1 = $line->[93];
	my $account1 = $line->[94];
	my $pass1 = $line->[95];
	my $on2 = $line->[96] ? ' checked="checked"': '';
	my $pop2 = $line->[97];
	my $account2 = $line->[98];
	my $pass2 = $line->[99];
	
	my $id = $main'param{'id'} -0;
	my $title = '空メール設定';
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td><strong>空メール設定</strong>の更新および<strong>受信</strong>を行います。</td>
                                                </tr>
                                                <tr>
                                                  <td>設定を更新する場合は、入力後「更新を反映」ボタンをクリックしてください。 </td>
                                                </tr>
                                                <tr>
                                                  <td>空メールの手動受信を行う場合は「空メールを受信する」ボタンをクリックしてください。</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">【空メール機能\とは】<br>
                                                                <br>
                                                                空メール機能\とは、件名や本文に何も入力しないメールを指定のメールアドレスあてへ送ってもらい購読登録を行うシステムです。 <br>
                                                                登録するメールアドレスの入力を行う必要がないため、手間の軽減や正確なメールアドレスを取得することが可能\です。<br>
                                                                空メール機能\のご利用には、必ず専用のメールアカウントが必要です。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table>
                                                    <br>
                                                    <table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#FF0000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><font color="#FF0000">【ご注意】<br>
                                                                <br>
                                                                </font>・空メール機能\においては、定期的に空メールの受信状況をチェックする<br>
                                                                必要があるため、ＣＲＯＮの設定を推奨いたします。<br>
                                                                <a href="http://www.raku-mail.com/manual/cron.htm" target="_blank"><font color="#0000FF">（ＣＲＯＮの解説・設定方法）</font></a><br>
                                                                <br>
                                                                ・ＣＲＯＮの最小実行間隔はレンタルサーバー毎に制限が異なるため<br>
                                                                空メール機能\にてＣＲＯＮご利用される場合は、予\め確認をお願いいたします。<br>
                                                                <br>
                                                                ・低価格帯のサーバーの場合、ＣＲＯＮの最小実行間隔は１時間程度のものが多いようです。上記のサーバーの場合、ＣＲＯＮを設定した場合におきましても、登録者が空メールを送信してから楽メールからの自動返信が届くまで最大で約１時間のブランクが生じます。上記のブランクを極力なくしたい場合は、ＣＲＯＮの最小実行間隔の短いサーバをご利用いただく必要がございます。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table>
                                                    <br></td>
                                                </tr>
                                                <tr>
                                                  <td><table border="0" align="center" cellpadding="0" cellspacing="10">
                                                      <tr>
                                                        <td align="center"><input type="submit" name="receive" value="　空メールを受信する　"></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■空メール登録設定</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">機能\設定</td>
                                                              <td bgcolor="#FFFFFF"><input name="on1" type="checkbox" id="on1" value="1"$on1>
                                                                空メールを受信する</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">ここにチェックを入れると、指定のメールサーバーから空メールを受信し登録処理を行います。<br>
                                                                空メールは「空メールを受信する」ボタンによる手動受信か、もしくは<font color="#FF0000">「クーロン」「配信タグ」</font>の自動送信設定（※トップページ参照）の起動により受信処理が行われます。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">POP3サーバー名</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop1" type="text" id="pop1" size="30" value="$pop1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">空メールを受信するメールサーバーを入力してください。</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">メールアカウント </td>
                                                              <td bgcolor="#FFFFFF"><input name="account1" type="text" id="account1" size="30" value="$account1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">接続するサーバーのメールアカウント名を入力してください。<br>
                                                                <font color="#FF0000">※ほかに利用していない専用のアカウントをご指定ください。</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">パスワード</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass1" type="password" id="pass1" size="30" value="$pass1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">メールアカウントのパスワードを入力してください。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr>
                                                  <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■空メール解除設定</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">機能\設定</td>
                                                              <td bgcolor="#FFFFFF"><input name="on2" type="checkbox" id="on2" value="1"$on2>
                                                                空メールを受信する</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">ここにチェックを入れると、指定のメールサーバーから空メールを受信し解除処理を行います。<br>
空メールは「空メールを受信する」ボタンによる手動受信か、もしくは<font color="#FF0000">「クーロン」「配信タグ」</font>の自動送信設定（※トップページ参照）の起動により受信処理が行われます。</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">POP3サーバー名</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop2" type="text" id="pop2" size="30" value="$pop2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">空メールを受信するメールサーバーを入力してください。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">メールアカウント </td>
                                                              <td bgcolor="#FFFFFF"><input name="account2" type="text" id="account2" size="30" value="$account2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">接続するサーバーのメールアカウント名を入力してください。<br>
                                                                <font color="#FF0000">※ほかに利用していない専用のアカウントをご指定ください。</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">パスワード</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass2" type="password" id="pass2" size="30" value="$pass2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">メールアカウントのパスワードを入力してください。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="renew">
                                                    <input name="md" type="hidden" id="md" value="kmail">
                                                    <input type="submit" name="Submit" value="　更新を反映　"></td>
                                                </tr>
                                                <tr>
                                                  <td><font color="#FF0000"><br>
                                                    </font><strong>○「空メール」受信の際に送られるメール文の設定について</strong><br>
                                                    <br>
                                                    「配信日程・本文」のページにて設定した日程・メール文にて配信が行われます。<br>
なお、「空メール」は仕様上、登録の際にお名前等の項目情報を<br>
取得する事ができませんので、本文の作成の際にはご注意ください。<br>
<br>
<strong>○自動受信について<br>
<br>
</strong>受信設定が有効の場合、<font color="#FF0000">「クーロン」「配信タグ」</font>の自動送信設定（※トップページ参照）の起動により
自動的に受信処理が行われます。<strong><br>
<br>
○プランが停止状態の場合について<br>
<br>
</strong>手動受信の場合は「稼動・停止」に関係なく受信します。<br>
自動受信の場合は「稼動中」の場合のみ受信します。<br>
なお、「配信時間帯」の設定には影響を受けません。</td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub renew
{
	&check();
	
	my $table = "";
	if( $main'param{'on1'} ){
		# 接続テスト
		my $ref = &connect({ 'h'=>$main'param{'pop1'},'u'=>$main'param{'account1'},'p'=>$main'param{'pass1'} });
		$table .= &errRef( 0, $ref );
	}
	if( $main'param{'on2'} ){
		my $ref2 = &connect({ 'h'=>$main'param{'pop2'},'u'=>$main'param{'account2'},'p'=>$main'param{'pass2'} });
		# 接続テスト
		$table .= &errRef( 1, $ref2 );
	}
	if( $table ne "" ){
		&main'make_plan_page( 'plan','',$table );
		exit;
	}
	
	$main'param{'action'} = 'kmail';
	&main'renew();
	$main'param{'act'} = 'config';
	&main'make_plan_page( 'plan', 'kmail' );
}

sub connect
{
	my $opts = shift;
	
	# ホスト
	my $host = $opts->{'h'};
	# アカウント
	my $user = $opts->{'u'};
	# パスワード
	my $pass = $opts->{'p'};
	
	# 接続
	my $pop = &Weblogic::Pop3'connect($host,$user,$pass,$apop);
	return $pop;
}


sub errRef
{
	my( $t, $pop ) = @_;
	
	if( $pop != 1 && $pop != 2 ){
		$pop->quit();
		return;
	}
	
	my $host = $t ? '空メール解除設定': '空メール登録設定';
	
	my $table = <<"END";
<table>
<tr>
<td align="left" colspan="2">
<font color="#FF0000">POP3サーバーに接続できませんでした。($host)</font>
<td>
</tr>
<tr>
<td width="20">&nbsp;</td>
<td>
$ERR{$pop}<br>
<td>
</tr>
<table><br><br>
END
	return $table;
}

sub result
{
	my $id = $main'param{'id'} -0;
	my $title = '空メール受信';
	
	my $line = "";
	my $plan = $main'myroot . $main'data_dir . $main'log_dir . $main'plan_txt;
	open( PLAN, "<$plan" );
	while(<PLAN>){
		chomp;
		my $t = $_ -0;
		if( $t == $id ){
			my @line = split(/\t/);
			$line = [@line];
			last;
		}
	}
	close(PLAN);
	
	if( $line eq '' ){
		&main'make_plan_page( 'plan', '', '指定のプランが見つかりません' );
	}
	
	my $counter = &counter(1);
	my( $result1, $result2, $f ) = &receive( $line, $counter );
	$counter->('reset');
	
	my $rest = $f ? '<strong><font color="#FF0000">指定の送信数を超えたため、受信処理を中断しました。<br>もう一度受信処理を行ってください。</font></strong><br><br>': '';
	
	my $main = <<"END";
<form name="form1" method="post" action="">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td>以下の空メールを受信しました。</td>
                                                </tr>
                                                <tr>
                                                  <td>&nbsp;</td>
                                                </tr>
                                                
                                                
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td>$rest</td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■空メール登録</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">受信数</td>
                                                              <td bgcolor="#FFFFFF">$result1->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">登録数</td>
                                                              <td bgcolor="#FFFFFF">$result1->{'regist'}件</td>
                                                            </tr>
                                                            
                                                            
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr>
                                                  <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■空メール解除</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">受信数</td>
                                                              <td bgcolor="#FFFFFF">$result2->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">解除数</td>
                                                              <td bgcolor="#FFFFFF">$result2->{'delete'}件</td>
                                                            </tr>
                                                            
                                                            
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr align="center">
                                                  <td>&nbsp;</td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub receive
{
	my( $line, $counter, $sleep ) = @_;
	
	my %result1;
	my %result2;
	
	$result1{'sum'} = '受信設定されていません';
	$result2{'sum'} = '受信設定されていません';
	$result1{'regist'} = 0;
	$result2{'delete'} = 0;
	
	if( $line->[92] ){
		my %opts;
		$opts{'h'} = $line->[93];
		$opts{'u'} = $line->[94];
		$opts{'p'} = $line->[95];
		my $pop = &connect( {%opts} );
		if( $pop == 1 || $pop == 2 ){
			$result1{'sum'} = qq|<font color="#FF0000">$ERR{$pop}</font>|;
		}else{
			
			my $ref_mailindex = $pop->list();
			my @mailindex = sort {$a<=>$b } keys %$ref_mailindex;
			$result1{'sum'} = @mailindex . '通';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # 受信メールヘッダを取得
				my $addr = &getAddr( $heads->{'From'} );
				if( $addr ne "" ){
					if( &regist($line,$addr, $counter) ){
						$result1{'regist'}++;
					}
				}
				$pop->delete($id);
				if( $counter->('check') ){
					return {%result1},{%result2}, 1;
				}
			}
			$pop->quit();
			$counter->('sleep') if( $sleep );
		}
	}
	if( $line->[96] ){
		my %opts;
		$opts{'h'} = $line->[97];
		$opts{'u'} = $line->[98];
		$opts{'p'} = $line->[99];
		my $pop = &connect( {%opts} );
		if( $pop == 1 || $pop == 2 ){
			$result1{'sum'} = qq|<font color="#FF0000">$ERR{$pop}</font>|;
		}else{
			
			my $ref_mailindex = $pop->list();
			my @mailindex = sort {$a<=>$b } keys %$ref_mailindex;
			$result2{'sum'} = @mailindex . ' 通';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # 受信メールヘッダを取得
				my $addr = &getAddr( $heads->{'From'} );
				if( $addr ne "" ){
					my $s = &delete($line,$addr,$counter);
					if( $s ){
						$result2{'delete'} += $s;
					}
				}
				$pop->delete($id);
				if( $counter->('check') ){
					return {%result1},{%result2}, 1;
				}
			}
			$pop->quit();
			$counter->('sleep') if( $sleep );
		}
	}
	
	return {%result1},{%result2}, 0;
}

sub getAddr
{
	local $_ = shift;
	( $from ) = ( /<([^>+])>/io );
	if( $from eq '' ){
		( $from ) = ( /([0-9a-zA-Z\-\_\.\!\#\$\%\&\'\*\+\-\/\=\?\^\_\`\{\|\}\~]+\@[0-9a-zA-Z\-\_\.]+)/io );
	}
	
	# エラーログ
	unless( &main'chk_email($from) ){
		#&print_errlog( "アドレス抽出失敗(getAddr) -> $_" );
	}
	
	return $from;
}

sub regist
{
	my( $line, $addr, $counter ) = @_;
	
	my $id = $line->[0] -0;
	my $csvpath = "$main'myroot$main'data_dir$main'csv_dir$line->[6]";
	my $queuepath = "$main'myroot$main'data_dir$main'queue_dir$line->[7]";
	my $logpath = "$main'myroot$main'data_dir$main'log_dir$line->[8]";
	my $utf = $line->[60] -0;
	my $ra_conf = $line->[77] -0; # 管理者通知専用本文利用フラグ
	my $tag_data = $line->[82];
	&Pub'ssl($line->[83], $line->[84]);
	
	#---------------------------#
	# 受付拒否
	#---------------------------#
	if ( $line->[38] ) {
		foreach ( (split(/,/, $line->[38])) ) {
			if ( index($addr, $_) >= 0 ) {
				return;
			}
		}
	}
	
	#--------------------------------#
	# 既存の登録者データからIDを取得 #
	#--------------------------------#
	my $index;
	unless ( open(CSV, "$csvpath" ) ) {
		return;
	}else {
		while( <CSV> ) {
			chomp;
			my ( $id, $mail ) = ( split(/\t/) )[0, 5];
			if ( !$line->[42] && $mail eq $addr ) {
				# 同一のメールアドレスが登録されています。
				close(CSV);
				return 0;
			}
			$index = $id if( $index < $id );
		}
	}
	close(CSV);
	$index++;
	
	
	#---------------------------#
	# 転送用タグ取得            #
	#---------------------------#
	my( $urlTag, $other ) = &Click'roadTag( $tag_data );
	
	my( $step, $dates ) = split(/<>/, $line->[36] );
	my $n = 2;
	my %stepConf;
	foreach( split(/,/, $step ) ){
		my( $inter, $config, $code ) = split(/\//);
		$stepConf{$n} = $config -0;
		$uniq = $code if( $n == $target );
		$n++;
	}
	
	
	
	my $date = time;
	$index = sprintf("%05d", $index);
	$userID = $index;
	my $sk = ( split(/,/, $line->[35]) )[1];
	my $check = ($sk)? '': 0;
	my @par = ();
	$par[19] = &main'the_text($date);
	$par[20] = &main'the_text($check);
	$par[21] = &main'the_text($date);
	$par[0]  = $index;
	$par[5] = $addr;
	
	if( $stepConf{'2'} ){
		# 一時停止
		$par[52] = 1;
	}
	
	#--------------------------------#
	# 追加                           #
	#--------------------------------#
	my $newline =  join("\t", @par) . "\n";
	my $tmp = $main'myroot. $main'data_dir. $main'csv_dir. 'TMP-'. $$. time. '.cgi';
	open(CSV, "<$csvpath");
	open(TMP, ">$tmp");
	while(<CSV>){
		print TMP $_;
	}
	print TMP $newline;
	close(CSV);
	close(TMP);
	chmod 0606, $tmp;
	rename $tmp, $csvpath;
	
	
	#--------------------------------#
	# 送信                           #
	#--------------------------------#
	my $senderror;
	if ( !$sk || $line->[40] ) {
		# 登録メールの送信
		my $rh_body = &main'get_body( $queuepath );
		$line->[9] =~ s/<br>/\n/gi;
		$line->[10] =~ s/<br>/\n/gi;
		$line->[11] =~ s/<br>/\n/gi;
		
		local ( $subject, $message ) = &main'make_send_body( 0, $rh_body, $line->[9], $line->[10], $line->[11] );
		# 転送タグ変換
		my $unic = $id. '-0';
		my $forward_urls;
		($message, $forward_urls) = &Click'analyTag($par[0], $message, $urlTag, $unic, $forward);
		
		my $jis = ($main'CONTENT_TYPE eq 'text/html')? 1: 0;
        $subject = &main'include( \@par, $subject );
		$message = &main'include( \@par, $message, $jis );
		if ( !$sk ) {
			$senderror = &main'send( $line->[4], $line->[3], $par[5], $subject, $message,"","",$line );
			$counter->();
			
			# 配信ログに追加
			unless ( $senderror ) {
				open(LOG, ">>$logpath");
				print LOG "$par[0]\t$par[5]\t$par[3]\t$date\t0\t$subject\n";
				close(LOG);
			}
			# アクセス集計用データ生成
			&Click'setForward_t( $forward_urls, $unic );
		}
		# 管理者宛へ送信
		if ( $line->[40] ) {
			local %ra;
			$ra{'flag'} = 0;
			my $senderName = $line->[3];
			if( $ra_conf ){
				local ( $ra_subject, $ra_message ) = &main'make_send_body( 'ra', $rh_body, $line->[9], $line->[10], $line->[11] );
				my $jis = ($main'CONTENT_TYPE eq 'text/html')? 1: 0;
        		$subject = &main'include( \@par, $ra_subject );
				$message = &main'include( \@par, $ra_message, $jis );
				$ra{'flag'} = 1;
				$ra{'addr'} = $par[5];
				$senderName = &userSender(\@par);
			}
			&main'send( $line->[4], $senderName, $line->[5], $subject, $message, '', {%ra} );
			$counter->();
		}
	}
	return 1;
}

sub delete
{
	my( $line, $addr ) = @_;
	
	my $id = $line->[0] -0;
	my $csvpath = "$main'myroot$main'data_dir$main'csv_dir$line->[6]";
	my $queuepath = "$main'myroot$main'data_dir$main'queue_dir$line->[7]";
	my $logpath = "$main'myroot$main'data_dir$main'log_dir$line->[8]";
	my $utf = $line->[60] -0;
	my $a_conf = $line->[85] -0; # 管理者通知専用本文利用フラグ
	my $now = time;
	
	&Pub'ssl($line->[83], $line->[84]);
	
	
	#--------------------------------#
	# 削除                           #
	#--------------------------------#
	my $tmp = $main'myroot. $main'data_dir. $main'csv_dir. 'TMP-'. $$. time. '.cgi';
	open(TMP, ">$tmp");
	chmod 0606, $tmp;
	
	my $much = 0;
	my @par = ();
	unless ( open(CSV, "<$csvpath" ) ) {
		unlink $tmp;
		return;
	}else {
		while( <CSV> ) {
			chomp;
			my ( $id, $mail ) = ( split(/\t/) )[0, 5];
			if( $mail eq $addr ) {
				# 同一のメールアドレスをチェック
				$much++;
				@par = split(/\t/);
				next;
			}
			print TMP $_, "\n";
		}
	}
	close(CSV);
	close(TMP);
	rename $tmp, $csvpath;
	
	return 0 if( !$much );
	
	#--------------------------------#
	# 送信                           #
	#--------------------------------#
	my $senderror;
	my $sendck = ( split(/,/, $line->[35]) )[3];
	if( !$sendck || $a_conf ){
        # 解除メールの送信
        my $rh_body = &main'get_body( $queuepath );
        $line->[9] =~ s/<br>/\n/gi;
        $line->[10] =~ s/<br>/\n/gi;
        $line->[11] =~ s/<br>/\n/gi;
        local ( $subject, $message ) = &main'make_send_body( 'c', $rh_body, $line->[9], $line->[10], $line->[11] );
		my $jis = ($main'CONTENT_TYPE eq 'text/html')? 1: 0;
        $subject = &main'include( \@par, $subject );
		$message = &main'include( \@par, $message, $jis );
        if( !$sendck ){
			$senderror = &main'send( $line->[4], $line->[3], $par[5], $subject, $message,"","",$line );
        	# 配信ログに追加
        	my $now = time;
        	unless ( $senderror ) {
        	    open(LOG, ">>$logpath");
        	    print LOG "$par[0]\t$par[5]\t$par[3]\t$now\tc\t$subject\n";
        	    close(LOG);
        	}
		}
		# 管理者宛へ送信(解除メール)
		if( $a_conf ) {
			local %ra;
			$ra{'flag'} = 0;
			my $senderName = $line->[3];
			if( $line->[86] ){
				local ( $ra_subject, $ra_message ) = &main'make_send_body( 'ca', $rh_body, $line->[9], $line->[10], $line->[11] );
				my $jis = ($main'CONTENT_TYPE eq 'text/html')? 1: 0;
        		$subject = &main'include( \@par, $ra_subject );
				$message = &main'include( \@par, $ra_message, $jis );
				$ra{'flag'} = 1;
				$ra{'addr'} = $par[5];
				$senderName = &userSender(\@par);
			}
			&main'send( $line->[4], $senderName, $line->[5], $subject, $message, '', {%ra} );
		}
		
    }
	return $much;
}

sub userSender
{
	my( $array ) = @_;
	my $seimei = $array->[37].$array->[39];
	my $name = $array->[3];
	
	my $sender = $seimei;
	$sender = $name if( $sender eq '' );
	return $name;
}

sub run
{
	if( $ENV{'REQUEST_METHOD'} eq "" || $ENV{'QUERY_STRING'} eq 'run' ){
		
		# メール受信
		local $root = $main'myroot;
		my $libpop3 = "${'root'}lib/netpop3_pl.cgi";
		eval{ require $libpop3; };
		if( $@ ){
			return;
		}
		
		my $counter = &counter();
		
		my $plan = $main'myroot. $main'data_dir. $main'log_dir. $main'plan_txt;
		open( PLAN, "<$plan" );
		while(<PLAN>){
			chomp;
			my @line = split(/\t/);
			next if( !$line[37] );
			$main'param{'id'} = $line[0]-0;
			my( $h1,$h2, $f ) = &receive([@line], $counter, 1);
			if( $f ){
				close(PLAN);
				if( $ENV{'QUERY_STRING'} eq 'run' ){
					print "Content-type: image/gif", "\n\n";
					binmode(STDOUT);
					print "\n";
					exit;
				}else{
					# Cron終了
					exit;
				}
			}
		}
		close(PLAN);
		$counter->('reset');
	}
}

sub counter
{
	my $manual = shift;
	my $lockfile = &main'lock();
	my $m = &get_method();
	my $c = 0;
	
	return sub{
		my $check = shift;
		
		if( $check eq 'check' ){
			if( $manual ){
				if( $c >= $m->{'each'} ){
					&main'rename_unlock( $lockfile );
					return 1;
				}
			}elsif( $m->{'method'} ){
				if( $c >= $m->{'partition'} ){
					&main'rename_unlock( $lockfile );
					sleep( $m->{'sleep'} );
					$lockfile = &main'lock();
					$c = 0;
					return 0;
				}
			}else{
				if( $c >= $m->{'each'} ){
					&main'rename_unlock( $lockfile );
					return 1;
				}
			}
			return 0;
		}elsif( $check eq 'reset' ){
			&main'rename_unlock( $lockfile );
			$c = 0;
		}elsif( $check eq 'sleep' ){
			&main'rename_unlock( $lockfile );
			select( undef, undef, undef, 0.10 );
			$lockfile = &main'lock();
		}else{
			$c++;
		}
	};
}

sub get_method
{
	my $path = $main'myroot . $main'data_dir . $main'methodtxt;
	open(MET, $path);
	my %METHOD;
	while( <MET> ) {
		chomp;
		my ( $name, $val ) = split(/\t/);
		$METHOD{$name} = $val;
	}
	close(MET);
	
	$METHOD{'each'}      = 100 if($METHOD{'each'} <= 0);
	$METHOD{'sleep'}     = 30 if($METHOD{'sleep'} <= 0);
	$METHOD{'partition'} = 50 if($METHOD{'partition'} <= 0);
	
	return \%METHOD;
}
1;
