#!/usr/bin/perl

use CGI::Carp qw(fatalsToBrowser);
use Time::Local;

require 'script/html_parts.pl';
require 'script/contents.pl';
require 'script/title_meta_conf.pl';
require 'script/cgi-lib.pl';
require 'script/agent_check.pl';

$CGI = $ENV{'SCRIPT_NAME'};

#�G�[�W�F���g�`�F�b�N
$user_agent = $ENV{'HTTP_USER_AGENT'};
isAgent($user_agent);

#�R���e���c�ǂݍ��݊J�n
&isTermsHeader;

print"<div id=main>\n";

# �^�c�ҏ��\��
&doDisp_MyInformation;
# ���ȏЉ�R���e���c�\��
&doDispMyProfileContent;
&doDispPurchase_Policy;

print"</div>\n";#end of main

# navi
&doDispTextNavigation;
# �[���ʃt�b�^���Z�b�g
&isTermsfooter;

exit();