<?php
/**
 * The Template for displaying all single posts.
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 * @since Twenty Eleven 1.0
 */
?>

<?php get_header(); ?>
<div id="contents">
<div id="main">
	<div id="blog_header_img">
		<img src="<?php bloginfo('template_url'); ?>/images/blog_ttl.png" alt="タテマツのウェブマーケティングブログ">
		<!--
        <div id="blog_rss_post">
		<a href="<?php bloginfo('rss2_url'); ?>">RSS購読(RSS2.0)</a>
		<a href="<?php bloginfo('rdf_url'); ?>">RDF/RSS1.0</a>
		<a href="<?php bloginfo('rss_url'); ?>">RSS0.96</a>
		</div>
        -->
	</div>
	<div id="post_area">
				<?php while ( have_posts() ) : the_post(); ?>

					<?php get_template_part( 'content', 'single' ); ?>

				<?php endwhile; // end of the loop. ?>
</div>
					<!-- end of post area //-->
	<div id="single_bottom"><a href="/inquiry/" class="inquiry_btn">★お問い合わせはこちらから</a>

<!--<p>最新記事を配信します！メルマガのご購読はこちら。 class="conv_wenmarketing" style="width:180px;height:10px;margin:0 auto 0 auto;line-height:10px;"</p>//-->
		<?php comments_template(); ?>
					</div>

<?php get_sidebar(); ?>
<?php get_footer(); ?>