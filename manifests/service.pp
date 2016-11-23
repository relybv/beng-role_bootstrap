# == Class role_bootstrap::service
#
# This class is meant to be called from role_bootstrap.
# It ensure the service is running.
#
class role_bootstrap::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $::role_bootstrap::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
