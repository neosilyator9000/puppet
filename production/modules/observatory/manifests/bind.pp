class observatory::bind (){
        package {'install bind':
                name => $bind,
                ensure => installed,
                provider => $facts['package_provider'],
        }
        file {'bind config':
                path => $bind_path,
                ensure => present,
                mode => 640,
                owner => root,
                group => root,
                source => 'puppet:///modules/observatory/named.conf',
                replace => true,
                notify => service['bind'],
        }
        service {'bind service':
                name => 'named',
                ensure => running,
                enabled => true,
        }
}

