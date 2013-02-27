# Start avahi services for mdns

class avahi($firewall=false) {

  class { 'avahi::package': } ~>
  class { 'avahi::service': }

  if $firewall {

    # iptables -A INPUT -p udp --dport 5353 -d 224.0.0.251 -j ACCEPT
    # iptables -A OUTPUT -p udp --dport 5353 -d 224.0.0.251 -j ACCEPT

    firewall { '100 allow avahi':
      chain       => ['INPUT', 'OUTPUT'],
      proto       => 'udp',
      dport       => '5353',
      destination => '224.0.0.251',
      action      => 'accept',
    }
  }
}
