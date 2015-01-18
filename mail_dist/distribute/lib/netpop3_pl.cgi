
package Weblogic::Pop3;

#  return 1→接続エラー
#  return 2→認証エラー
sub connect
{
	my( $host, $user, $pass ) = @_;
	
	use Net::POP3;
	
	my $pop3;
	
	$pop3 = &login( $host, $user, $pass, 'apop' );
	if( $pop3 == 1 ){
		return 1;
	}elsif( $pop3 == 2 ){
		$pop3 = &login( $host, $user, $pass, 'login' );
		if( $pop3 == 2 ){
			return 2;
		}
	}
	return $pop3;
}

sub login
{
	my( $host, $user, $pass, $protocol ) = @_;
	
	# 接続
	my $pop3 = Net::POP3->new($host) or return 1;
	# 認証方式
	my $login = (lc($protocol) eq 'apop') ? 'apop' : 'login';
	# 認証
	unless( $pop3->$login($user, $pass) ){
		$pop3->quit();
		return 2;
	}
	return $pop3;
}


sub parse
{
	my $ref_lines = shift;
	my %hash = (); # メール情報
	my $bound = 0; # ヘッダ・本文区分フラグ
	my $header = ""; # 初期化
	my @body = (); # 初期化
	
	foreach( @$ref_lines ){
		my $line = $_;
		$bound = 1 if ( $line =~ /^\r?\n$/ );
		
		if( $bound == 0 ){
			chomp($line);
			if( $line =~ /^([^\s]+):(.+)/ ){
				$header = $1;
				$hash{$header} .= $2;
				next;
			}
			if( $line ne "" ){
				$hash{$header} .= $line;
			}
			next;
		}else{
			push @body, $line;
		}
	}
	
	if( @body ){
		&body( \%hash, \@body );
	}
	
	return {%hash};
}

sub body
{
	my( $hash, $body ) = @_;
	
	if( $hash->{'Content-Type'} =~ /multipart\/(.+);/ ){
		$hash->{'multi'} = 1;
		&_multi( $hash, $body );
	}else{
		$hash->{'multi'} = 0;
		$hash->{'plain'} = [@$body];
	}
}

sub _multi
{
	my( $hash, $body ) = @_;
	my $bound = "";
	if( $hash->{'Content-Type'} =~ /boundary="([^\"]+)"/i ){
		$bound = $1;
	}
	
	my @m = ();
	my $n = -1;
	foreach my $line ( @$body ){
		if( $line =~ /^\-+$bound/ ){
			$n++;
		}
		push @{ $m[$n] }, $line if( $n >= 0 );
	}
	# マルチパートがない場合
	if( $n < 0 ){
		$hash->{'plain'} = [@$body];
		$hash->{'multi'} = 0;
	}else{
		foreach my $array ( @m ){
			my $part = &parse($array);
			if( $part->{'Content-Type'} =~ /text\/plain\s*/ ){
				$hash->{'plain'} = $part->{'plain'};
			}else{
				push @{ $hash->{'part'} }, {%$part};
			}
		}
	}
}

sub bounce
{
	my $hash = shift;
	
	my @pkg = (
		'qmail',
		'postfix',
		'mobile',
		'simple'
	);
	
	foreach my $p ( @pkg ){
		my %result = ();
		my $fp = "Weblogic::Pop3::Bounce::$p";
		my( $addr ) = &$fp($hash, \%result);
		if( $addr ){
			$result{'addr'} = &addrClean($addr);
			return {%result};
		}
	}
	return 0;
}

sub addrClean
{
	my( $addr ) = @_;
	
	$addr =~ s/^<//;
	$addr =~ s/>$//;
	$addr =~ s/^$//;
	$addr =~ s/\"$//;
	return $addr;
}

package Weblogic::Pop3::Bounce;

sub qmail
{
	my( $hash, $result ) = @_;
	my( $addr, $reason, $status1, $status2 );
	my $b = &block( $hash->{'plain'} );
	
	my $pattern     = 'Hi. This is the';
    my $end_pattern = '--- Undelivered message follows ---';
	
	my $code = 0;
	foreach my $data ( @$b ){
		$code = 1 if( $data =~ /$pattern/ );
		$code = 0 if( $data =~ /$end_pattern/ );
		
		if( $code == 1 ){
			if ($data =~ /\<(\S+\@\S+)\>:\s*(.*)/) {
				($addr, $reason) = ($1, $2);
				
				my($s,$h) = &_simpleMatch($reason);
				if( $s ){
					$status = $s;
					$reason = $h;
				}
				if( $status eq "" ){
					if ($data =~ /\#(\d+\.\d+\.\d+)/) {
				    	$status = $1;
					}elsif ($data =~ /\s+(\d{3})\s+/) {
						my $s = $1;
						$status  = '5.0.0' if $s =~ /^5/o;
						$status  = '4.0.0' if $s =~ /^4/o;
					}
					return if( $status eq "" );
				}
				$result->{'addr'} = $addr;
				$result->{'reason'} = $reason;
				$result->{'status'} = $status;
				
				return $addr;
			}
		}
	}
	
}

