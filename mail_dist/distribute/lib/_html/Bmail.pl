package Bmail;

$Bmail::bounce_subject = $main'myroot.$main'template. $main'subject_profile;
$Bmail::dir = &compatibility();

$ERR{'1'} = qq|POP3�T�[�o�[��������Ȃ����ߐڑ��ł��܂���ł����B<br>POP3�T�[�o�[�������m�F���������B|;
$ERR{'2'} = qq|�F�؂����ۂ��ꂽ���ߐڑ��ł��܂���ł����B<br>�u�A�J�E���g���v�u�p�X���[�h�v�����m�F���������B|;


sub compatibility
{
	my $dir = $main'myroot . $main'data_dir;
	my $path_dir = $dir . $main'bounce;
	
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
	
	return $path_dir;
}

sub menu
{
	my $id = shift;
	$id -= 0;
	my $menu = qq|<table border="0" align="center" cellpadding="0" cellspacing="10">
 <tr>
  <td align="center">[ <a href="$main'indexcgi?md=bmail&amp;act=account&amp;id=$id"><font color="#0000FF">�A�J�E���g�ݒ�</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=config&amp;id=$id"><font color="#0000FF">�G���[���[������M</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=result&amp;id=$id"><font color="#0000FF">�G���[���[���W�v</font></a> ] [ <a href="$main'indexcgi?md=bmail&amp;act=log&amp;id=$id"><font color="#0000FF">�폜�ς݈ꗗ</font></a> ] </td>
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
	
	# ���[����M
	local $root = $main'myroot;
	my $libpop3 = "${'root'}lib/netpop3_pl.cgi";
	eval{ require $libpop3; };
	if( $@ ){
		&check();
	}
	
	
	if( $action eq 'receive' ){
		# �����ݒ��ۑ�
		$line = &setAuto($line);
		my $result = "";
		if( defined $main'param{'set'} ){
			( $title, $main )= &config($line);
			return $title, $main;
		}else{
			# ����Subject���擾
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
	
		&main'make_plan_page( 'plan', '', '�G���[���������܂����B<br><br>perl���W���[�����C���X�g�[������Ă��Ȃ����ߋ󃁁[���@�\�͗��p�ł��܂���B<br><br>���W���[��: Net/POP3.pm�iperl���W���[���j<br><br>�ڂ����́A�T�[�o�[�Ǘ��җl�ɂ��₢���킹���������B' );
		exit;
	
}

sub account
{
	my( $line ) = @_;
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = '�G���[���[���A�J�E���g�ݒ�';
	
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
                                                  <td><strong>�G���[���[����p�̃A�J�E���g�ݒ�</strong>�̍X�V���s���܂��B</td>
                                                </tr>
                                                <tr>
                                                  <td>�ݒ���X�V����ꍇ�́A���͌�u�X�V�𔽉f�v�{�^�����N���b�N���Ă��������B </td>
                                                </tr>
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr>
                                                  <td><table width="450" border="0" align="center" cellpadding="1">
                                                          <tr>
                                                            <td bgcolor="#000000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                              <tr>
                                                                <td bgcolor="#FFFFFF">�y�G���[(�s�B)���[����͋@�\\�Ƃ́z<br>
                                                                  <br>
                                                                  �G���[(�s�B)���[����͋@�\\�Ƃ́A���M�������[�������炩�̗��R�ɂ��z�M���ꂸ�A�G���[�Ƃ��ĕԂ���Ă��܂����[���𕪗ނ���͂���@�\\�ł��B<br>
                                                                  �G���[�Ƃ��ĕԂ���郁�[���̑������w��̃��[���A�J�E���g�ɂ��邱�ƂŎ�M�E��͏������s���܂��B<br>
                                                                  �G���[�ƂȂ郁�[���A�h���X�ւ̍đ���h�����ƂŁA���ׂ̌y����z�M���x�����߂�̂ɗL���ȋ@�\\�ł��B<br>
                                                                  �G���[(�s�B)���[����͋@�\\�̂����p�ɂ́A�K����p�̃��[���A�J�E���g���K�v�ł��B</td>
                                                              </tr>
                                                            </table></td>
                                                          </tr>
                                                        </table>
                                                    <br>
                                                    <table width="450" border="0" align="center" cellpadding="1">
                                                      <tr>
                                                        <td bgcolor="#FF0000"><table width="450" border="0" cellpadding="10" cellspacing="0">
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><font color="#FF0000">�y�����Ӂz</font>
                                                                <br>
                                                                �{�@�\\�������p�̍ہA�T�[�o�[�X�y�b�N�ɂ��܂��Ă�<br>
                                                                �s�v�ȏ�񂪗��܂�s����N����\\�����������܂��B<br>
                                                                �{�@�\\��ݒ��Ɍ����s���̕s����������ꍇ�́A
                                                                ��������������������B<br>
                                                                <a href="#" onclick="window.open('http://www.raku-mail.com/manual/errmail.htm','','width=550, height=600, menubar=no, toolbar=no, scrollbars=no');return false;"><font color="#0000FF">�G���[���[���@�\\�s����̑Ώ����@�ɂ���</font></a></td>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���G���[���[���ݒ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">�@�\\�ݒ�</td>
                                                              <td bgcolor="#FFFFFF"><input name="on" type="checkbox" id="on" value="1"$on>
                                                                �G���[���[������M����</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�w��̃��[���T�[�o�[����G���[���[������M����͏������s���܂��B<br>
                                                                �G���[���[���́u�G���[���[������M����v�{�^���ɂ��蓮��M���A��������<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̎������M�ݒ�i���g�b�v�y�[�W�Q�Ɓj�̋N���ɂ���M�������s���܂��B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">POP3�T�[�o�[��</td>
                                                              <td bgcolor="#FFFFFF"><input name="pop" type="text" id="pop" size="30" value="$pop3"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�G���[���[������M���郁�[���T�[�o�[����͂��Ă��������B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">���[���A�J�E���g </td>
                                                              <td bgcolor="#FFFFFF"><input name="account" type="text" id="account" size="30" value="$account"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�ڑ�����T�[�o�[�̃��[���A�J�E���g������͂��Ă��������B<br>
                                                                <font color="#FF0000">���ق��ɗ��p���Ă��Ȃ���p�̃A�J�E���g�����w�肭�������B</font></td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">�p�X���[�h</td>
                                                              <td bgcolor="#FFFFFF"><input name="pass" type="password" id="pass" size="30" value="$pass"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">���[���A�J�E���g�̃p�X���[�h����͂��Ă��������B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="2" bgcolor="#E5FDFF">���[���A�h���X</td>
                                                              <td bgcolor="#FFFFFF"><input name="addr" type="text" id="addr" size="30" value="$email"></td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">���[���A�J�E���g�̃��[���A�h���X����͂��Ă��������B<br>
                                                                �����Ŏw�肵�����[���A�h���X�́A���M�̍�-f�I�v�V�����Ƃ���sendmail�R�}���h�ŗ��p���܂��B<font color="#FF0000">�u���M�����ݒ�v</font>��-f�I�v�V������ݒ肵�Ă���ꍇ�́A�G���[���[���ݒ肪�D�悳��܂��B</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="renew">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                    <input type="submit" name="Submit" value="�@�X�V�𔽉f�@"></td>
                                                </tr>
                                                <tr>
                                                  <td><strong><br>
                                                    ��������M�ɂ���<br>
                                                      <br>
                                                  </strong>��M�ݒ肪�L���̏ꍇ�A <font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̎������M�ݒ�i���g�b�v�y�[�W�Q�Ɓj�̋N���ɂ�莩���I�Ɏ�M�������s���܂��B</td>
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
	my $title = '�G���[���[���蓮��M';
	
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
                                                  <td><strong>�G���[���[��</strong>����M���܂��B</td>
                                                </tr>
                                                <tr>
                                                  <td>�����ŏ������s���ꍇ�́A�e�ݒ荀�ڂ���͌�u�G���[���[������M����v�{�^�����N���b�N���Ă��������B </td>
                                                </tr>
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr align="center">
                                                  <td><table width="450" border="0" cellpadding="0" cellspacing="1">
                                                    <tr>
                                                      <td bgcolor="#000000"><table width="100%" border="0" cellpadding="10" cellspacing="1">
                                                        <tr>
                                                          <td bgcolor="#FFFFFF"><p><font color="#FF0000"><strong>���ꎞ�I�ȃG���[�Ƃ́�</strong></font><br>
                                                            <br>
                                                            �ēx���M����Γ͂��\\��������A���<br>
                                                            �E���[���{�b�N�X����t�ȂǗe�ʂ��s�����Ă���<br>
                                                            �E�ꎞ�I�ɑ��葤�̃��[���T�[�o�[���_�E�����Ă���<br>
                                                            �E�h���C���w�����f���[���΍�ɂ�鋑��<br>
                                                            �Ȃǂ������Ŕ�������G���[�ł��B</p>
                                                            <p><font color="#FF0000"><strong>���P�v�I�ȃG���[�Ƃ́�</strong></font><br>
                                                              <br>
                                                              ���{�I�Ȍ������������Ȃ��Ɠ͂��\\�����ɂ߂ĒႭ�A���<br>
                                                              �E�w��̃h���C�������݂��Ȃ�<br>
                                                              �E�w��̃h���C���ɑ��݂��Ȃ����[���A�h���X�ł���<br>
                                                              �Ȃǂ������Ŕ�������G���[�ł��B<br>
                                                              <br>
                                                              <font color="#FF0000">���G���[���[���̏����E���e�͑���ɂ킽��A���ׂẴG���[���[������M�E��͂ł��Ȃ��ꍇ������܂��B</font><br>
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
                                                              <td colspan="2" bgcolor="#E5FDFF">���G���[���[����M�ݒ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td width="100" rowspan="2" bgcolor="#E5FDFF">��������</td>
                                                              <td bgcolor="#FFFFFF"><input name="auto" type="checkbox" id="auto" value="1"$on>
                                                                �����ŃG���[���N���Ă���o�^�҂��폜����</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�����Ƀ`�F�b�N������ƁA�G���[���[������M�����ۂɁA�ȉ��ݒ�̊�œo�^�҂������I�ɍ폜���܂��B<br>���̐ݒ��<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̋N���ɂ���M�������ɂ��K������܂��B</td>
                                                            </tr>
                                                            <tr>
                                                              <td rowspan="3" bgcolor="#E5FDFF">�G���[��</td>
                                                              <td bgcolor="#FFFFFF"><input name="err" type="radio" value="0"$k_err1>
                                                                �P�v�I�ȃG���[
                                                                <input name="err1" type="text" id="err1" size="5" value="$err1">
                                                              ��ȏ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF"><input name="err" type="radio" value="1"$k_err2>
                                                                �ꎞ�I�ȃG���[
                                                                <input name="err2" type="text" id="err2" size="5" value="$err2">
                                                              ��ȏ�</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#FFFFFF">�G���[�񐔂��w�肵�Ă��������B<br>
                                                              �w�肵���񐔂̃G���[���[������M�����o�^�҂����������̑ΏۂƂȂ�܂��B</td>
                                                            </tr>
                                                          </table></td>
                                                      </tr>
                                                    </table></td>
                                                </tr>
                                                
                                                <tr align="center">
                                                  <td>
                                                    <input type="submit" name="Submit" value="�@�G���[���[������M����@" onClick="return confir('�G���[���[������M���܂��B��낵���ł���?');"></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><br>���ݒ�̕ύX�݂̂��s���ꍇ�͂�������N���b�N���Ă�������<br>
                                                    <input name="id" type="hidden" id="id" value="$id">
                                                    <input name="act" type="hidden" id="act" value="receive">
                                                    <input name="md" type="hidden" id="md" value="bmail">
                                                    <input type="submit" name="set" value="�@�X�V�𔽉f����@" onClick="return confir('�ݒ�̍X�V�̂ݍs���܂��B��낵���ł���?');"></td>
                                                </tr>
                                                <tr align="center">
                                                  <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                  <td><strong><br>
                                                    ���G���[�̃J�E���g�ɂ���</strong><br>
                                                    <br>
                                                      �G���[���[����M�ɂ��J�E���g���́A�P���ɍő�łP�J�E���g�ł��B<br>
                                                    �����ɓ����[���A�h���X�̃G���[���[������M�����ꍇ�̓J�E���g����܂���B
                                                    <br>
                                                    <br>
                                                    <strong>�������N���[�j���O�@�\\�ɂ���</strong><br>
                                                      <br>
                                                      ���������ݒ��<font color="#FF0000">�u�N�[�����v�u�z�M�^�O�v</font>�̋N���ɂ���M�������ɂ��K������܂��B<br>
                                                    <br>
                                                    <strong>���v��������~��Ԃ̏ꍇ</strong><br>
                                                      <br>
                                                  �蓮�E�����̋N���Ƃ��ɁA�u�ғ��E��~�v��ԂɊ֌W�Ȃ���M�������s���܂��B</td>
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
	
	# ��M���
	my $result = "";
	if( $hash ne "" ){
		$result = <<"END";
                                                 <tr>
                                                  <td>�ȉ��̃G���[���[������M���܂����B<br>
                                                    <table width="300" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">���G���[���[��</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">��M��</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'sum'}</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">�P�v�I�ȃG���[</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'err1'} ��</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">�ꎞ�I�ȃG���[</td>
                                                              <td bgcolor="#FFFFFF">$hash->{'err2'} ��</td>
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
	my $title = '�G���[���[���W�v';
	my $list = &getList($line);
	my $total = @$list;
	my $main = <<"END";
<form name="form1" method="post" action="$main'indexcgi">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td width="20">&nbsp;</td>
                                            <td width="502"><table border="0" cellspacing="1" cellpadding="3">
                                                <tr>
                                                  <td>��M����<strong>�G���[���[���̏W�v����</strong>��\\�����܂��B</td>
                                                </tr>
                                                <tr>
                                                  <td>�o�^�҂��폜����ꍇ�́A�G���[�񐔂���͌�u�o�^�҂��폜����v�{�^�����N���b�N���Ă��������B </td>
                                                </tr>
                                                
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
$result
                                                <tr>
                                                  <td><strong>�G���[���N���Ă���o�^��</strong>�ꗗ�@[ TOTAL $total\�� ]
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td width="200" bgcolor="#99CCFF">���[���A�h���X</td>
                                                              <td bgcolor="#99CCFF">�P�v�I�ȃG���[��</td>
                                                              <td bgcolor="#99CCFF">�ꎞ�I�ȃG���[��</td>
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
                                                              <td bgcolor="#FFFFFF" colspan="3" align="center">�o�^����Ă��܂���</td>
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
                                       �P�v�I�ȃG���[
                                                        <input name="err1" type="text" id="err1" value="$err1" size="3">
��ȏ�<br>
<input name="err" type="radio" value="1"$k_err2>
�ꎞ�I�ȃG���[
                                                        <input name="err2" type="text" id="err2" value="$err2" size="3">
��ȏ��
<input type="submit" name="Submit" value="�@�o�^�҂��폜����@" onClick="return confir('�o�^�҂��폜���܂��B��낵���ł���?');"></td></tr>
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
	my $title = '�G���[���[���폜�җ���';
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
                                                  <td>�G���[���[����M�ɂ��폜����<strong>�o�^�҈ꗗ</strong>��\\�����܂��B</td>
                                                </tr>
                                                <tr>
                                                  <td>�ۑ������폜����ꍇ�́A���͌�u�S�Ă��N���A����v�{�^�����N���b�N���Ă��������B </td>
                                                </tr>
                                                
                                                <tr>
                                                  <td>$menu</td>
                                                </tr>
                                                <tr>
                                                  <td><strong>�폜�����o�^�҂̃��[���A�h���X</strong>�ꗗ�@[ TOTAL $total\�� ]</td>
                                                </tr>
                                                
                                                <tr>
                                                  <td><textarea name="textarea" cols="50" rows="10">
$list</textarea></td>
                                                </tr>
                                                <tr align="center">
                                                  <td><input type="submit" name="Submit" value="�S�Ă��N���A����" onClick="return confir('�{���ɍ폜���܂���?');">
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
		&main'make_plan_page('plan','','�폜����G���[�������w�肵�Ă��������B');
		exit;
	}
	
	my $total = &delete($line, {'e'=>$error_type,'n'=>$error_n});
	my @e = (
		'�P�v�I�ȃG���[ ',
		'�ꎞ�I�ȃG���[ '
	);
	my $error_target = $e[$opts->{'e'}]. $error_n. '��ȏ�';
	
	my $id  = $main'param{'id'} -0;
	my $menu = &menu( $id );
	my $title = '�G���[���[���蓮��M';
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
                                                    �o�^�҂̍폜���������܂����B<br>
                                                    <br>
                                                    <table width="300" border="0" cellpadding="0" cellspacing="0">
                                                      <tr>
                                                        <td></td>
                                                      </tr>
                                                      <tr>
                                                        <td bgcolor="#ABDCE5"><table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                            <tr>
                                                              <td colspan="2" bgcolor="#E5FDFF">���o�^�ҍ폜����</td>
                                                            </tr>
                                                            <tr>
                                                              <td bgcolor="#E5FDFF">����</td>
                                                              <td bgcolor="#FFFFFF">$error_target</td>
                                                            </tr>
                                                            
                                                            <tr>
                                                              <td width="100" bgcolor="#E5FDFF">�o�^�ҍ폜��</td>
                                                              <td bgcolor="#FFFFFF">$total ��</td>
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
	
	my $host = '�G���[���[���A�J�E���g�ݒ�';
	
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

sub renew
{
	
	my $table = "";
	if( $main'param{'on'} ){
		# �ڑ��e�X�g
		my $ref = &connect({ 'h'=>$main'param{'pop'},'u'=>$main'param{'account'},'p'=>$main'param{'pass'} });
		$table .= &errRef( 0, $ref );
		if( $table eq '' && $main'param{'addr'} eq "" ){
			$table .= '<br>���[���A�h���X���w�肵�Ă��������B';
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


sub receive
{
	my( $line, $profile ) = @_;
	
	my %hash = ();
	$hash{'sum'} = '��M�ݒ肳��Ă��܂���';
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
			
			# �ۑ��ς�E-mail���擾
			my $target = &getMem( $line );
			
			my $ref_mailindex = $pop->list();
			my @mailindex = sort {$a<=>$b } keys %$ref_mailindex;
			$hash{'sum'} = @mailindex . ' ��';
			foreach my $id ( @mailindex ){
				my $heads = &Weblogic::Pop3'parse($pop->top($id)); # ��M���[���w�b�_���擾
				
				# ����
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
		# �����폜
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
	
	my @add = (); # �폜�A�h���X
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
		# �����ɒǉ�
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
	# �ۑ��ς�E-mail���擾
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
	# �ۑ��ς�E-mail���擾
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
			&main'make_plan_page('plan','','�G���[�񐔂��w�肵�Ă�������');
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
	
	# �����폜
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
		
		# ���[����M
		local $root = $main'myroot;
		my $libpop3 = "${'root'}lib/netpop3_pl.cgi";
		eval{ require $libpop3; };
		if( $@ ){
			return;
		}
		
		# ����Subject���擾
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
				# �ꎞ��~
				select( undef, undef, undef, 0.10 );
			}
		}
		close(PLAN);
	}
}

1;
