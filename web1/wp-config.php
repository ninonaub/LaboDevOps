<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpvagrant' );

/** Database username */
define( 'DB_USER', 'root' );

/** Database password */
define( 'DB_PASSWORD', '0000' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          ';#kr!xL`Y_>us7ir(jd@?rHuCV4.DNb$05?LB~mD#e!f54vLQ&N!P4{L!>Z01In`' );
define( 'SECURE_AUTH_KEY',   'K.-,V2v3;.fMd3D>V<.wN9kGWSrg}ndG^0.QNu4TH9WK.~GR*`{)9x CE$0CYX!=' );
define( 'LOGGED_IN_KEY',     '<caqH;duH9s7N0ukPm[w2-9Z!Rr%A|-RUF`rwj_N+A)MfB0 jO8y m_9z]ftn zJ' );
define( 'NONCE_KEY',         'pzvPe0VHRRRMO=agZ0T4uz&MMhgMw6w,{z5Oh#b%EX|6 B0,WQ=[3%|j0XnCpTBm' );
define( 'AUTH_SALT',         'Yr -^e?UI4`1uL_j[O$AL>%vOYyyO#O/5NZzNdo2u[:7{mm=ksz*y~ ` k;G,OHM' );
define( 'SECURE_AUTH_SALT',  'G}Ub_.k/ ,+!7fJvWmG1ARUS5FKfc6H+a0SdGHC4%;k$&U&52Ls2 P5F#Fh72 Nr' );
define( 'LOGGED_IN_SALT',    'nbufOOU%0CQ;:!?83o2WLh52`?|tG?=&5YAKQO$`.B-$_6RSkcQh3GDUqoT&`&]G' );
define( 'NONCE_SALT',        ' ,$m9R?vbz=HrvYSrH48#o8e!++K4H54ghFk}3t4@2/uLp~vMs29l|D:C1Q!+dPv' );
define( 'WP_CACHE_KEY_SALT', '!~ZjS^G7{p4Eut`.}XoI>GD2NwPvZusfF.A_ISz>{83diKJ|`CoDF}pPeV?QoL*=' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );


/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
