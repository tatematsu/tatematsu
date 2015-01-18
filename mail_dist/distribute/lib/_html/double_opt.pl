
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
			&main'error("<strong>�f�B���N�g�����쐬�ł��܂���B","</strong><br><br><br>$dir<br><br>�̃p�[�~�b�V���������������ݒ肳��Ă��邩���m�F���������B");
		}
		chmod 0707, $path_dir;
		
	}
	
	if( !(-x $path_dir) || !(-w $path_dir) ){
		&main'error("<strong>�p�[�~�b�V�����G���[</strong>","<br><br><br>$path_dir �̃p�[�~�b�V������[707]�ɐݒ肳��Ă��邩���m�F���������B");
	}
	my $indexhtml = $path_dir .'index.html';
	open( IND, ">$indexhtml" );
	chmod 0606, $indexhtml;
	close(IND);
	
	&getList( 'in' ); # ������
	&getList( 'out' ); # ������
	
	return $path_dir;
}

sub pageIn
{
	my $line = shift;
	
	my $id = $line->[0] -0;
	my $on = $line->[87] ? ' checked="checked"': '';
	my $limit = $line->[88] || 10;
	#-----------------------------------------------------------------------
	# �\�[�X���擾
	#-----------------------------------------------------------------------
	my $source = &getSource( $id, 'opt-in', 0 );
	my $source_m  = &getSource( $id, 'opt-in', 1 );
	# �^�O��ϊ�
	$source  = &main'deltag( $source );
	$source_m  = &main'deltag( $source_m );
	#-----------------------------------------------------------------------
	# ���[���ݒ�
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
                                                        <td width="515"><strong>�_�u���I�v�g�C���@�\\</strong>���X�V���܂��B</td>
                                                      </tr>
                                                      <tr>
                                                        <td>���͌�A�u�X�V�𔽉f�v�{�^�����N���b�N���Ă��������B </td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">�y�_�u���I�v�g�C���Ƃ́z<br>
                                                                  <br>
                                                                  �_�u���I�v�g�C���@�\\�Ƃ́A���͂��ꂽ���[���A�h���X���Ăɓo�^�ӎv���m�F���郁�[���𑗐M���A�o�^�܂łɓ�d�̊m�F���s���V�X�e���ł��B<br>
�o�^�ӎv���m�F���郁�[���ɋL�ڂ��ꂽURL�ɃA�N�Z�X���邱�Ƃœo�^���������܂��̂ŁA���[���A�h���X�̓��̓~�X�⑼�l�̃��[���A�h���X�𗘗p�����Ȃ肷�܂��o�^��h�����߂ɁA�K�؂ȋ@�\\�ł��B</td>
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
                                                                    <td width="100" rowspan="2" bgcolor="#E5FDFF">�@�\\�ݒ�</td>
                                                                    <td bgcolor="#FFFFFF"><input name="opt-in" type="checkbox" id="opt-in" value="1"$on>
                                                                      �_�u���I�v�g�C���@�\\�𗘗p����</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�_�u���I�v�g�C���@�\\�����p�ł��܂��B<br>
�o�^�p�t�H�[������̓o�^���Ɉȉ��ݒ�̃��[���{���𑗐M���A���o�^�̊�����ʂ�\\�����܂��B</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" rowspan="2">�L������ </td>
                                                                    <td bgcolor="#FFFFFF"><input name="limit" type="text" id="limit" value="$limit" size="5">
                                                                      ��</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">���o�^�̗L��������ݒ肵�Ă��������B<br>
                                                                      �w�肵���������o�߂����ꍇ�A���o�^�̓L�����Z������܂��B</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="4" nowrap bgcolor="#E5FDFF">������ʐݒ�</td>
                                                                    <td bgcolor="#FFFFFF">��PC��p</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-in" target="_blank"><font color="#0000FF">&gt;&gt;�ۑ��ς݂̃v���r���[��\\��</font></a>
                                                                      <textarea name="source_p" cols="50" rows="20" wrap="off" id="source_p">
$source</textarea>
                                                                      <input name="default_p" type="submit" id="default_p" value="�@����������@"><br>
                                                                    <font color="#FF0000">���E�B���h�E�T�C�Y�ɂ���<br>
                                                                    ������ʂ̃E�B���h�E�T�C�Y�́A�u�o�^�p�t�H�[���v��HTML�\\�[�X�ɂ�茈�肳��܂��B</font></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">���g�ѐ�p</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-in&m=1" target="_blank"><font color="#0000FF">&gt;&gt;�ۑ��ς݂̃v���r���[��\\��</font></a>
                                                                      <textarea name="source_m" cols="50" rows="20" wrap="off" id="source_m">
$source_m</textarea>
                                                                      <input name="default_m" type="submit" id="default_m" value="�@����������@"></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" nowrap>���[���ݒ�</td>
                                                                    <td bgcolor="#FFFFFF">�薼�F
                                                                      <input name="btitle" type="text" id="subject" value="$subject" size="50">
                                                                      <br>
                                                                      <br>
                                                                      <font color="#FF0033">���ȈՃ^�O</font>
                                                                      <select name="select" onChange="this.form.convtag.value = this.value;">
                                                                        $main'opt_in_reflect_tag
                                                                      </select>
                                                                      &nbsp;
                                                                      <input type="text" style="background-color:#EEEEEE" name="convtag" size="15" onFocus="this.select();">
                                                                      <br>
                                                                      ��̃^�O�W���Q�l�ɁA�����E�{�����Ƀ^�O��ł�����ł��������B<br>
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
                                                          <input type="submit" value="�@�X�V�𔽉f�@"></td>
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
	# �\�[�X���擾
	#-----------------------------------------------------------------------
	my $source = &getSource( $id, 'opt-out', 0 );
	my $source_m  = &getSource( $id, 'opt-out', 1 );
	# �^�O��ϊ�
	$source  = &main'deltag( $source );
	$source_m  = &main'deltag( $source_m );
	#-----------------------------------------------------------------------
	# ���[���ݒ�
	#-----------------------------------------------------------------------
	my( $subject, $body  ) = &getMail( 'opt-out', $line->[7] );
	#-----------------------------------------------------------------------
	# �����N���b�N����
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
                                                        <td width="515"><strong>�_�u���I�v�g�A�E�g�@�\\</strong>���X�V���܂��B</td>
                                                      </tr>
                                                      <tr>
                                                        <td>���͌�A�u�X�V�𔽉f�v�{�^�����N���b�N���Ă��������B </td>
                                                      </tr>
                                                      <tr>
                                                        <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">�y�_�u���I�v�g�A�E�g�Ƃ́z<br>
                                                                  <br>
                                                                  �_�u���I�v�g�A�E�g�@�\\�Ƃ́A���͂��ꂽ���[���A�h���X���Ăɉ����ӎv���m�F���郁�[���𑗐M���A�����܂łɓ�d�̊m�F���s���V�X�e���ł��B<br>
�����ӎv���m�F���郁�[���ɋL�ڂ��ꂽURL�ɃA�N�Z�X���邱�Ƃŉ������������܂��̂ŁA���[���A�h���X�̓��̓~�X�⑼�l�̃��[���A�h���X�𗘗p�����Ȃ肷�܂�������h�����߂ɁA�K�؂ȋ@�\\�ł��B</td>
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
                                                                    <td width="100" rowspan="2" bgcolor="#E5FDFF">�@�\\�ݒ�</td>
                                                                    <td bgcolor="#FFFFFF"><input name="opt-out" type="checkbox" id="opt-out" value="1"$on>
                                                                      �_�u���I�v�g�A�E�g�@�\\�𗘗p����</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�_�u���I�v�g�A�E�g�@�\\�����p�ł��܂��B<br>
                                                                      �����p�t�H�[������̉������Ɉȉ��ݒ�̃��[���{���𑗐M���A�������̊�����ʂ�\\�����܂��B</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" rowspan="2">�L������ </td>
                                                                    <td bgcolor="#FFFFFF"><input name="limit" type="text" id="limit" value="$limit" size="5">
                                                                      ��</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">�������̗L��������ݒ肵�Ă��������B<br>
                                                                      �w�肵���������o�߂����ꍇ�A�������̓L�����Z������܂��B</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="4" nowrap bgcolor="#E5FDFF">������ʐݒ�</td>
                                                                    <td bgcolor="#FFFFFF">��PC��p</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-out" target="_blank"><font color="#0000FF">&gt;&gt;�ۑ��ς݂̃v���r���[��\\��</font></a>
                                                                      <textarea name="source_p" cols="50" rows="20" wrap="off" id="source_p">
$source</textarea>
                                                                    <input name="default_p" type="submit" id="default_p" value="�@����������@"><br>
                                                                    <font color="#FF0000">���E�B���h�E�T�C�Y�ɂ���<br>
                                                                    ������ʂ̃E�B���h�E�T�C�Y�́A�u�����p�t�H�[���v��HTML�\\�[�X�ɂ�茈�肳��܂��B</font></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">���g�ѐ�p</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF"><a href="$indexcgi?id=$id&md=ctm_regprev&type=opt-out&m=1" target="_blank"><font color="#0000FF">&gt;&gt;�ۑ��ς݂̃v���r���[��\\��</font></a>
                                                                      <textarea name="source_m" cols="50" rows="20" wrap="off" id="source_m">
$source_m</textarea>
                                                                    <input name="default_m" type="submit" id="default_m" value="�@����������@"></td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td rowspan="2" nowrap bgcolor="#E5FDFF">�����N���b�N����</td>
                                                                    <td bgcolor="#FFFFFF"><input name="oneclick" type="radio" value="0"$oneclick_p>
                                                                      PC��p��ʂ�\\���@
                                                                        <input name="oneclick" type="radio" value="1"$oneclick_m>
                                                                    �g�ѐ�p��ʂ�\\��</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#FFFFFF">�����N���b�N���������N���N���b�N�����ۂɕ\\�����銮����ʂ�ݒ肵�Ă��������B</td>
                                                                  </tr>
                                                                  <tr>
                                                                    <td bgcolor="#E5FDFF" nowrap>���[���ݒ�</td>
                                                                    <td bgcolor="#FFFFFF">�薼�F
                                                                      <input name="btitle" type="text" id="btitle" value="$subject" size="50">
                                                                      <br>
                                                                      <br>
                                                                      <font color="#FF0033">���ȈՃ^�O</font>
                                                                      <select name="select" onChange="this.form.convtag.value = this.value;">
                                                                        $main'opt_opt_reflect_tag
                                                                      </select>
                                                                      &nbsp;
                                                                      <input type="text" style="background-color:#EEEEEE" name="convtag" size="15" onFocus="this.select();">
                                                                      <br>
                                                                      ��̃^�O�W���Q�l�ɁA�����E�{�����Ƀ^�O��ł�����ł��������B<br>
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
                                                          <input type="submit" value="�@�X�V�𔽉f�@"></td>
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
				# ���łɉ��o�^�ς�
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
	
	return if( $main'mode ne 'cancel' ); # �����ȊO
	
	# �e���|�����[�t�@�C�����폜
	unlink $tmp;
	
	
	# �����N���b�N����
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
	
	# �z�M���O
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
		$main'param{'opt'} = 1; # �_�u���I�v�g�p�t���O
		$main'param{'reged'} = 1; # ���͊m�F��ʂ�\�����Ȃ�(����)
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
		$main'param{'opt'} = 1; # �_�u���I�v�g�p�t���O
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
	# HTML�\�[�X��ۑ�
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
	
	# ���[���ݒ�
	$main'param{'n'} = 'opt-in';
	&main'body();
	
	&main::make_plan_page( 'plan', 'opt-in' );
	exit;
}

sub renewOptout
{
	$main'param{'action'} = 'opt-out';
	&main'renew();
	# HTML�\�[�X��ۑ�
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
	
	# ���[���ݒ�
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
	
	# Jcode.pm��ǂݍ���ŕ����R�[�h�ϊ�(sjis��)
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
	$uid =~ s/[?|&|\.|\/]//gi; # �p�����[�^�Ɏg���镶������폜
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
<title>Web �y�[�W���݂���܂���</title>
<body>
�y�[�W���݂���܂���<hr><br>
�A�h���X�ɓ��͂̊ԈႢ������\\��������܂��B <br>
�����N���N���b�N�����ꍇ�ɂ́A�����N���Â��ꍇ������܂��B<br>
</body>
</html>
END
	exit;
}

1;
