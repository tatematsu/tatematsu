#!/usr/bin/perl

use CGI::Carp qw(fatalsToBrowser);
use Time::Local;

require 'script/html_parts.pl';
require 'script/contents.pl';
require 'script/title_meta_conf.pl';
require 'script/cgi-lib.pl';
require 'script/agent_check.pl';

$CGI = $ENV{'SCRIPT_NAME'};

#エージェントチェック
$user_agent = $ENV{'HTTP_USER_AGENT'};
isAgent($user_agent);

#コンテンツ読み込み開始
&isTermsHeader;

print"<div id=main>\n";

# 運営者情報表示
&doDisp_MyInformation;
# 自己紹介コンテンツ表示
&doDispMyProfileContent;
&doDispPurchase_Policy;

print"</div>\n";#end of main

# navi
&doDispTextNavigation;
# 端末別フッタをセット
&isTermsfooter;

exit();