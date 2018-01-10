#
# = Class: php::mod::pecl::apc
#
class php::mod::pecl::apc (
  $enabled          = '1',
  $shm_segments     = '1',
  $optimization     = '0',
  $shm_size         = '32M',
  $ttl              = '0',
  $user_ttl         = '0',
  $num_files_hint   = '1000',
  $mmap_file_mask   = '/tmp/apc.XXXXXX',
  $enable_cli       = '0',
  $cache_by_default = '1',
) {

  ::php::mod::pecl::mod { 'apc': }

  file { '/etc/php.d/apc.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/apc.ini.erb'),
    require => Package['php-pecl-apc'],
  }

}
