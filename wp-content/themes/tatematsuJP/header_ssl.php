<?php
/**
 * The Header for our theme.
 *
 * Displays all of the <head> section and everything up till <div id="main">
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 * @since Twenty Eleven 1.0
 */
?><!DOCTYPE html>
<!--[if IE 6]>
<html id="ie6" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 7]>
<html id="ie7" <?php language_attributes(); ?>>
<![endif]-->
<!--[if IE 8]>
<html id="ie8" <?php language_attributes(); ?>>
<![endif]-->
<!--[if !(IE 6) | !(IE 7) | !(IE 8)  ]><!-->
<html <?php language_attributes(); ?>>
<!--<![endif]-->
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<title><?php
	/*
	 * Print the <title> tag based on what is being viewed.
	 */
	global $page, $paged;

	wp_title( '|', true, 'right' );

	// Add the blog name.
	bloginfo( 'name' );

	// Add the blog description for the home/front page.
	$site_description = get_bloginfo( 'description', 'display' );
	if ( $site_description && ( is_home() || is_front_page() ) )
		echo " | $site_description";

	// Add a page number if necessary:
	if ( $paged >= 2 || $page >= 2 )
		echo ' | ' . sprintf( __( 'Page %s', 'twentyeleven' ), max( $paged, $page ) );

	?></title>
<link rel="profile" href="http://gmpg.org/xfn/11" />
<!--link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>" //-->
<link rel="stylesheet" type="text/css" media="all" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/tatematsuJP_style.css" />
<link rel="stylesheet" type="text/css" media="print" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/print.css" />
<link rel="pingback" href="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/" />
<!--[if lt IE 9]>
<script src="<?php echo get_template_directory_uri(); ?>/js/html5.js" type="text/javascript"></script>
<![endif]-->
<?php
	/* We add some JavaScript to pages with the comment form
	 * to support sites with threaded comments (when in use).
	 */
	if ( is_singular() && get_option( 'thread_comments' ) )
		wp_enqueue_script( 'comment-reply' );

	/* Always have wp_head() just before the closing </head>
	 * tag of your theme, or you will break many plugins, which
	 * generally use this hook to add elements to <head> such
	 * as styles, scripts, and meta tags.
	 */
	wp_head();
?>
</head>
<!-- GA Code -->
<script type="text/javascript">

	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-333460-1']);
	_gaq.push(['_trackPageview']);
	(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	})();
</script>
<!-- GA Code -->
<body <?php body_class(); ?>>

<div id="wrapper">
<div id="header">
<a href="<?php bloginfo('url'); ?>"><img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/headers/site-logo.png" class="site_logo" border=0/></a>
<div id="web_license">
	<a target="_blank" rel="nofollow" href="https://www.google.com/partners/?hl=ja#a_profile;idtf=3734458962;"><img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/google_partner_badge.png"></a>
	<img src="https://tatematsu-jp.sakura.ne.jp/wp-content/themes/tatematsuJP/images/yahoo_pro2012.jpg">
    <!--
	<div id="header_inquiry">
		<p>お問い合わせ
		<a class="call_number" href="/inquiry/">メール</a>
		<a class="call_number" href="tel:050-3692-0232">お電話 050-3692-0232</a></p>
		</p>
	</div>
    -->
</div><!-- end of license //-->
</div>
<div id="header_nav" class="clearfix">
<ul>
<li><a href="http://www.tatematsu.jp/consulting/">コンサルティングメニュー</a></li>
<li><a href="http://www.tatematsu.jp/listings/">リスティング広告メニュー</a></li>
<li><a href="http://www.tatematsu.jp/withc/">withCソリューションメニュー</a></li>
<li><a href="http://www.tatematsu.jp/plan/">プラン料金</a></li>
<li><a href="http://www.tatematsu.jp/blog/">Webマーケティングブログ</a></li>
<li><a href="http://www.tatematsu.jp/inquiry/">お問合わせ</a></li>
</ul>
</div>
