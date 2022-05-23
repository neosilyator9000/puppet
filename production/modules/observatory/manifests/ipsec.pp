class observatory::ipsec ($left, $right, $psk){
        package {'strongswan':
                name => strongswan,
                ensure => installed,
                provider => $facts['package_provider'],
        }
        

#$left = $facts['networking']['ip']
#$right = '213.110.156.230'
#$psk = "jKc1YoY&WCxZ0Cf3cy^0s@hpq7wN#TAbFMkz%Vok4y#cuKKHwQ"

        file {'config':
                path => '/etc/ipsec.conf',
                owner => 'root',
                group => 'root',
                mode => 644,
                replace => true,
                content => template('observatory/ipsec.conf.erb')
        }
        file {'secret':
                path => '/etc/ipsec.secrets',
                owner => 'root',
                group => 'root',
                mode => 600,
                replace => true,
                content => template('observatory/ipsec.secrets.erb')
        }
        service {'ipsec':
                name => 'ipsec',
                ensure => 'running',
                enable => true,
                
        }
}

