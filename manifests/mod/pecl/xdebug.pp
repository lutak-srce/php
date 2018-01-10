#
# = Class: php::mod::pecl::xdebug
#
class php::mod::pecl::xdebug {

  ::php::mod::pecl::mod { 'xdebug': }

  file {'/etc/php.d/xdebug_conf.ini':
    ensure  => present,
    source  => 'puppet:///modules/php/xdebug_conf.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => ::Php::Mod::Pecl::Mod['xdebug'],
  }

}
