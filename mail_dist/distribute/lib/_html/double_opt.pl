
package DoubleOpt;

$mail_pl = 'opt_mail.pl';
$optdir = &compatibility();


sub compatibility
{
	my $dir = $main'myroot . $main'data_dir;
	my $path_dir = $dir . $main'double_opt;
	
	unless( -d $path_dir ){
		my $flag = mkdir $path_dir, 0707;
		if( !$flag ){
			&main'error("<strong>ディレクトリが作成できません。","</strong><br><br><br>$dir<br><br>のパーミッションがただしく設定されているかご確認ください。");
		}
		chmod 0707, $path_dir;
		
	}
	
	if( !(-x $path_dir) || !(-w $path_dir) ){
		&main'error("<strong>パーミッションエラー</strong>","<br><br><br>$path_dir のパーミッションが[707]に設定されているかご確認ください。");
	}
	my $indexhtml = $path_dir .'index.html';
	open( IND, ">$indexhtml" );
	chmod 0606, $indexhtml;
	close(IND);
	
	&getList( 'in' ); # 初期化
	&getList( 'out' ); # 初期化
	
	return $path_dir;
}

sub pageIn
{
	my $line = shift;
	
	my $id = $line->[0] -0;
	my $on = $line->[87] ? ' checked="checked"': '';
	my $limit = $line->[88] || 10;
	#-----------------------------------------------------------------------
	# ソースを取得
	#-----------------------------------------------------------------------
	my $source = &getSource( $id, 'opt-in', 0 );
	my $source_m  = &getSource( $id, 'opt-in', 1 );
	# タグを変換
	$source  = &main'deltag( $source );
	$source_m  = &main'deltag( $source_m );
	#-----------------------------------------------------------------------
	# メール設定
	#-----------------------------------------------------------------------
	my( $subject, $body  ) = &getMail( 'opt-in', $line->[7] );
	
	my $main = <<"END";
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td width="20">&nbsp;</td>
                                          <td width="499"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td width="523"><form action="$main'indexcgi" method="post" name="form1">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                                      <tr>
                                                        <td width="515"><strong>ダブルオプトイン機能\</strong>を更新します。</td>
                                                      </tr>
                                                      <tr>
                                                        <td>入力後、「更新を反映」ボタンをクリックしてください。 </td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">【ダブルオプトインとは】<br>
                                                                  <br>
                                                                  ダブルオプトイン機能\とは、入力されたメールアドレス宛てに登録意思を確認するメールを送信し、登録までに二重の確認を行うシステムです。<br>
登録意思を確認するメールに記載されたURLにアクセスすることで登録が完了しますので、メールアドレスの入力ミスや他人のメールアドレスを利用したなりすまし登録を防ぐために、適切な機能\です。</td>
                                                              </tr>
                                                            </table></td>
                                                          </tr>
                                                        </table>
                                                        <br></td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                              <td></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                                  <tr>
                                                                    <td width="100" rowspan="2" bgcolor="#E5FDFF">機能\設定</td>
                                                                    <td bgcolor="#FFFFFF"><input name="opt-in" type="checkbox" id="opt-in" value="1"$on>
                                                                      ダブルオプトイン機能\を利用する</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">ここにチェックを入れると、ダブルオプトイン機能\が利用できます。<br>
登録用フォームからの登録時に以下設定のメール本文を送信し、仮登録の完了画面を表\示します。</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" rowspan="2">有効期限 </td>
                                                                    <td bgcolor="#FFFFFF"><input name="limit" type="text" id="limit" value="$limit" size="5">
                                                                      日</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">仮登録の有効期限を設定してください。<br>
                                                                      指定した日数を経過した場合、仮登録はキャンセルされます。</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="4" nowrap bgcolor="#E5FDFF">完了画面設定</td>
                                                                    <td bgcolor="#FFFFFF">▽PC専用</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-in" target="_blank"><font color="#0000FF">&gt;&gt;保存済みのプレビューを表\示</font></a>
                                                                      <textarea name="source_p" cols="50" rows="20" wrap="off" id="source_p">
$source</textarea>
                                                                      <input name="default_p" type="submit" id="default_p" value="　初期化する　"><br>
                                                                    <font color="#FF0000">※ウィンドウサイズについて<br>
                                                                    完了画面のウィンドウサイズは、「登録用フォーム」のHTMLソ\ースにより決定されます。</font></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">▽携帯専用</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-in&m=1" target="_blank"><font color="#0000FF">&gt;&gt;保存済みのプレビューを表\示</font></a>
                                                                      <textarea name="source_m" cols="50" rows="20" wrap="off" id="source_m">
$source_m</textarea>
                                                                      <input name="default_m" type="submit" id="default_m" value="　初期化する　"></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" nowrap>メール設定</td>
                                                                    <td bgcolor="#FFFFFF">題名：
                                                                      <input name="btitle" type="text" id="subject" value="$subject" size="50">
                                                                      <br>
                                                                      <br>
                                                                      <font color="#FF0033">※簡易タグ</font>
                                                                      <select name="select" onChange="this.form.convtag.value = this.value;">
                                                                        $main'opt_in_reflect_tag
                                                                      </select>
                                                                      &nbsp;
                                                                      <input type="text" style="background-color:#EEEEEE" name="convtag" size="15" onFocus="this.select();">
                                                                      <br>
                                                                      上のタグ集を参考に、件名・本文中にタグを打ち込んでください。<br>
                                                                      <br>
                                                                      <textarea name="body" cols="50" rows="20" wrap="off" id="body">
$body</textarea></td>
                                                                  </tr>
                                                                </table></td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                      <tr>
                                                        <td align="center"><input name="id" type="hidden" id="id" value="$id">
                                                          <input name="md" type="hidden" id="md" value="renew_opt">
                                                          <input name="act" type="hidden" id="act" value="opt-in">
                                                          <input type="submit" value="　更新を反映　"></td>
                                                      </tr>
                                                    </table>
                                                  </form></td>
                                              </tr>
                                            </table></td>
                                        </tr>
                                      </table>
END
	return $main;
}

