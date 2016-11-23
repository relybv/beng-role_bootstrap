# == Class role_bootstrap::install
#
# This class is called from role_bootstrap for install.
#
class role_bootstrap::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $::role_bootstrap::package_name:
    ensure => present,
  }
}
