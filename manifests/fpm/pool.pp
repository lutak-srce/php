#
# = Define: php::fpm::pool
#
define php::fpm::pool (
  $listen               = '127.0.0.1:9000',
  $listen_owner         = undef,
  $listen_group         = undef,
  $listen_mode          = undef,
  $allowed_clients      = [ '127.0.0.1' ],
  $chdir                = undef,
  $pm                   = 'dynamic',
  $pm_max_children      = '50',
  $pm_start_servers     = '5',
  $pm_min_spare_servers = '5',
  $pm_max_spare_servers = '35',
  $pm_max_requests      = '500',
  $template             = 'php/fpm-pool.conf.erb',
) {

  include ::php
  include ::php::fpm

  $pool_name = $title

  file { "${name}.conf":
    ensure  => file,
    path    => "${::php::fpm::pool_dir}/${name}.conf",
    content => template($template),
    owner   => $::php::fpm::file_owner,
    group   => $::php::fpm::file_group,
    mode    => $::php::fpm::file_mode,
    notify  => Service['php-fpm'],
    noop    => $::php::noops,
  }

}
