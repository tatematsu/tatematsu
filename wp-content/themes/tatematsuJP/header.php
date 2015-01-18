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
<meta name="twitter:card" content="summary">
<meta name="twitter:site" content="@tatematsu">
<meta name="twitter:title" content="<?php wp_title(' ','true','right'); ?>">
<meta name="twitter:description" content="<?php print $site_description; ?>">
<meta name="twitter:creator" content="@tatematsu">
<meta name="twitter:image:src" content="http://tatematsu.jp/wp-content/themes/tatematsuJP/images/tatematsu_320x320.jpg">
<meta name="twitter:domain" content="tatematsu.jp">
<meta name="twitter:app:name:iphone" content="">
<meta name="twitter:app:name:ipad" content="">
<meta name="twitter:app:name:googleplay" content="">
<meta name="twitter:app:url:iphone" content="">
<meta name="twitter:app:url:ipad" content="">
<meta name="twitter:app:url:googleplay" content="">
<meta name="twitter:app:id:iphone" content="">
<meta name="twitter:app:id:ipad" content="">
<meta name="twitter:app:id:googleplay" content="">

<link rel="profile" href="http://gmpg.org/xfn/11" />
<!--link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'stylesheet_url' ); ?>" //-->
<link rel="stylesheet" type="text/css" media="all" href="<?php bloginfo( 'template_url' ); ?>/tatematsuJP_style.css" />
<link rel="stylesheet" type="text/css" media="print" href="<?php bloginfo( 'template_url' ); ?>/print.css" />
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<link rel="author" href="https://plus.google.com/+%E7%AB%8B%E6%9D%BE%E7%9B%B4%E6%96%87p" />
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

<!--Start of Zopim Live Chat Script-->
<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//v2.zopim.com/?1l6aEakzEJMFBgRFZl2U6uNMRUJ4KUGK';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document,'script');
</script>
<!--End of Zopim Live Chat Script-->

</head>
<body <?php body_class(); ?>>
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-FQ4M"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-FQ4M');</script>
<!-- End Google Tag Manager -->

<div id="wrapper">
<div id="header">
<a href="<?php bloginfo('url'); ?>"><img src="<?php bloginfo('template_url'); ?>/images/headers/site-logo.png" class="site_logo" border=0/></a>
<div id="web_license">
	<a target="_blank" rel="nofollow" href="https://www.google.com/partners/?hl=ja#a_profile;idtf=3734458962;"><img src="<?php bloginfo('template_url'); ?>/images/google_partner_badge.png"></a>
	<img src="<?php bloginfo('template_url'); ?>/images/yahoo_pro2012.jpg">
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
<li><a href="<?php bloginfo('url'); ?>/consulting/">コンサルティング</a></li>
<li><a href="<?php bloginfo('url'); ?>/listings/">リスティング広告</a></li>
<li><a href="<?php bloginfo('url'); ?>/withc/">withCソリューション</a></li>
<li><a href="<?php bloginfo('url'); ?>/plan/">プラン料金</a></li>
<li><a href="<?php bloginfo('url'); ?>/blog/">ブログ/WebマーケティングDays</a></li>
<li><a href="<?php bloginfo('url'); ?>/inquiry/">お問合わせ</a></li>
</ul>
</div>