sub pageOut
{
	my $line = shift;
	
	my $id = $line->[0] -0;
	my $on = $line->[89] ? ' checked="checked"': '';
	my $limit = $line->[90] || 10;
	#-----------------------------------------------------------------------
	# ソースを取得
	#-----------------------------------------------------------------------
	my $source = &getSource( $id, 'opt-out', 0 );
	my $source_m  = &getSource( $id, 'opt-out', 1 );
	# タグを変換
	$source  = &main'deltag( $source );
	$source_m  = &main'deltag( $source_m );
	#-----------------------------------------------------------------------
	# メール設定
	#-----------------------------------------------------------------------
	my( $subject, $body  ) = &getMail( 'opt-out', $line->[7] );
	#-----------------------------------------------------------------------
	# ワンクリック解除
	#-----------------------------------------------------------------------
	my $oneclick_p = $line->[91]? '': ' checked="checked"';
	my $oneclick_m = $line->[91]? ' checked="checked"': '';
	
	my $main = <<"END";
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td width="20">&nbsp;</td>
                                          <td width="499"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                              <tr>
                                                <td width="523"><form action="$main'indexcgi" method="post" name="form1">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                                      <tr>
                                                        <td width="515"><strong>ダブルオプトアウト機能\</strong>を更新します。</td>
                                                      </tr>
                                                      <tr>
                                                        <td>入力後、「更新を反映」ボタンをクリックしてください。 </td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">【ダブルオプトアウトとは】<br>
                                                                  <br>
                                                                  ダブルオプトアウト機能\とは、入力されたメールアドレス宛てに解除意思を確認するメールを送信し、解除までに二重の確認を行うシステムです。<br>
解除意思を確認するメールに記載されたURLにアクセスすることで解除が完了しますので、メールアドレスの入力ミスや他人のメールアドレスを利用したなりすまし解除を防ぐために、適切な機能\です。</td>
                                                              </tr>
                                                            </table></td>
                                                          </tr>
                                                        </table>
                                                        <br></td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                              <td></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                                  <tr>
                                                                    <td width="100" rowspan="2" bgcolor="#E5FDFF">機能\設定</td>
                                                                    <td bgcolor="#FFFFFF"><input name="opt-out" type="checkbox" id="opt-out" value="1"$on>
                                                                      ダブルオプトアウト機能\を利用する</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">ここにチェックを入れると、ダブルオプトアウト機能\が利用できます。<br>
                                                                      解除用フォームからの解除時に以下設定のメール本文を送信し、仮解除の完了画面を表\示します。</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" rowspan="2">有効期限 </td>
                                                                    <td bgcolor="#FFFFFF"><input name="limit" type="text" id="limit" value="$limit" size="5">
                                                                      日</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">仮解除の有効期限を設定してください。<br>
                                                                      指定した日数を経過した場合、仮解除はキャンセルされます。</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="4" nowrap bgcolor="#E5FDFF">完了画面設定</td>
                                                                    <td bgcolor="#FFFFFF">▽PC専用</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-out" target="_blank"><font color="#0000FF">&gt;&gt;保存済みのプレビューを表\示</font></a>
                                                                      <textarea name="source_p" cols="50" rows="20" wrap="off" id="source_p">
$source</textarea>
                                                                    <input name="default_p" type="submit" id="default_p" value="　初期化する　"><br>
                                                                    <font color="#FF0000">※ウィンドウサイズについて<br>
                                                                    完了画面のウィンドウサイズは、「解除用フォーム」のHTMLソ\ースにより決定されます。</font></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">▽携帯専用</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-out&m=1" target="_blank"><font color="#0000FF">&gt;&gt;保存済みのプレビューを表\示</font></a>
                                                                      <textarea name="source_m" cols="50" rows="20" wrap="off" id="source_m">
$source_m</textarea>
                                                                    <input name="default_m" type="submit" id="default_m" value="　初期化する　"></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="2" nowrap bgcolor="#E5FDFF">ワンクリック解除</td>
                                                                    <td bgcolor="#FFFFFF"><input name="oneclick" type="radio" value="0"$oneclick_p>
                                                                      PC専用画面を表\示　
                                                                        <input name="oneclick" type="radio" value="1"$oneclick_m>
                                                                    携帯専用画面を表\示</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">ワンクリック解除リンクをクリックした際に表\示する完了画面を設定してください。</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" nowrap>メール設定</td>
                                                                    <td bgcolor="#FFFFFF">題名：
                                                                      <input name="btitle" type="text" id="btitle" value="$subject" size="50">
                                                                      <br>
                                                                      <br>
                                                                      <font color="#FF0033">※簡易タグ</font>
                                                                      <select name="select" onChange="this.form.convtag.value = this.value;">
                                                                        $main'opt_opt_reflect_tag
                                                                      </select>
                                                                      &nbsp;
                                                                      <input type="text" style="background-color:#EEEEEE" name="convtag" size="15" onFocus="this.select();">
                                                                      <br>
                                                                      上のタグ集を参考に、件名・本文中にタグを打ち込んでください。<br>
                                                                      <br>
                                                                      <textarea name="body" cols="50" rows="20" wrap="off" id="body">
$body</textarea></td>
                                                                  </tr>
                                                                </table></td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                      <tr>
                                                        <td align="center"><input name="id" type="hidden" id="id" value="$id">
                                                          <input name="act" type="hidden" id="act" value="opt-out">
                                                          <input name="md" type="hidden" id="md" value="renew_opt">
                                                          <input type="submit" value="　更新を反映　"></td>
                                                      </tr>
                                                    </table>
                                                  </form></td>
                                              </tr>
                                            </table></td>
                                        </tr>
                                      </table>
END
	return $main;
}

