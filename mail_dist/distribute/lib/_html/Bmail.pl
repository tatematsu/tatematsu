package Bmail;

$Bmail::bounce_subject = $main'myroot.$main'template. $main'subject_profile;
$Bmail::dir = &compatibility();

$ERR{'1'} = qq|POP3サーバーが見つからないため接続できませんでした。<br>POP3サーバー名をご確認ください。|;
$ERR{'2'} = qq|認証が拒否されたため接続できませんでした。<br>「アカウント名」「パスワード」をご確認ください。|;


sub compatibility
{
	my $dir = $main'myroot . $main'data_dir;
	my $path_dir = $dir . $main'bounce;
	
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
	
	return $path_dir;
}

sub menu
{
	my $id = shift;
	$id -= 0;
	my $menu = qq|<table border="0" align="center" cellpadding="0" cellspacing="10">
 <tr>
  <td align="center">[ <a href="$main'indexcgi?md=bmail&amp;act=account&amp;id=$id"><font color="#0000FF">アカウント設定</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=config&amp;id=$id"><font color="#0000FF">エラーメールを受信</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=result&amp;id=$id"><font color="#0000FF">エラーメール集計</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=log&amp;id=$id"><font color="#0000FF">削除済み一覧</font></a> ] </td>
 </tr>
</table>\n|;
	return $menu;
}

sub getLogpath
{
	my $line = shift;
	my $logfile = $Bmail::dir.'B-'.$line->[0].'.cgi';
	my $delfile = $Bmail::dir.'BD-'.$line->[0].'.cgi';
	
	my %log = ();
	$log{'l'} = $logfile;
	$log{'d'} = $delfile;
	return {%log};
}

sub getProfile
{
	my $o = shift;
	if( $o eq 'subject' ){
		open( FH, "<$Bmail::bounce_subject" );
		my @s = <FH>;
		close(FH);
		return [@s];
	}
}

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
		&check();
	}
	
	
	if( $action eq 'receive' ){
		# 自動設定を保存
		$line = &setAuto($line);
		my $result = "";
		if( defined $main'param{'set'} ){
			( $title, $main )= &config($line);
			return $title, $main;
		}else{
			# 検証Subjectを取得
			my $profile = &getProfile( 'subject' );
			my $result = &receive($line, $profile);
			( $title, $main ) = &result( $line,$result );
			return $title, $main;
		}
	}elsif( $action eq 'account' ){
		( $title, $main ) = &account($line);
		return $title, $main;
	}elsif( $action eq 'config' ){
		( $title, $main )= &config($line);
		return $title, $main;
	}elsif( $action eq 'result' ){
		( $title, $main )= &result( $line );
		return $title, $main;
	}elsif( $action eq 'log' ){
		( $title, $main )= &log( $line );
		return $title, $main;
	}elsif( $action eq 'renew' ){
		( $title, $main )= &renew();
		return $title, $main;
	}elsif( $action eq 'delete' ){
		( $title, $main )= &result_delete( $line );
		return $title, $main;
	}elsif( $action eq 'clear' ){
		( $title, $main )= &clear($line);
		return $title, $main;
	}
}

sub check
{
	
		&main'make_plan_page( 'plan', '', 'エラーが発生しました。<br><br>perlモジュールがインストールされていないため空メール機能は利用できません。<br><br>モジュール: Net/POP3.pm（perlモジュール）<br><br>詳しくは、サーバー管理者様にお問い合わせください。' );
		exit;
	
}

