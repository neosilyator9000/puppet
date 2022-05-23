class observatory::networking(
#	$tun_static = undef,
#	$tun_static_remote = undef,
#	$tun_netmask = undef,
#	$mtu = undef,
#	$service = $observatory::network_service
){
        if $observatory::network_service {
				$callme = 'service[\'restart network service\']'
                service {'restart network service':
                        name => $network_service,
                        ensure => 'running',
                        enables => true,
                }
        }
        else {
				$callme =  'exec[\'netplan apply\']'
                exec {'netplan aplly':
                        command => '/usr/sbin/netplan apply',
                }
        }
        file{'network script':
                path => $network,
                ensure => present,
                mode => 640,
                owner => root,
                group => root,
                source => 'puppet:///modules/observatory/files/$network_source',
                content => template('observatory/$network_source'),
                notify => $service,
        }
}

