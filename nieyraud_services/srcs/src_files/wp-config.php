a base de données MySQL. */
define( 'DB_USER', 'admin' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'admin' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', 'localhost' );

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '=Qvb!%*QCXSQL[r/^NhHI,s2n!H.r&g*Q7Sf~<|nw1{/9~T`*lD`;5c?=cd?fBot' );
define( 'SECURE_AUTH_KEY',  'P*nUZ~|?HW4y*gv[x$Zxz6m{_T(:HI&}YT>KJf6oRH<ZVi;NIX*^{M/IO0{yif6<' );
define( 'LOGGED_IN_KEY',    'jSNS.l_b.Qf<w]~vq;`k0$o.tU|$H,L[W2,^z?o,N}9;s#(_hjY*M7.W#P-uF%1=' );
define( 'NONCE_KEY',        'j?P};d~%UxLaK*Q#IRy9^]z7 r#9!bG:v#au]3Fm`+-lS5$=#-p<yuhmndMYc2<%' );
define( 'AUTH_SALT',        'YdbzZ!&Bm?J.6AQwV?&}{>sSm<6!7^DHG)|+/Lg$V&cV~<i<X=JzN(g>L85tV;~B' );
define( 'SECURE_AUTH_SALT', '>{q)J<A&JA 705*wX[3rw-HWs!$injrIn}#z,Q]zd`O4KCUe$ofg.p3q5-1HEt0B' );
define( 'LOGGED_IN_SALT',   '>C@p2*x!2vQ05MQ!XKZcor5OHL0ILv0ezg;beXZv4xi0|<5g]q1~`4tiielgX28d' );
define( 'NONCE_SALT',       '#a6r,-HkWBAf#p1+*tDY|^F@p~Z7G|3*5[o1 KH6HDz>zE,#4&iYG.+r}0iW+>.r' );
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortemment recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');