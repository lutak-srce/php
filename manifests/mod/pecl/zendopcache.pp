#
# = Class: php::mod::pecl::zendopcache
#
class php::mod::pecl::zendopcache (
  $major                   = $php::major,
  $package_ensure          = $php::package_ensure,
  $enable                  = '1',
  $enable_cli              = '0',
  $memory_consumption      = '128',
  $interned_strings_buffer = '8',
  $max_accelerated_files   = '4000',
  $max_wasted_percentage   = '5',
  $use_cwd                 = '1',
  $validate_timestamps     = '1',
  $revalidate_freq         = '2',
  $revalidate_path         = '0',
  $save_comments           = '1',
  $load_comments           = '1',
  $fast_shutdown           = '1',
  $enable_file_override    = '0',
  $optimization_level      = '0xffffffff',
  $dups_fix                = '0',
  $blacklist_filename      = '/etc/php.d/opcache*.blacklist',
  $max_file_size           = '0',
  $consistency_checks      = '0',
  $force_restart_timeout   = '180',
  $error_log               = '',
  $log_verbosity_level     = '',
  $preferred_memory_model  = '',
  $protect_memory          = '0',
) inherits php {

  ::php::mod::pecl::mod { 'zendopcache': }

  file { '/etc/php.d/opcache.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('php/zendopcache.ini.erb'),
    require => ::Php::Mod::Pecl::Mod['zendopcache'],
  }

}
