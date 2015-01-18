<?php
/**
 * The main template file.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 * Learn more: http://codex.wordpress.org/Template_Hierarchy
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 */

get_header(); ?>
<div id="contents">
<div id="main">
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) return;
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/ja_JP/all.js#xfbml=1&appId=168159883308759";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<div id="blog_header_img">
		<img src="<?php bloginfo('template_url'); ?>/images/blog_ttl.png" alt="タテマツのウェブマーケティングブログ">
        <div id="blog_rss">
			<!--
			<a href="<?php bloginfo('rss2_url'); ?>">RSS購読(RSS2.0)</a>
			<a href="<?php bloginfo('rdf_url'); ?>">RDF/RSS1.0</a>
			<a href="<?php bloginfo('rss_url'); ?>">RSS0.96</a>
			-->
        	<div class="fb-like" data-href="http://tatematsu.jp/blog/" data-send="true" data-width="450" data-show-faces="false"></div>
			<div id="blog_top_twitter_btn">
				<a href="https://twitter.com/share" class="twitter-share-button" data-lang="ja" data-size="large" data-hashtags="webmarketing" data-dnt="true">ツイート</a>
				<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
		</div>
		<div id="google_plus_one_btn">
			<script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
<g:plusone></g:plusone>
		</div><!-- end of gplusone //-->
		</div>
	</div>
			<?php if ( have_posts() ) : ?>

				<?php //twentyeleven_content_nav( 'nav-above' ); ?>

				<?php /* Start the Loop */ ?>
				<?php while ( have_posts() ) : the_post(); ?>

					<?php get_template_part( 'content', get_post_format() ); ?>

				<?php endwhile; ?>

				<?php //twentyeleven_content_nav( 'nav-below' ); ?>

			<?php else : ?>

				<article id="post-0" class="post no-results not-found">
					<header class="entry-header">
						<h1 class="entry-title"><?php _e( 'Nothing Found', 'twentyeleven' ); ?></h1>
					</header><!-- .entry-header -->

					<div class="entry-content">
						<p><?php _e( 'Apologies, but no results were found for the requested archive. Perhaps searching will help find a related post.', 'twentyeleven' ); ?></p>
						<?php get_search_form(); ?>
					</div><!-- .entry-content -->
				</article><!-- #post-0 -->
			<?php endif; ?>


<?php get_sidebar(); ?>
<?php get_footer(); ?>