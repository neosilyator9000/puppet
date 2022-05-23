class observatory::squid(
        $squid_config = ['squid.conf','acl.conf', 'filter.sites', 'filter.url']
){
        package {'squid':
                name => 'squid',
                ensure => installed,
                provider => $facts['package_provider'],
        }
        $squid_config.each |String $squid_config_each|
        {
        $template = "${squid_config_each}.erb" 
                file {'squid main config':
                        path => "/etc/squid/${squid_config_each}",
                        mode => 644,
                        owner => root,
                        group => root,
                        source => 'puppet:///modules/observatory/templates/${template}',
                        replace => true,
                        notify => service['squid'],
                }
        }
        service {'squid':
                name => 'squid',
                ensure => running,
                enabled => true,
        }
}
