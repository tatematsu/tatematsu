<?php global $is_ajax; $is_ajax = isset($_SERVER['HTTP_X_REQUESTED_WITH']); if (!$is_ajax) get_header(); ?>
<?php $wptouch_settings = bnc_wptouch_get_settings(); ?>
 <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
 	<div class="post content" id="post-<?php the_ID(); ?>">
	 <div class="page">
		<div class="page-title-icon">		
			<?php bnc_the_page_icon(); ?>
		</div>
		<h2><?php the_title(); ?></h2>
	</div>
	      
<div class="clearer"></div>
  
    <div id="entry-<?php the_ID(); ?>" class="pageentry <?php echo $wptouch_settings['style-text-justify']; ?>">
        <?php if (!is_page('archives') || !is_page('links')) { the_content(); } ?>  
            <!-- Begin MailChimp Signup Form -->
            <link href="http://cdn-images.mailchimp.com/embedcode/slim-081711.css" rel="stylesheet" type="text/css">
            <style type="text/css">
                #mc_embed_signup{background:#fff; clear:left; font:14px; }
                /* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
                   We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
            </style>
            <div id="mc_embed_signup">
              <form action="http://tatematsu.us7.list-manage1.com/subscribe/post?u=aa13f48189cfbe3b6aea73621&amp;id=6459a6757c" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
                <label for="mce-EMAIL">ウェブコンサルティングタテマツ　最新情報をメールでお届けします。</label>
                <input type="email" value="" name="EMAIL" class="email" id="mce-EMAIL" placeholder="eメールアドレス" required>
                <div class="clear">
                  <input type="submit" value="登録する" name="subscribe" id="mc-embedded-subscribe" class="button">
                </div>
              </form>
            </div>
            <!--End mc_embed_signup-->
            <div class="call_box">
            <p class="call_info"><span class="icon_toolbox"></span>&nbsp;今すぐのお問合せはお電話で。</p>
            <p>（月〜金曜日 AM 9:00 - 17:00 PM）</p>
            <a class="call_btn" href="tel:05036920232">お問合せ <span class="icon_mobile"></span> 050-5866-6511</a>
            <div style="clear:both"></div>
            &nbsp;
            <p class="call_info"><span class="icon_toolbox"></span>&nbsp;メールでのお問合せ。</p>
            <a class="call_btn" href="/inquiry/"><span class="icon_mail_alt"></span>&nbsp;お問合せフォーム</a>
            <div style="clear:both"></div>
            </div>
            <!-- fb likebox -->
            <div class="fb-like-box" data-href="https://www.facebook.com/tatematsu.jp" data-width="280" data-show-faces="true" data-stream="true" data-show-border="true" data-header="true"></div>
            <!-- fb likebox -->   

<?php if (is_page('archives')) {
// If you have a page named 'Archives', the WP tag cloud will be displayed
?>
          </div>
	</div>

	<h3 class="result-text"><?php _e( "Tag Cloud", "wptouch" ); ?></h3>
		<div id="wptouch-tagcloud" class="post">
			<?php wp_tag_cloud('smallest=11&largest=18&unit=px&orderby=count&order=DESC'); ?>
		</div>
	</div>
</div>

	<h3 class="result-text"><?php _e( "Monthly Archives", "wptouch" ); ?></h3>
		<div id="wptouch-archives" class="post">
			<?php wp_get_archives(); // This will print out the default WordPress Monthly Archives Listing. ?> 
		</div>
		  
<?php } ?><!-- end if archives page-->
            
<?php if (is_page('photos')) {
// If you have a page named 'Photos', and the FlickrRSS activated and configured your photos will be displayed here.
// It will override other number of images settings and fetch 20 from the ID.
?>
	<?php if (function_exists('get_flickrRSS')) { ?>
		<div id="wptouch-flickr">
			<?php get_flickrRSS(20); ?>
		</div>
	<?php } ?>
<?php } ?><!-- end if photos page-->
		</div>
	</div>   
           		
<?php if (is_page('links')) {
// If you have a page named 'Links', a default listing of your Links will be displayed here.
?>
		</div>
	</div>          

		<div id="wptouch-links">
			<?php wp_list_bookmarks('title_li=&category_before=&category_after='); ?>
		</div>
<?php } ?><!-- end if links page-->    	
	
		<?php wp_link_pages( __('Pages in this article: ', 'wptouch'), '', 'number'); ?>

    <?php endwhile; ?>	

<?php else : ?>

	<div class="result-text-footer">
		<?php wptouch_core_else_text(); ?>
	</div>

 <?php endif; ?>

<!-- If it's ajax, we're not bringing in footer.php -->
<?php get_footer(); ?>