#
# = Class: php::mod::pecl::scream
#
class php::mod::pecl::scream (
  $enabled = '1',
) {

  ::php::mod::pecl::mod { 'scream': }

  file { '/etc/php.d/40-scream.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/scream.ini.erb'),
    require => Package['php-pecl-scream'],
  }

}