sub postfix
{
	my( $hash, $result ) = @_;
	my( $addr, $reason, $status );
	if( $hash->{'multi'} ){
		foreach my $part ( @{ $hash->{'part'} } ){
			if( index( $part->{'Content-Type'},'message/delivery-status' ) >= 0 ){
				
				my %header = ();
				my $h = "";
				my $addr = "";
				my $reason = "";
				foreach( @{ $part->{'plain'} } ){
					my $line = $_;
					chomp($line);
					if( $line =~ /^([^\s]+):(.+)/ ){
						$h = $1;
						$header{$h} .= $2;
						next;
					}
					if( $line ne "" ){
						$header{$h} .= $line;
					}
				}
				if( $header{'Final-Recipient'} =~ /\s*(\S+\@\S+)\s*/ ){
					$addr = $1;
					
					my($s,$h) = &_simpleMatch($header{'Diagnostic-Code'});
					if( $s ){
						$reason = $h;
					}else{
						$reason = $header{'Diagnostic-Code'};
					}
					return if( $s eq "" && $header{'Status'} <= 0 );
				}
				$result->{'addr'} = $addr;
				$result->{'reason'} = $reason;
				$result->{'status'} = $header{'Status'};
				
				return $addr;
			}
		}
	}
}

# ※Jcode.plを利用する↓
sub mobile
{
	my( $hash, $result ) = @_;
	my( $addr, $reason );
	my $b = &block( $hash->{'plain'} );
	
	my @jpn = (
		'japanese1',
		'japanese2'
	);
	foreach my $p ( @jpn ){
		my $fp = $p;
		my( $addr ) = &$fp($b,$result);
		if( $addr ){
			return $addr;
		}
	}
}

sub japanese1
{
	my( $msg, $result ) = @_;
	my( $addr, $reason );
	
	my $pattern = '次のあて先へのメッセージはエラーのため送信できませんでした。';
	
	my $code = 0;
	foreach my $data ( @$msg ){
		&jcode'convert( \$data, 'sjis', 'jis' );
		$code = 1 if( index($data, $pattern) >= 0 );
		
		if( $code == 1 ){
			if ($data =~ /\<(\S+\@\S+)\>/) {
				$addr = $1;
				$reason = "$pattern";
				
				$result->{'addr'} = $addr;
				$result->{'reason'} = $reason;
				$result->{'status'} = "5.0.0";
				
				return $addr;
			}
		}
	}
}
sub japanese2
{
	my( $msg, $result ) = @_;
	my( $addr, $reason );
	
	my $pattern = '送信先エラーにより、配信されませんでした。';
	
	my $code = 0;
	foreach my $data ( @$msg ){
		&jcode'convert( \$data, 'sjis', 'jis' );
		$code = 1 if( index($data, $pattern) >= 0 );
		
		if( $code == 1 ){
			if ($data =~ /To:\s*(\S+\@\S+)\s*/i) {
				$addr = $1;
				$reason = "$pattern";
				
				$result->{'addr'} = $addr;
				$result->{'reason'} = $reason;
				$result->{'status'} = "5.0.0";
				
				return $addr;
			}
		}
	}
}

sub simple
{
	my( $hash, $result ) = @_;
	my( $addr, $reason, $status1, $status2 );
	my $b = &block( $hash->{'plain'} );
	
	my @pattern  = (
		'----- The following addresses had',
		'----- Transcript of session follows',
	);
	
	my $code = 0;
	foreach my $data ( @$b ){
		foreach my $p ( @pattern ){
			$code = 1 if( $data =~ /$p/ );
			
			if( $code == 1 ){
				if ($data =~ /\<(\S+\@\S+)\>/) {
					$addr = $1;
					
					my($s,$h) = &_simpleMatch($data);
					if( $s ){
						$status = $s;
						$reason = $h;
					}
					if( $status eq "" ){
						if ($data =~ /\#(\d+\.\d+\.\d+)/) {
				    		$status = $1;
						}elsif ($data =~ /\s+(\d{3})\s+/) {
							my $s = $1;
							$status  = '5.0.0' if $s =~ /^5/o;
							$status  = '4.0.0' if $s =~ /^4/o;
						}
						return if( $status eq "" );
					}
					
					$result->{'addr'} = $addr;
					$result->{'reason'} = $reason;
					$result->{'status'} = $status;
					
					return $addr;
				}
			}
			$code = 0;
		}
	}
	
}

sub block
{
	my( $lines ) = @_;
	my $p = 0;
	my @l = @$lines;
	my @m = ();
	foreach my $line ( @l ){
		$p++ if( $line =~ /^\r?\n$/ );
		$line =~ s/\r?\n/ /g;
		$m[$p] .= $line;
	}
	return [@m];
}

sub _simpleMatch
{
	my $reason = shift;
	my $match_rex = {
		'5.0.0' => [
			'Host unknown',
			'Host not found',
			'unknown host',
			"I couldn't find any host",
			'User unknown',
			'unknown user',
			'No such user here',
			'mailbox unavailable',
			'no mailbox here by that name',
			'Recipient is not local',
			'Relaying Denied',
			'553 Unbalanced',
			'550 Invalid recipient',
			'lookup failed temporarily',
			'establish an SMTP connection',
		],
			
		'4.0.0' => [
			'over quota',
			'mailbox is full',
			'size exceeds remaining quota',
			'Quota exceeded',
			'could not be delivered',
			'has been disabled or discontinued',
			'but sender was rejected',
			'Message is too large',
			'Name server timeout',
		]
	};
	
	foreach $r ( sort{ $b <=> $a } keys %{ $match_rex } ){
		my $rd = $match_rex->{$r};
		foreach $h ( @$rd ){
			if( $reason =~ /$h/i ){
				return $r,$h;
			}
		}
	}
	return;
}
1;
