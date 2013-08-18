# Class epel
#
# Actions:
#   Configure the proper repositories and import GPG keys
#
# Reqiures:
#   You should probably be on an Enterprise Linux variant. (Centos, RHEL, Scientific, Oracle, Ascendos, et al)
#
# Sample Usage:
#  include epel
#
class epel ( $proxy = $epel::params::proxy ) inherits epel::params {

  if $::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/ {

    yumrepo { 'epel-testing':
      baseurl        => "http://download.fedoraproject.org/pub/epel/testing/${::os_maj_version}/${::architecture}",
      failovermethod => 'priority',
      proxy          => $proxy,
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - Testing - ${::architecture} "
    }

    yumrepo { 'epel-testing-debuginfo':
      baseurl        => "http://download.fedoraproject.org/pub/epel/testing/${::os_maj_version}/${::architecture}/debug",
      failovermethod => 'priority',
      proxy          => $proxy,
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - Testing - ${::architecture} - Debug"
    }

    yumrepo { 'epel-testing-source':
      baseurl        => "http://download.fedoraproject.org/pub/epel/testing/${::os_maj_version}/SRPMS",
      failovermethod => 'priority',
      proxy          => $proxy,
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - Testing - ${::architecture} - Source"
    }

    yumrepo { 'epel':
      mirrorlist     => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-${::os_maj_version}&arch=${::architecture}",
      failovermethod => 'priority',
      proxy          => $proxy,
      enabled        => '1',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - ${::architecture}"
    }

    yumrepo { 'epel-debuginfo':
      mirrorlist     => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-${::os_maj_version}&arch=${::architecture}",
      failovermethod => 'priority',
      proxy          => $proxy,
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - ${::architecture} - Debug"
    }

    yumrepo { 'epel-source':
      mirrorlist     => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-${::os_maj_version}&arch=${::architecture}",
      proxy          => $proxy,
      failovermethod => 'priority',
      enabled        => '0',
      gpgcheck       => '1',
      gpgkey         => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      descr          => "Extra Packages for Enterprise Linux ${::os_maj_version} - ${::architecture} - Source"
    }

    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}":
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/epel/RPM-GPG-KEY-EPEL-${::os_maj_version}",
    }

    epel::rpm_gpg_key{ "EPEL-${::os_maj_version}":
      path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os_maj_version}",
      before => Yumrepo['epel','epel-source','epel-debuginfo','epel-testing','epel-testing-source','epel-testing-debuginfo'],
    }

  } elsif $::osfamily == 'RedHat' and $::operatingsystem == 'Amazon' {

    # EPEL is already installed in all AWS Linux AMI
    # we just need to enable it
    yumrepo { 'epel':
      enabled  => 1,
      gpgcheck => 1,

    }

  } else {
      notice ("Your operating system ${::operatingsystem} will not have the EPEL repository applied")
  }

}