sub renew
{
	my $action = $main'param{'act'};
	&renewOptin() if( $action eq 'opt-in' );
	&renewOptout() if( $action eq 'opt-out' );
}

sub getList
{
	my( $o, $id, $addr ) = @_;
	opendir DIR, $optdir;
	my @f = readdir DIR;
	close(DIR);
	
	my $now = time;
	my %r = ();
	$o = $o eq 'out' ? 'OPTOUT-': 'OPTIN-';
	foreach( @f ){
		if( /^$o/ ){
			my $path = $optdir. $_;
			my $p = &getPro( $path );
			
			if( $p->{'date'}+($p->{'limit'}*60*60*24) < $now ){
				unlink $path;
				next;
			}
			
			if( $id && $addr && $id eq $p->{'id'} && $addr eq $p->{'addr'} ){
				# すでに仮登録済み
				$r{'repeat'} = 1;
				last;
			}
			$r{$_} = $path;
		}
	}
	return {%r};
}

sub getPro
{
	my( $path ) = @_;
	my %h = ();
	open( OPT, "<$path" );
	my $id = <OPT>;
	my $mail = <OPT>;
	my $mobile = <OPT>;
	my $date = <OPT>;
	my $limit = <OPT>;
	my $data = <OPT>;
	close(OPT);
	
	chomp($id);
	chomp($mail);
	chomp($mobile);
	chomp($data);
	
	$h{'id'} = $id;
	$h{'addr'} = $mail;
	$h{'mobile'} = $mobile;
	$h{'date'} = $date -0;
	$h{'limit'} = $limit -0;
	$h{'data'} = $data;
	
	return {%h};
}

