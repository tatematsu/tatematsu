<?php
/**
 * Template Name: withc_menu One column, no sidebar
 *
 * A custom page template without sidebar.
 *
 * The "Template Name:" bit above allows this to be selectable
 * from a dropdown menu on the edit page screen.
 *
 * @package WordPress
 */
 ?>

<?php get_header(); ?>
<div id="contents">
<div id="withc">
				<?php while ( have_posts() ) : the_post(); ?>

					<?php get_template_part( 'content', 'lp' ); ?>

				<?php endwhile; // end of the loop. ?>
</div>
<?php get_footer(); ?>