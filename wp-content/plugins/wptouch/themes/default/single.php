<?php global $is_ajax; $is_ajax = isset($_SERVER['HTTP_X_REQUESTED_WITH']); if (!$is_ajax) get_header(); ?>
<?php $wptouch_settings = bnc_wptouch_get_settings(); ?>

<div class="content single" id="content<?php echo md5($_SERVER['REQUEST_URI']); ?>">
  <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
  <div class="post"> <a class="sh2" href="<?php the_permalink() ?>" rel="bookmark" title="<?php _e( "Permanent Link to ", "wptouch" ); ?><?php if (function_exists('the_title_attribute')) the_title_attribute(); else the_title(); ?>">
    <?php the_title(); ?>
    </a>
    <div class="single-post-meta-top"><?php echo get_the_time( __( 'M jS, Y @ h:i a', 'wptouch' 
) ) ?> 
      <!--
 &rsaquo;-->
      <?php //the_author() ?>
      <br />
      
      <!-- Let's check for DISQUS... we need to skip to a different div if it's installed and active -->
      <?php if ( 'open' == $post->comment_status && bnc_can_show_comments() ) : ?>
      <?php if (function_exists('dsq_comments_template')) { ?>
      <a href="#dsq-add-new-comment">&darr;
      <?php _e( "Skip to comments", "wptouch" ); ?>
      </a>
      <?php } elseif (function_exists('id_comments_template')) { ?>
      <a href="#idc-container-parent">&darr;
      <?php _e( "Skip to comments", "wptouch" ); ?>
      </a>
      <?php } elseif (isset($post->comment_count) && $post->comment_count == 0) { ?>
      <a href="#respond">&darr;
      <?php _e( "Leave a comment", "wptouch" ); ?>
      </a>
      <?php } elseif (isset($post->comment_count) && $post->comment_count > 0) { ?>
      <a href="#com-head">&darr;
      <?php _e( "Skip to comments", "wptouch" ); ?>
      </a>
      <?php } ?>
      <?php endif; ?>
    </div>
  </div>
  <div class="clearer"></div>
  <?php wptouch_include_ads(); ?>
  <div class="post" id="post-<?php the_ID(); ?>">
    <div id="singlentry" class="<?php echo $wptouch_settings['style-text-justify']; ?>">
      <?php the_content(); ?>
    </div>
    
    <!-- Categories and Tags post footer -->
    <div class="single-post-meta-bottom">
      <?php wp_link_pages( 'before=<div class="post-page-nav">' . __( "Article Pages", "wptouch-pro" ) . ':&after=</div>&next_or_number=number&pagelink=page %&previouspagelink=&raquo;&nextpagelink=&laquo;' ); ?>
      <?php _e( "Categories", "wptouch" ); ?>
      :
      <?php if (the_category(', ')) the_category(); ?>
      <?php if (function_exists('get_the_tags')) the_tags('<br />' . __( 'Tags', 'wptouch' ) . ': ', ', ', ''); ?>
    </div>    
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
    <a class="call_btn" href="tel:05058666511">お問合せ <span class="icon_mobile"></span> 050-5866-6511</a>
    <div style="clear:both"></div>
    &nbsp;
	<p class="call_info"><span class="icon_toolbox"></span>&nbsp;メールでのお問合せ。</p>
    <a class="call_btn" href="/inquiry/"><span class="icon_mail_alt"></span>&nbsp;お問合せフォーム</a>
    <div style="clear:both"></div>
    </div>
    <!-- fb likebox -->
    <div class="fb-like-box" data-href="https://www.facebook.com/tatematsu.jp" data-width="280" data-show-faces="true" data-stream="true" data-show-border="true" data-header="true"></div>
    <!-- fb likebox --> 
    <?php comments_template(); ?>

  </div>
  <!-- Let's rock the comments -->
  <?php endwhile; else : ?>
  
  <!-- Dynamic test for what page this is. A little redundant, but so what? -->
  
  <div class="result-text-footer">
    <?php wptouch_core_else_text(); ?>
  </div>
  <?php endif; ?>
</div>
<?php get_footer(); ?>