sub in
{
	my( $line, $user ) = @_;
	
	if( $main'param{'opt'} || !$line->[87] ){
		return;
	}
	
	my $thanks = sub {
		&main'print_error('', '', '', 'opt-in');
		exit;
	};
	
	my $id = $line->[0];
	my $email = $user->[5];
	my $mobile = &main'cMobile();
	my $now = time;
	my $userData = join( "\t", @$user );
	
	my $p = &getList( 'in', $id, $email );
	if( $p->{'repeat'} ){
		&$thanks;
		exit;
	}
	
	my( $uniq, $logfile );
	my $c = 1;
	MKID:
	$uniq = &makeUid($c);
	$logfile = $optdir . 'OPTIN-'. $uniq. '.cgi';
	if( -e $logfile ){
		$now++;
		goto MKID;
	}
	
	open( OPT, ">$logfile" );
	print OPT qq|$id\n|;
	print OPT qq|$email\n|;
	print OPT qq|$mobile\n|;
	print OPT qq|$now\n|;
	print OPT qq|$line->[88]\n|;
	print OPT qq|$userData\n|;
	close(OPT);
	chmod 0606, $logfile;
	
	&send( $line, $user, $uniq, $email, 'opt-in' );
	&$thanks;
}

sub out
{
	my( $line, $user, $tmp ) = @_;
	
	if( $main'param{'opt'} || !$line->[89] ){
		return;
	}
	
	return if( $main'mode ne 'cancel' ); # 解除以外
	
	# テンポラリーファイルを削除
	unlink $tmp;
	
	
	# ワンクリック解除
	unless($ENV{'REQUEST_METHOD'} eq 'POST'){
		$main'param{'mbl'} = 1 if( $line->[91] );
	}
	
	my $thanks = sub {
		&main'print_error('', '', '', 'opt-out');
		exit;
	};
	
	my $id = $line->[0];
	my $email = $user->[5];
	my $mobile = &main'cMobile();
	my $now = time;
	my $userData = join( "\t", @$user );
	
	my $p = &getList( 'out', $id, $email );
	if( $p->{'repeat'} ){
		&$thanks;
		exit;
	}
	
	my( $uniq, $logfile );
	my $c = 1;
	MKID:
	$uniq = &makeUid($c);
	$logfile = $optdir . 'OPTOUT-'. $uniq. '.cgi';
	if( -e $logfile ){
		$now++;
		goto MKID;
	}
	
	open( OPT, ">$logfile" );
	print OPT qq|$id\n|;
	print OPT qq|$email\n|;
	print OPT qq|$mobile\n|;
	print OPT qq|$now\n|;
	print OPT qq|$line->[90]\n|;
	print OPT qq|$userData\n|;
	close(OPT);
	chmod 0606, $logfile;
	
	&send( $line, $user, $uniq, $email, 'opt-out' );
	&$thanks;
}

sub send
{
	my( $line, $csv, $u, $m, $o ) = @_;
	
	my $apply = &Pub'ssl($line->[83], $line->[84]);
	my $name = $o eq 'opt-in' ? '?oi=': '?oo=';
	my $url = $apply . $name. $u;
	
	my( $subject, $body ) = &getMail($o,$line->[7]);
	$body =~ s/\<%$o%\>/$url/i;
	$subject = &main'include( $csv, $subject );
	$body = &main'include( $csv, $body, $jis );
	#&main'error($body);
	$senderror = &main'send( $line->[4], $line->[3], $m, $subject, $body,"","",$line );
	
	# 配信ログ
	my $logpath = $main'myroot.$main'data_dir.$main'log_dir.$line->[8];
	my $now = time;
	open(LOG, ">>$logpath");
	print LOG "-\t$m\t$csv->[3]\t$now\t\t$subject\n";
	close(LOG);
	
}

sub regist
{
	my $uniq = &main'delspace( $main'param{'oi'} );
	my $oi = &getList('in');
	my $key = 'OPTIN-'. $uniq . '.cgi';
	if( -e $oi->{$key} ){
		$main'param{'opt'} = 1; # ダブルオプト用フラグ
		$main'param{'reged'} = 1; # 入力確認画面を表示しない(強制)
		my $p = &getPro( $oi->{$key} );
		&restore($p);
		&main'reguest();
		exit;
	}
	
	&simple_error();
}

