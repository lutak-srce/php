# Class: php::mod::pecl::apcu
class php::mod::pecl::apcu (
  $major            = $php::major,
  $package_ensure   = $php::package_ensure,
  $enabled          = '1',
  $enable_cli       = '0',
  $preload_path     = '',
  $shm_size         = '32M',
  $ttl              = '0',
  $gc_ttl           = '3600',
  $smart            = '0',
  $entries_hint     = '4096',
  $mmap_file_mask   = '/tmp/apc.XXXXXX',
  $slam_defense     = '1',
  $serializer       = 'default',
  $use_request_time = '1',
  $coredump_unmap   = '0',
) inherits php {
  package { 'php-pecl-apcu':
    ensure => $package_ensure,
    name   => "php${major}-pecl-apcu",
  }
  file { '/etc/php.d/apcu.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/apcu.ini.erb'),
    require => Package["php${major}-pecl-apcu"],
  }
}
