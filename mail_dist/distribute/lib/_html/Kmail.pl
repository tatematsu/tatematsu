package Kmail;

$POP3 = 1;

$ERR{'1'} = qq|POP3�T�[�o�[��������Ȃ����ߐڑ��ł��܂���ł����B<br>POP3�T�[�o�[�������m�F���������B|;
$ERR{'2'} = qq|�F�؂����ۂ��ꂽ���ߐڑ��ł��܂���ł����B<br>�u�A�J�E���g���v�u�p�X���[�h�v�����m�F���������B|;

sub main
{
	my $line = shift;
	my $action = $main'param{'act'};
	my( $title, $main );
	
	# ���[����M
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
		&main'make_plan_page( 'plan', '', '�G���[���������܂����B<br><br>perl���W���[�����C���X�g�[������Ă��Ȃ����ߋ󃁁[���@�\�͗��p�ł��܂���B<br><br>���W���[��: Net/POP3.pm�iperl���W���[���j<br><br>�ڂ����́A�T�[�o�[�Ǘ��җl�ɂ��₢���킹���������B' );
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
	my $title = '�󃁁[���ݒ�';
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td><strong>�󃁁[���ݒ�</strong>�̍X�V�����<strong>��M</strong>���s���܂��B</td>
                                                </tr>
                                                <tr>
                                                  <td>�ݒ���X�V����ꍇ�́A���͌�u�X�V�𔽉f�v�{�^�����N���b�N���Ă��������B </td>
                                                </tr>
                                                <tr>
                                                  <td>�󃁁[���̎蓮��M���s���ꍇ�́u�󃁁[������M����v�{�^�����N���b�N���Ă��������B</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�y�󃁁[���@�\\�Ƃ́z<br>
                                                                <br>
                                                                �󃁁[���@�\\�Ƃ́A������{���ɉ������͂��Ȃ����[�����w��̃��[���A�h���X���Ă֑����Ă��炢�w�Ǔo�^���s���V�X�e���ł��B <br>
                                                                �o�^���郁�[���A�h���X�̓��͂��s���K�v���Ȃ����߁A��Ԃ̌y���␳�m�ȃ��[���A�h���X���擾���邱�Ƃ��\\�ł��B<br>
                                                                �󃁁[���@�\\�̂����p�ɂ́A�K����p�̃��[���A�J�E���g���K�v�ł��B</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table>
                                                    <br>
                                                    <table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#FF0000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><font color="#FF0000">�y�����Ӂz<br>
                                                                <br>
                                                                </font>�E�󃁁[���@�\\�ɂ����ẮA����I�ɋ󃁁[���̎�M�󋵂��`�F�b�N����<br>
                                                                �K�v�����邽�߁A�b�q�n�m�̐ݒ�𐄏��������܂��B<br>
                                                                <a href="http://www.raku-mail.com/manual/cron.htm" target="_blank"><font color="#0000FF">�i�b�q�n�m�̉���E�ݒ���@�j</font></a><br>
                                                                <br>
                                                                �E�b�q�n�m�̍ŏ����s�Ԋu�̓����^���T�[�o�[���ɐ������قȂ邽��<br>
                                                                �󃁁[���@�\\�ɂĂb�q�n�m�����p�����ꍇ�́A�\\�ߊm�F�����肢�������܂��B<br>
                                                                <br>
                                                                �E�ቿ�i�т̃T�[�o�[�̏ꍇ�A�b�q�n�m�̍ŏ����s�Ԋu�͂P���Ԓ��x�̂��̂������悤�ł��B��L�̃T�[�o�[�̏ꍇ�A�b�q�n�m��ݒ肵���ꍇ�ɂ����܂��Ă��A�o�^�҂��󃁁[���𑗐M���Ă���y���[������̎����ԐM���͂��܂ōő�Ŗ�P���Ԃ̃u�����N�������܂��B��L�̃u�����N���ɗ͂Ȃ��������ꍇ�́A�b�q�n�m�̍ŏ����s�Ԋu�̒Z���T�[�o�������p���������K�v���������܂��B</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table>
                                                    <br></td>
                                                </tr>
                                                <tr>
                                                  <td><table border="0" align="center" cellpadding="0" cellspacing="10">
                                                      <tr>
                                                        <td align="center"><input type="submit" name="receive" value="�@�󃁁[������M����@"></td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���󃁁[���o�^�ݒ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">�@�\\�ݒ�</td>
                                                              <td bgcolor="#FFFFFF"><input name="on1" type="checkbox" id="on1" value="1"$on1>
                                                                �󃁁[������M����</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�w��̃��[���T�[�o�[����󃁁[������M���o�^�������s���܂��B<br>
                                                                �󃁁[���́u�󃁁[������M����v�{�^���ɂ��蓮��M���A��������<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̎������M�ݒ�i���g�b�v�y�[�W�Q�Ɓj�̋N���ɂ���M�������s���܂��B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">POP3�T�[�o�[��</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop1" type="text" id="pop1" size="30" value="$pop1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�󃁁[������M���郁�[���T�[�o�[����͂��Ă��������B</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">���[���A�J�E���g </td>
                                                              <td bgcolor="#FFFFFF"><input name="account1" type="text" id="account1" size="30" value="$account1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�ڑ�����T�[�o�[�̃��[���A�J�E���g������͂��Ă��������B<br>
                                                                <font color="#FF0000">���ق��ɗ��p���Ă��Ȃ���p�̃A�J�E���g�����w�肭�������B</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">�p�X���[�h</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass1" type="password" id="pass1" size="30" value="$pass1"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">���[���A�J�E���g�̃p�X���[�h����͂��Ă��������B</td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���󃁁[�������ݒ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">�@�\\�ݒ�</td>
                                                              <td bgcolor="#FFFFFF"><input name="on2" type="checkbox" id="on2" value="1"$on2>
                                                                �󃁁[������M����</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�w��̃��[���T�[�o�[����󃁁[������M�������������s���܂��B<br>
�󃁁[���́u�󃁁[������M����v�{�^���ɂ��蓮��M���A��������<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̎������M�ݒ�i���g�b�v�y�[�W�Q�Ɓj�̋N���ɂ���M�������s���܂��B</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">POP3�T�[�o�[��</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop2" type="text" id="pop2" size="30" value="$pop2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�󃁁[������M���郁�[���T�[�o�[����͂��Ă��������B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">���[���A�J�E���g </td>
                                                              <td bgcolor="#FFFFFF"><input name="account2" type="text" id="account2" size="30" value="$account2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�ڑ�����T�[�o�[�̃��[���A�J�E���g������͂��Ă��������B<br>
                                                                <font color="#FF0000">���ق��ɗ��p���Ă��Ȃ���p�̃A�J�E���g�����w�肭�������B</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">�p�X���[�h</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass2" type="password" id="pass2" size="30" value="$pass2"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">���[���A�J�E���g�̃p�X���[�h����͂��Ă��������B</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="renew">
                                                    <input name="md" type="hidden" id="md" value="kmail">
                                                    <input type="submit" name="Submit" value="�@�X�V�𔽉f�@"></td>
                                                </tr>
                                                <tr>
                                                  <td><font color="#FF0000"><br>
                                                    </font><strong>���u�󃁁[���v��M�̍ۂɑ����郁�[�����̐ݒ�ɂ���</strong><br>
                                                    <br>
                                                    �u�z�M�����E�{���v�̃y�[�W�ɂĐݒ肵�������E���[�����ɂĔz�M���s���܂��B<br>
�Ȃ��A�u�󃁁[���v�͎d�l��A�o�^�̍ۂɂ����O���̍��ڏ���<br>
�擾���鎖���ł��܂���̂ŁA�{���̍쐬�̍ۂɂ͂����ӂ��������B<br>
<br>
<strong>��������M�ɂ���<br>
<br>
</strong>��M�ݒ肪�L���̏ꍇ�A<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̎������M�ݒ�i���g�b�v�y�[�W�Q�Ɓj�̋N���ɂ��
�����I�Ɏ�M�������s���܂��B<strong><br>
<br>
���v��������~��Ԃ̏ꍇ�ɂ���<br>
<br>
</strong>�蓮��M�̏ꍇ�́u�ғ��E��~�v�Ɋ֌W�Ȃ���M���܂��B<br>
������M�̏ꍇ�́u�ғ����v�̏ꍇ�̂ݎ�M���܂��B<br>
�Ȃ��A�u�z�M���ԑсv�̐ݒ�ɂ͉e�����󂯂܂���B</td>
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
		# �ڑ��e�X�g
		my $ref = &connect({ 'h'=>$main'param{'pop1'},'u'=>$main'param{'account1'},'p'=>$main'param{'pass1'} });
		$table .= &errRef( 0, $ref );
	}
	if( $main'param{'on2'} ){
		my $ref2 = &connect({ 'h'=>$main'param{'pop2'},'u'=>$main'param{'account2'},'p'=>$main'param{'pass2'} });
		# �ڑ��e�X�g
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
	
	# �z�X�g
	my $host = $opts->{'h'};
	# �A�J�E���g
	my $user = $opts->{'u'};
	# �p�X���[�h
	my $pass = $opts->{'p'};
	
	# �ڑ�
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
	
	my $host = $t ? '�󃁁[�������ݒ�': '�󃁁[���o�^�ݒ�';
	
	my $table = <<"END";
<table>
<tr>
<td align="left" colspan="2">
<font color="#FF0000">POP3�T�[�o�[�ɐڑ��ł��܂���ł����B($host)</font>
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
	my $title = '�󃁁[����M';
	
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
		&main'make_plan_page( 'plan', '', '�w��̃v������������܂���' );
	}
	
	my $counter = &counter(1);
	my( $result1, $result2, $f ) = &receive( $line, $counter );
	$counter->('reset');
	
	my $rest = $f ? '<strong><font color="#FF0000">�w��̑��M���𒴂������߁A��M�����𒆒f���܂����B<br>������x��M�������s���Ă��������B</font></strong><br><br>': '';
	
	my $main = <<"END";
<form name="form1" method="post" action="">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table width="100%" border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td>�ȉ��̋󃁁[������M���܂����B</td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���󃁁[���o�^</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">��M��</td>
                                                              <td bgcolor="#FFFFFF">$result1->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">�o�^��</td>
                                                              <td bgcolor="#FFFFFF">$result1->{'regist'}��</td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���󃁁[������</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">��M��</td>
                                                              <td bgcolor="#FFFFFF">$result2->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">������</td>
                                                              <td bgcolor="#FFFFFF">$result2->{'delete'}��</td>
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
	
	$result1{'sum'} = '��M�ݒ肳��Ă��܂���';
	$result2{'sum'} = '��M�ݒ肳��Ă��܂���';
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
			$result1{'sum'} = @mailindex . '��';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # ��M���[���w�b�_���擾
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
			$result2{'sum'} = @mailindex . ' ��';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # ��M���[���w�b�_���擾
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
	
	# �G���[���O
	unless( &main'chk_email($from) ){
		#&print_errlog( "�A�h���X���o���s(getAddr) -> $_" );
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
	my $ra_conf = $line->[77] -0; # �Ǘ��Ғʒm��p�{�����p�t���O
	my $tag_data = $line->[82];
	&Pub'ssl($line->[83], $line->[84]);
	
	#---------------------------#
	# ��t����
	#---------------------------#
	if ( $line->[38] ) {
		foreach ( (split(/,/, $line->[38])) ) {
			if ( index($addr, $_) >= 0 ) {
				return;
			}
		}
	}
	
	#--------------------------------#
	# �����̓o�^�҃f�[�^����ID���擾 #
	#--------------------------------#
	my $index;
	unless ( open(CSV, "$csvpath" ) ) {
		return;
	}else {
		while( <CSV> ) {
			chomp;
			my ( $id, $mail ) = ( split(/\t/) )[0, 5];
			if ( !$line->[42] && $mail eq $addr ) {
				# ����̃��[���A�h���X���o�^����Ă��܂��B
				close(CSV);
				return 0;
			}
			$index = $id if( $index < $id );
		}
	}
	close(CSV);
	$index++;
	
	
	#---------------------------#
	# �]���p�^�O�擾            #
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
		# �ꎞ��~
		$par[52] = 1;
	}
	
	#--------------------------------#
	# �ǉ�                           #
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
	# ���M                           #
	#--------------------------------#
	my $senderror;
	if ( !$sk || $line->[40] ) {
		# �o�^���[���̑��M
		my $rh_body = &main'get_body( $queuepath );
		$line->[9] =~ s/<br>/\n/gi;
		$line->[10] =~ s/<br>/\n/gi;
		$line->[11] =~ s/<br>/\n/gi;
		
		local ( $subject, $message ) = &main'make_send_body( 0, $rh_body, $line->[9], $line->[10], $line->[11] );
		# �]���^�O�ϊ�
		my $unic = $id. '-0';
		my $forward_urls;
		($message, $forward_urls) = &Click'analyTag($par[0], $message, $urlTag, $unic, $forward);
		
		my $jis = ($main'CONTENT_TYPE eq 'text/html')? 1: 0;
        $subject = &main'include( \@par, $subject );
		$message = &main'include( \@par, $message, $jis );
		if ( !$sk ) {
			$senderror = &main'send( $line->[4], $line->[3], $par[5], $subject, $message,"","",$line );
			$counter->();
			
			# �z�M���O�ɒǉ�
			unless ( $senderror ) {
				open(LOG, ">>$logpath");
				print LOG "$par[0]\t$par[5]\t$par[3]\t$date\t0\t$subject\n";
				close(LOG);
			}
			# �A�N�Z�X�W�v�p�f�[�^����
			&Click'setForward_t( $forward_urls, $unic );
		}
		# �Ǘ��҈��֑��M
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
	my $a_conf = $line->[85] -0; # �Ǘ��Ғʒm��p�{�����p�t���O
	my $now = time;
	
	&Pub'ssl($line->[83], $line->[84]);
	
	
	#--------------------------------#
	# �폜                           #
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
				# ����̃��[���A�h���X���`�F�b�N
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
	# ���M                           #
	#--------------------------------#
	my $senderror;
	my $sendck = ( split(/,/, $line->[35]) )[3];
	if( !$sendck || $a_conf ){
        # �������[���̑��M
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
        	# �z�M���O�ɒǉ�
        	my $now = time;
        	unless ( $senderror ) {
        	    open(LOG, ">>$logpath");
        	    print LOG "$par[0]\t$par[5]\t$par[3]\t$now\tc\t$subject\n";
        	    close(LOG);
        	}
		}
		# �Ǘ��҈��֑��M(�������[��)
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
		
		# ���[����M
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
					# Cron�I��
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