sub cancel
{
	my $uniq = &main'delspace( $main'param{'oo'} );
	my $oi = &getList('out');
	my $key = 'OPTOUT-'. $uniq . '.cgi';
	if( -e $oi->{$key} ){
		$main'param{'opt'} = 1; # ダブルオプト用フラグ
		$main'mode = 'cancel';
		my $p = &getPro( $oi->{$key} );
		&restore($p,1);
		&main'renewguest();
		exit;
	}
	
	&simple_error();
}

sub restore
{
	my( $p, $out ) = @_;
	
	$main'param{'id'} = $p->{'id'};
	$main'param{'mbl'} = 1 if( $p->{'mobile'} );
	
	my @u = split( /\t/,$p->{'data'} );
	my %f = &Ctm'regulation_csvline();
	foreach( keys %f ){
		$main'param{$_} = $u[$f{$_}];
		$main'param{$_} =~ s/<br>/\n/gi;
		$main'param{$_} = &main'_deltag( $main'param{$_} );
	}
	if( $out ){
		$main'param{'userid'} = $u[0];
	}
}

sub clean
{
	if( $main'param{'oi'} ne '' ){
		my $uniq = &main'delspace( $main'param{'oi'} );
		my $oi = &getList('in');
		my $key = 'OPTIN-'. $uniq . '.cgi';
		if( -e $oi->{$key} ){
			unlink $oi->{$key};
		}
	}
	if( $main'param{'oo'} ne '' ){
		my $uniq = &main'delspace( $main'param{'oo'} );
		my $oi = &getList('out');
		my $key = 'OPTOUT-'. $uniq . '.cgi';
		if( -e $oi->{$key} ){
			unlink $oi->{$key};
		}
	}
}

sub delete
{
	my( $id ) = @_;
	
	opendir DIR, $optdir;
	my @f = readdir DIR;
	close(DIR);
	
	foreach( @f ){
		if( /^OPT/ ){
			my $path = $optdir. $_;
			my $p = &getPro( $path );
			if( $id == $p->{'id'} ){
				unlink $path;
			}
		}
	}
}

