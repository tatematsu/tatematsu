<?php
/**
 * The base configurations of the WordPress.
 *
 * このファイルは、MySQL、テーブル接頭辞、秘密鍵、言語、ABSPATH の設定を含みます。
 * より詳しい情報は {@link http://wpdocs.sourceforge.jp/wp-config.php_%E3%81%AE%E7%B7%A8%E9%9B%86 
 * wp-config.php の編集} を参照してください。MySQL の設定情報はホスティング先より入手できます。
 *
 * このファイルはインストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さず、このファイルを "wp-config.php" という名前でコピーして直接編集し値を
 * 入力してもかまいません。
 *
 * @package WordPress
 */

// 注意: 
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.sourceforge.jp/Codex:%E8%AB%87%E8%A9%B1%E5%AE%A4 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - こちらの情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define('DB_NAME', 'tatematsu-jp_kqj39082');

/** MySQL データベースのユーザー名 */
define('DB_USER', 'tatematsu-jp');

/** MySQL データベースのパスワード */
define('DB_PASSWORD', 'dango1128');

/** MySQL のホスト名 */
define('DB_HOST', 'mysql463.db.sakura.ne.jp');

/** データベースのテーブルを作成する際のデータベースのキャラクターセット */
define('DB_CHARSET', 'utf8');

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define('DB_COLLATE', '');

/* マルチサイト */
//define('WP_ALLOW_MULTISITE', true);


/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'GZrSd}7#{r_{/<}1Y=Y*`4>O.2>1h~tO]hyE+WEE(F=<lfRqVYX^t~u}-T{P0k1:');
define('SECURE_AUTH_KEY',  '>,I3]pcoaj8~MUO|(&1Ph] bM.n*O?(B.7qA%IxG7u%;sD:Iv$]2J|W/a6]pFj6]');
define('LOGGED_IN_KEY',    '/Rq]I0:j-=8hvs[Zm-+*[&3a([(e{tyL>;[uFyj#6F6H}P=|j|t^(LIU--~H>qWx');
define('NONCE_KEY',        '-QB5UJ[1RaA7IbVB~r}TFXY+`O4vYkcYaw/q^Ro?WZ:v&h)-R.]~?lxN<4pZG?o8');
define('AUTH_SALT',        'c+GsRwu-|;W`>W9,M7BIJ&XRs>a>hc,q-K%y0Q!!AR%0$OXLk@+I-tlJFHcVl()-');
define('SECURE_AUTH_SALT', '42ea j/7v2Hu9C?|L+~12^&~A(Yj *M8TO-wYMf?.Ek`I%L(vHc$]vQ+0d5OgXd-');
define('LOGGED_IN_SALT',   'Z+C]A:$&J-I{&!hzi!Y~|6fp{~M YI&(,?24uf]d.?Ewj@xGfNK/+qxzC-]j.[>U');
define('NONCE_SALT',       '_>I`BEYpzfYb$+8}1YPfD]kFiad*?[}+T$0cFanq3jK1b=V&8x#QS#>)H.V2`(o2');

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix  = 'wp_';

/**
 * ローカル言語 - このパッケージでは初期値として 'ja' (日本語 UTF-8) が設定されています。
 *
 * WordPress のローカル言語を設定します。設定した言語に対応する MO ファイルが
 * wp-content/languages にインストールされている必要があります。例えば de_DE.mo を
 * wp-content/languages にインストールし WPLANG を 'de_DE' に設定することでドイツ語がサポートされます。
 */
define('WPLANG', 'ja');

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 */
define('WP_DEBUG', false);

/* マルチサイト 
define('MULTISITE', true);
define('SUBDOMAIN_INSTALL', true);
define('DOMAIN_CURRENT_SITE', 'tatematsu.jp');
define('PATH_CURRENT_SITE', '/');
define('SITE_ID_CURRENT_SITE', 1);
define('BLOG_ID_CURRENT_SITE', 1);
*/

/* 編集が必要なのはここまでです ! WordPress でブログをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
