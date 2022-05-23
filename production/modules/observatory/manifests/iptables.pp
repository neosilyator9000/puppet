class observatory::iptables(){
        package {'iptables':
                name => 'iptables',
                ensure => 'installed',
                provider => $facts['package_provider'],
        }
        package {'iptables-persistent':
                name => 'iptables-persistant',
                ensure => 'installed',
                provider => $facts['package_provider'],
        }
        service {'firewall':
                name => $fw,
                ensure => 'stopped',
                enable => mask,
        }
        file {'rulesd':
                path => '/etc/iptables',
                ensure => directory,
                mode => 644,
                owner => 'root',
                group => 'root',
        }
        file {'rules.v4':
                path => '/etc/iptables/rules.v4',
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => 'puppet:///modules/observatory/files/rules.v4',
                replace => true,
        }
        exec {'restore iptables chains':
                command => '/usr/sbin/iptables-restore /etc/iptables/rules.v4',
                subscribe => file['rules.v4'],
                refreshonly => true,
        }
}