sub renewOptin
{
	$main'param{'action'} = 'opt-in';
	&main'renew();
	# HTMLソースを保存
	delete $main'param{'renew'} if( defined $main'param{'renew'} );
	delete $main'param{'default'} if( defined $main'param{'default'} );
	$main'param{'type'} = 'opt-in';
	$main'param{'m'} = 0;
	$main'param{'source'} = $main'param{'source_p'};
	if( $main'param{'default_p'} ){
		$main'param{'default'} = 1;
	}else{
		$main'param{'renew'} = 1;
	}
	&Ctm'renew();
	delete $main'param{'renew'} if( defined $main'param{'renew'} );
	delete $main'param{'default'} if( defined $main'param{'default'} );
	$main'param{'m'} = 1;
	$main'param{'source'} = $main'param{'source_m'};
	if( $main'param{'default_m'} ){
		$main'param{'default'} = 1;
	}else{
		$main'param{'renew'} = 1;
	}
	&Ctm'renew();
	
	# メール設定
	$main'param{'n'} = 'opt-in';
	&main'body();
	
	&main::make_plan_page( 'plan', 'opt-in' );
	exit;
}

sub renewOptout
{
	$main'param{'action'} = 'opt-out';
	&main'renew();
	# HTMLソースを保存
	delete $main'param{'renew'} if( defined $main'param{'renew'} );
	delete $main'param{'default'} if( defined $main'param{'default'} );
	$main'param{'type'} = 'opt-out';
	$main'param{'m'} = 0;
	$main'param{'source'} = $main'param{'source_p'};
	if( $main'param{'default_p'} ){
		$main'param{'default'} = 1;
	}else{
		$main'param{'renew'} = 1;
	}
	&Ctm'renew();
	delete $main'param{'renew'} if( defined $main'param{'renew'} );
	delete $main'param{'default'} if( defined $main'param{'default'} );
	$main'param{'m'} = 1;
	$main'param{'source'} = $main'param{'source_m'};
	if( $main'param{'default_m'} ){
		$main'param{'default'} = 1;
	}else{
		$main'param{'renew'} = 1;
	}
	&Ctm'renew();
	
	# メール設定
	$main'param{'n'} = 'opt-out';
	&main'body();
	
	&main::make_plan_page( 'plan', 'opt-out' );
	exit;
}

sub getSource
{
	my( $id, $o, $m ) = @_;
	local $array_source = &Ctm'find( $id, $o, 0, $m );
	local $source = join( "", @$array_source );
	
	# Jcode.pmを読み込んで文字コード変換(sjisへ)
	&Ctm'lib_inc();
	my $code = $Ctm'jcodegetcode->($source);
	$Ctm'jcodeconvert->(\$source, 'sjis', $code );
	
	return $source;
}

sub getMail
{
	my( $o, $path ) = @_;
	
	my $MDL = ($o eq 'opt-in')? 'OPT::IN': 'OPT::OUT';
	my $queuepath = "$main'myroot$main'data_dir$main'queue_dir$path";
	my $rh_body = &main'get_body( $queuepath );
	my $subject = $rh_body->{$o}->{'subject'};
	my $message  = $rh_body->{$o}->{'body'};
	
	my $default_dir = $main'myroot . $main'template;
	my $req = $default_dir .$mail_pl;
	if( -e $req ){
		eval{  require $req; };
		if( $subject eq "" ){
			my $h = $MDL. '::subject';
			$subject = $$h;
		}
		if( $message eq "" ){
			my $h = $MDL. '::body';
			$message = $$h;
		}
	}
	return $subject, $message;
}

sub makeUid
{
	my( $salt ) = @_;
	my $uid = crypt( $salt, &make_salt() );
	$uid =~ s/[?|&|\.|\/]//gi; # パラメータに使われる文字列を削除
	return $uid;
}

sub make_salt {
    srand (time + $$);
    return pack ('CC', int (rand(26) + 65), int (rand(10) +48));
}

sub simple_error
{
	print <<"END";
Content-type: text/html

<html>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<title>Web ページがみつかりません</title>
<body>
ページがみつかりません<hr><br>
アドレスに入力の間違いがある可能\性があります。 <br>
リンクをクリックした場合には、リンクが古い場合があります。<br>
</body>
</html>
END
	exit;
}

1;