sub account
{
	my( $line ) = @_;
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = 'エラーメールアカウント設定';
	
	my $on = $line->[100] ? ' checked="checked"': '';
	my $pop3 = $line->[101];
	my $account = $line->[102];
	my $pass = $line->[103];
	my $email = $line->[104];
	
	
	
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td><strong>エラーメール専用のアカウント設定</strong>の更新を行います。</td>
                                                </tr>
                                                <tr>
                                                  <td>設定を更新する場合は、入力後「更新を反映」ボタンをクリックしてください。 </td>
                                                </tr>
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">【エラー(不達)メール解析機能\とは】<br>
                                                                  <br>
                                                                  エラー(不達)メール解析機能\とは、送信したメールが何らかの理由により配信されず、エラーとして返されてしまうメールを分類し解析する機能\です。<br>
                                                                  エラーとして返されるメールの送り先を指定のメールアカウントにすることで受信・解析処理を行います。<br>
                                                                  エラーとなるメールアドレスへの再送を防ぐことで、負荷の軽減や配信精度を高めるのに有効な機能\です。<br>
                                                                  エラー(不達)メール解析機能\のご利用には、必ず専用のメールアカウントが必要です。</td>
                                                              </tr>
                                                            </table></td>
                                                          </tr>
                                                        </table>
                                                    <br>
                                                    <table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#FF0000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><font color="#FF0000">【ご注意】</font>
                                                                <br>
                                                                本機能\をご利用の際、サーバースペックによりましては<br>
                                                                不要な情報が溜まり不具合が起こる可能\性がございます。<br>
                                                                本機能\を設定後に原因不明の不具合が生じた場合は、
                                                                こちらをご覧ください。<br>
                                                                <a href="#" onclick="window.open('http://www.raku-mail.com/manual/errmail.htm','','width=550, height=600, menubar=no, toolbar=no, scrollbars=no');return false;"><font color="#0000FF">エラーメール機能\不具合時の対処方法について</font></a></td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">■エラーメール設定</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">機能\設定</td>
                                                              <td bgcolor="#FFFFFF"><input name="on" type="checkbox" id="on" value="1"$on>
                                                                エラーメールを受信する</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">ここにチェックを入れると、指定のメールサーバーからエラーメールを受信し解析処理を行います。<br>
                                                                エラーメールは「エラーメールを受信する」ボタンによる手動受信か、もしくは<font color="#FF0000">「クーロン」「配信タグ」</font>の自動送信設定（※トップページ参照）の起動により受信処理が行われます。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">POP3サーバー名</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop" type="text" id="pop" size="30" value="$pop3"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">エラーメールを受信するメールサーバーを入力してください。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">メールアカウント </td>
                                                              <td bgcolor="#FFFFFF"><input name="account" type="text" id="account" size="30" value="$account"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">接続するサーバーのメールアカウント名を入力してください。<br>
                                                                <font color="#FF0000">※ほかに利用していない専用のアカウントをご指定ください。</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">パスワード</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass" type="password" id="pass" size="30" value="$pass"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">メールアカウントのパスワードを入力してください。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">メールアドレス</td>
                                                              <td bgcolor="#FFFFFF"><input name="addr" type="text" id="addr" size="30" value="$email"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">メールアカウントのメールアドレスを入力してください。<br>
                                                                ここで指定したメールアドレスは、送信の際-fオプションとしてsendmailコマンドで利用します。<font color="#FF0000">「送信方式設定」</font>で-fオプションを設定している場合は、エラーメール設定が優先されます。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="renew">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                    <input type="submit" name="Submit" value="　更新を反映　"></td>
                                                </tr>
                                                <tr>
                                                  <td><strong><br>
                                                    ○自動受信について<br>
                                                      <br>
                                                  </strong>受信設定が有効の場合、 <font color="#FF0000">「クーロン」「配信タグ」</font>の自動送信設定（※トップページ参照）の起動により自動的に受信処理が行われます。</td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub config
{
	my( $line ) = @_;
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = 'エラーメール手動受信';
	
	my $on = $line->[105] ? ' checked="checked"': '';
	my $k_err1 = ' checked="checked"'if $line->[106] eq 0;
	my $k_err2 = ' checked="checked"'if $line->[106] eq 1;
	my $err1 = $line->[107] || 3;
	my $err2 = $line->[108] || 5;
	
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td><strong>エラーメール</strong>を受信します。</td>
                                                </tr>
                                                <tr>
                                                  <td>自動で処理を行う場合は、各設定項目を入力後「エラーメールを受信する」ボタンをクリックしてください。 </td>
                                                </tr>
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr align="center">
                                                  <td><table width="450" border="0" cellpadding="0" cellspacing="1">
                                                    <tr>
                                                      <td bgcolor="#000000"><table width="100%" border="0" cellpadding="10" cellspacing="1">
                                                        <tr>
                                                          <td bgcolor="#FFFFFF"><p><font color="#FF0000"><strong>＜一時的なエラーとは＞</strong></font><br>
                                                            <br>
                                                            再度送信すれば届く可能\性があり、主に<br>
                                                            ・メールボックスが一杯など容量が不足している<br>
                                                            ・一時的に相手側のメールサーバーがダウンしている<br>
                                                            ・ドメイン指定や迷惑メール対策による拒否<br>
                                                            などが原因で発生するエラーです。</p>
                                                            <p><font color="#FF0000"><strong>＜恒久的なエラーとは＞</strong></font><br>
                                                              <br>
                                                              根本的な原因を解決しないと届く可能\性が極めて低く、主に<br>
                                                              ・指定のドメインが存在しない<br>
                                                              ・指定のドメインに存在しないメールアドレスである<br>
                                                              などが原因で発生するエラーです。<br>
                                                              <br>
                                                              <font color="#FF0000">※エラーメールの処理・内容は多岐にわたり、すべてのエラーメールを受信・解析できない場合があります。</font><br>
                                                            </p></td>
                                                        </tr>
                                                      </table></td>
                                                    </tr>
                                                  </table><br></td>
                                                </tr>
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■エラーメール受信設定</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">自動処理</td>
                                                              <td bgcolor="#FFFFFF"><input name="auto" type="checkbox" id="auto" value="1"$on>
                                                                自動でエラーが起きている登録者を削除する</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">ここにチェックを入れると、エラーメールを受信した際に、以下設定の基準で登録者を自動的に削除します。<br>この設定は<font color="#FF0000">「クーロン」「配信タグ」</font>の起動による受信処理時にも適応されます。</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="3" bgcolor="#E5FDFF">エラー回数</td>
                                                              <td bgcolor="#FFFFFF"><input name="err" type="radio" value="0"$k_err1>
                                                                恒久的なエラー
                                                                <input name="err1" type="text" id="err1" size="5" value="$err1">
                                                              回以上</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><input name="err" type="radio" value="1"$k_err2>
                                                                一時的なエラー
                                                                <input name="err2" type="text" id="err2" size="5" value="$err2">
                                                              回以上</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">エラー回数を指定してください。<br>
                                                              指定した回数のエラーメールを受信した登録者が自動処理の対象となります。</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                
                                                <tr align="center">
                                                  <td>
                                                    <input type="submit" name="Submit" value="　エラーメールを受信する　" onClick="return confir('エラーメールを受信します。よろしいですか?');"></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><br>▼設定の変更のみを行う場合はこちらをクリックしてください<br>
                                                    <input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="receive">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                    <input type="submit" name="set" value="　更新を反映する　" onClick="return confir('設定の更新のみ行います。よろしいですか?');"></td>
                                                </tr>
                                                <tr align="center">
                                                  <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                  <td><strong><br>
                                                    ○エラーのカウントについて</strong><br>
                                                    <br>
                                                      エラーメール受信によるカウント数は、１日に最大で１カウントです。<br>
                                                    同日に同メールアドレスのエラーメールを受信した場合はカウントされません。
                                                    <br>
                                                    <br>
                                                    <strong>○自動クリーニング機能\について</strong><br>
                                                      <br>
                                                      自動処理設定は<font color="#FF0000">「クーロン」「配信タグ」</font>の起動による受信処理時にも適応されます。<br>
                                                    <br>
                                                    <strong>○プランが停止状態の場合</strong><br>
                                                      <br>
                                                  手動・自動の起動ともに、「稼動・停止」状態に関係なく受信処理を行います。</td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub result
{
	my( $line, $hash ) = @_;
	
	my $k_err1 = ' checked="checked"' if( $line->[106] eq 0 );
	my $k_err2 = ' checked="checked"' if( $line->[106] eq 1 );
	my $err1 = $line->[107] || 3;
	my $err2 = $line->[108] || 5;
	
	# 受信情報
	my $result = "";
	if( $hash ne "" ){
		$result = <<"END";
                                                 <tr>
                                                  <td>以下のエラーメールを受信しました。<br>
                                                    <table width="300" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■エラーメール</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">受信数</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">恒久的なエラー</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'err1'} 件</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">一時的なエラー</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'err2'} 件</td>
                                                            </tr>
                                                            
                                                            
                                                          </table></td>
                                                      </tr>
                                                  </table>
                                                  <br></td>
                                                </tr>
END
	}
	
	
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = 'エラーメール集計';
	my $list = &getList($line);
	my $total = @$list;
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td>受信した<strong>エラーメールの集計結果</strong>を表\示します。</td>
                                                </tr>
                                                <tr>
                                                  <td>登録者を削除する場合は、エラー回数を入力後「登録者を削除する」ボタンをクリックしてください。 </td>
                                                </tr>
                                                
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
$result
                                                <tr>
                                                  <td><strong>エラーが起きている登録者</strong>一覧　[ TOTAL $total\件 ]
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td width="200" bgcolor="#99CCFF">メールアドレス</td>
                                                              <td bgcolor="#99CCFF">恒久的なエラー回数</td>
                                                              <td bgcolor="#99CCFF">一時的なエラー回数</td>
                                                            </tr>
END
	foreach my $l ( @$list ){
		
		$main .= <<"END";
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">$l->[0]</td>
                                                              <td align="right" bgcolor="#FFFFFF">$l->[1]</td>
                                                              <td align="right" bgcolor="#FFFFFF">$l->[2]</td>
                                                            </tr>
END
	}
	if( !$total ){
		$main .= <<"END";
                                                            <tr>
                                                              <td bgcolor="#FFFFFF" colspan="3" align="center">登録されていません</td>
                                                            </tr>
END
	}
	$main .= <<"END";
                                                          </table></td>
                                                      </tr>
                                                    </table></td></tr>
                                                
                                                <tr align="center">
                                                  <td>&nbsp;</td>
                                                </tr>
                                                <tr align="center">
                                                  <td><table border="1" cellpadding="5" cellspacing="0" bordercolor="#ACA899">
                                   <tr>
                                     <td bgcolor="#EFEDDE"><input name="err" type="radio" value="0"$k_err1>
                                       恒久的なエラー
                                                        <input name="err1" type="text" id="err1" value="$err1" size="3">
回以上<br>
<input name="err" type="radio" value="1"$k_err2>
一時的なエラー
                                                        <input name="err2" type="text" id="err2" value="$err2" size="3">
回以上の
<input type="submit" name="Submit" value="　登録者を削除する　" onClick="return confir('登録者を削除します。よろしいですか?');"></td></tr>
                                 </table>
                                                    <input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="delete">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                  </td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub log
{
	my( $line ) = @_;
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = 'エラーメール削除者履歴';
	my $log = &getLogpath( $line );
	open( R, "<$log->{'d'}" );
	my @d = <R>;
	close(R);
	my $total = @d;
	my $list = join("",@d);
	
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td>エラーメール受信により削除した<strong>登録者一覧</strong>を表\示します。</td>
                                                </tr>
                                                <tr>
                                                  <td>保存情報を削除する場合は、入力後「全てをクリアする」ボタンをクリックしてください。 </td>
                                                </tr>
                                                
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr>
                                                  <td><strong>削除した登録者のメールアドレス</strong>一覧　[ TOTAL $total\件 ]</td>
                                                </tr>
                                                
                                                <tr>
                                                  <td><textarea name="textarea" cols="50" rows="10">
$list</textarea></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input type="submit" name="Submit" value="全てをクリアする" onClick="return confir('本当に削除しますか?');">
                                                  <input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="clear">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                  </td>
                                                </tr>
                                              </table></td>
                                            <td width="21">&nbsp;</td>
                                          </tr>
                                        </table>
                                      </form>
END
	return $title, $main;
}

sub result_delete
{
	my( $line ) = @_;
	
	my $error_type = $main'param{'err'};
	my $error_n = $error_type ? $main'param{'err2'}: $main'param{'err1'};
	
	if( $error_type eq ''|| $error_n <= 0 ){
		&main'make_plan_page('plan','','削除するエラー条件を指定してください。');
		exit;
	}
	
	my $total = &delete($line, {'e'=>$error_type,'n'=>$error_n});
	my @e = (
		'恒久的なエラー ',
		'一時的なエラー '
	);
	my $error_target = $e[$opts->{'e'}]. $error_n. '回以上';
	
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = 'エラーメール手動受信';
	my $main = <<"END";
<form name="form1" method="post" action="$main'index.cgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table border="0" cellspacing="1" cellpadding="3">
                                                
                                                <tr>
                                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                      <td width="455">&nbsp;</td>
                                                    </tr>
                                                  </table></td>
                                                </tr>
                                                
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr>
                                                  <td><br>
                                                    登録者の削除が完了しました。<br>
                                                    <br>
                                                    <table width="300" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">■登録者削除結果</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">条件</td>
                                                              <td bgcolor="#FFFFFF">$error_target</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">登録者削除数</td>
                                                              <td bgcolor="#FFFFFF">$total 件</td>
                                                            </tr>
                                                            
                                                            
                                                          </table></td>
                                                      </tr>
                                                  </table>
                                                  <br></td>
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

sub errRef
{
	my( $t, $pop ) = @_;
	
	if( $pop != 1 && $pop != 2 ){
		$pop->quit();
		return;
	}
	
	my $host = 'エラーメールアカウント設定';
	
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

sub renew
{
	
	my $table = "";
	if( $main'param{'on'} ){
		# 接続テスト
		my $ref = &connect({ 'h'=>$main'param{'pop'},'u'=>$main'param{'account'},'p'=>$main'param{'pass'} });
		$table .= &errRef( 0, $ref );
		if( $table eq '' && $main'param{'addr'} eq "" ){
			$table .= '<br>メールアドレスを指定してください。';
		}
	}
	
	if( $table ne "" ){
		&main'make_plan_page( 'plan','',$table );
		exit;
	}
	
	$main'param{'action'} = 'bmail';
	&main'renew();
	$main'param{'act'} = 'account';
	&main'make_plan_page( 'plan', 'bmail' );
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


sub receive
{
	my( $line, $profile ) = @_;
	
	my %hash = ();
	$hash{'sum'} = '受信設定されていません';
	$hash{'err1'} = 0;
	$hash{'err2'} = 0;
	
	if( $line->[100] ){
		
		my %opts;
		$opts{'h'} = $line->[101];
		$opts{'u'} = $line->[102];
		$opts{'p'} = $line->[103];
		my $pop = &connect( {%opts} );
		if( $pop == 1 || $pop == 2 ){
			$result{'sum'} = qq|<font color="#FF0000">$ERR{$pop}</font>|;
		}else{
			
			# 保存済みE-mailを取得
			my $target = &getMem( $line );
			
			my $ref_mailindex = $pop->list();
			my @mailindex = sort {$a<=>$b } keys %$ref_mailindex;
			$hash{'sum'} = @mailindex . ' 通';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # 受信メールヘッダを取得
				
				# 検査
				foreach my $s ( @$profile ){
					chomp($s);
					if( index( $heads->{'Subject'}, $s ) >= 0 ){
						
						my $m = &Weblogic::Pop3'parse($pop->get($id));
						my( $result ) = &Weblogic::Pop3'bounce( $m );
						
						if( $result && index($target,"<>$result->{'addr'}<>")>=0 ){
							if( &regist($line,$result) ){
								if( $result->{'status'} =~ /^\s*5/ ){
									$hash{'err1'}++;
								}else{
									$hash{'err2'}++;
								}
							}
						}
					}
				}
				$pop->delete($id);
			}
			$pop->quit();
		}
		# 自動削除
		&auto($line);
	}
	
	return {%hash};
}

sub regist
{
	my( $line, $result ) = @_;
	my $date = &main'make_date3( time );
	
	my $f = 0;
	my $r = 0;
	my $i = $result->{'status'} =~ /^\s*5/ ? 2:3;
	
	my $log = &getLogpath( $line );
	my $tmp = $Bmail::dir. 'TMP-'. time. $$. '.cgi';
	open( TMP, ">$tmp" );
	open( BOUNCE, "<$log->{'l'}" );
	while(<BOUNCE>){
		chomp;
		my $addr = ( split(/\t/) )[0];
		if( $addr eq $result->{'addr'} ){
			$f = 1;
			my @data = split(/\t/);
			if( $data[1] ne $date ){
				$r = 1;
				$data[$i]++;
				$data[1] = $date;
				$data[4] .= qq|<>$result->{'reason'}|;
				$_ = join( "\t", @data );
			}
		}
		print TMP $_. "\n";
	}
	if( !$f ){
		$r = 1;
		my $e1 = $i == 2 ? 1: 0;
		my $e2 = $i == 3 ? 1: 0;
		print TMP qq|$result->{'addr'}\t$date\t$e1\t$e2\t$result->{'reason'}\n|;
	}
	close(TMP);
	close(BOUNCE);
	rename $tmp, $log->{'l'};
	chmod 0606, $log->{'l'};
	return $r;
}

sub delete
{
	my( $line,$opts ) = @_;
	
	return if( $line->[0] <= 0 );
	
	my @add = (); # 削除アドレス
	my $log = &getLogpath( $line );
	my $tmp = $Bmail::dir. 'TMP-'. time. $$. '.cgi';
	open( TMP, ">$tmp" );
	open( BOUNCE, "<$log->{'l'}" );
	while(<BOUNCE>){
		chomp;
		my ($addr,$e1,$e2 ) = ( split(/\t/) )[0,2,3];
		if( $opts->{'e'} == 0 && $opts->{'n'} <= $e1 ){
			push @add, $addr;
			next;
		}elsif( $opts->{'e'} == 1 && $opts->{'n'} <= $e2 ){
			push @add, $addr;
			next;
		}
		print TMP $_. "\n";
	}
	close(TMP);
	close(BOUNCE);
	rename $tmp, $log->{'l'};
	chmod 0606, $log->{'l'};
	
	my $total = 0;
	if( @add ){
		# 履歴に追加
		open( R, ">>$log->{'d'}" );
		foreach my $a ( @add ){
			print R $a, "\n";
		}
		close(R);
		chmod 0606, $log->{'d'};
		$total = &delete_user( $line, [@add] );
	}
	return $total;
}

sub reset
{
	my( $line, $addr ) = @_;
	my $target = '<>'. join("<>",@$addr) . '<>';
	
	my $log = &getLogpath( $line );
	my $tmp = $Bmail::dir. 'TMP-'. time. $$. '.cgi';
	open( BTMP, ">$tmp" );
	chmod 0606, $tmp;
	
	open( BOUNCE, "<$log->{'l'}" );
	while( my $l = <BOUNCE>){
		chomp;
		my ($addr ) = ( split(/\t/,$l) )[0];
		if( index( $target,"<>$addr<>" ) >= 0 ){
			next;
		}
		print BTMP $l. "\n";
	}
	close(BTMP);
	close(BOUNCE);
	rename $tmp, $log->{'l'};
	
}

sub resetAll
{
	my( $line, $target ) = @_;
	
	my $log = &getLogpath( $line );
	my $tmp = $Bmail::dir. 'TMP-'. time. $$. '.cgi';
	open( BTMP, ">$tmp" );
	chmod 0606, $tmp;
	
	open( BOUNCE, "<$log->{'l'}" );
	while( my $l = <BOUNCE>){
		chomp( $l );
		my ($addr ) = ( split(/\t/,$l) )[0];
		if( $target->{$addr} <= 0 ){
			next;
		}
		print BTMP $l. "\n";
	}
	close(BTMP);
	close(BOUNCE);
	rename $tmp, $log->{'l'};
	
}

sub delete_user
{
	my( $line,  $list ) = @_;
	my $target = '<>'. join( "<>", @$list ) .'<>';
	my $csvdir = $main'myroot.$main'data_dir.$main'csv_dir;
	my $userlist = $csvdir.$line->[6];
	my $tmp = $csvdir.'tmp_'. time. $$. '.cgi';
	
	my $n = 0;
	open( UT, ">$tmp" );
	chmod 0606,$tmp;
	
	open( MEM, "<$userlist" );
	while(<MEM>){
		chomp;
		my $addr = ( split(/\t/) )[5];
		if( index($target,"<>$addr<>") >= 0 ){
			$n++;
			next;
		}
		print UT $_,"\n";
	}
	close(UT);
	close(MEM);
	rename $tmp,$userlist;
	return $n;
}

sub clear
{
	my $line = shift;
	my $log = &getLogpath($line);
	unlink $log->{'d'};
	
	&log($line);
}

sub clean
{
	my $line = shift;
	my $log = &getLogpath($line);
	
	unlink $log->{'d'};
	unlink $log->{'l'};
}

sub getList
{
	my $line = shift;
	# 保存済みE-mailを取得
	my $target = &getMem( $line );
	my $log = &getLogpath( $line );
	my @lilst = ();
	open( FILE, "<$log->{'l'}" );
	while(<FILE>){
		chomp;
		my @d = ( split(/\t/) )[0,2,3];
		if( index($target,"<>$d[0]<>") >= 0 ){
			push @list, [@d];
		}
	}
	close(FILE);
	return [@list]
}

sub getMem
{
	my $line = shift;
	# 保存済みE-mailを取得
	my $csvpath = $main'myroot.$main'data_dir.$main'csv_dir.$line->[6];
	my $target = "";
	open( MEM, "<$csvpath" );
	while(<MEM>){
		chomp;
		my( $email ) = ( split(/\t/) )[5];
		$target .= "<>$email";
	}
	close(MEM);
	$target .= '<>';
	return $target;
}

sub setAuto
{
	my $line = shift;
	
	if( $main'param{'auto'} ){
		my $error_type = $main'param{'err'};
		my $error_n = $error_type ? $main'param{'err2'}: $main'param{'err1'};
		if( $error_type ne "" && $error_n <= 0 ){
			&main'make_plan_page('plan','','エラー回数を指定してください');
			exit;
		}
	}
	
	$main'param{'action'} = 'bmail2';
	&main'renew();
	
	$line->[105] = $main'param{'auto'};
	$line->[106] = $main'param{'err'};
	$line->[107] = $main'param{'err1'};
	$line->[108] = $main'param{'err2'};
	
	return $line;
}

sub auto
{
	my $line = shift;
	
	# 自動削除
	if( $line->[105] ){
		my $error_type = $line->[106];
		my $error_n = $error_type ? $line->[108]: $line->[107];
		if( $error_type ne "" && $error_n > 0 ){
			my $total = &delete($line, {'e'=>$error_type,'n'=>$error_n});
		}
	}
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
		
		# 検証Subjectを取得
		my $profile = &getProfile( 'subject' );
		
		my $plan = $main'myroot. $main'data_dir. $main'log_dir. $main'plan_txt;
		open( PLAN, "<$plan" );
		while(<PLAN>){
			chomp;
			my @line = split(/\t/);
			if( $line[100] ){
				$main'fullpath = &main'lock();
				&receive([@line],$profile);
				&main'rename_unlock( $main'fullpath );
				# 一時停止
				select( undef, undef, undef, 0.10 );
			}
		}
		close(PLAN);
	}
}

1;
