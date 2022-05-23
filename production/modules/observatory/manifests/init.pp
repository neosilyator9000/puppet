class observatory(
	$left = $facts['networking']['ip'],
	$right = undef,
	$psk = undef,	
)
{
	contain observatory::package
	contain observatory::ipsec
	contain observatory::networking
	contain observatory::iptables
	contain observatory::squid
	contain observatory::bind 


if $facts['os']['family'] == 'Debian' {
	$fw = 'ufw'
	$bind = 'bind9'
	$bind_path = '/etc/bind/named.conf.options'
	if $facts['os']['name'] == 'Debian'{
		$network_path = '/etc/network/interfaces.d/51-gre-tun.erb'
		$network_source = 'interfaces.erb'
		$network_service = 'networking'
	}	
	else{
		$network_path = '/etc/netplan/51-gre-tun.yaml'
		$network_source = '51-gre-tun.yaml.erb'
	}
}
if $facts['os']['family'] == 'RedHat' {
	$fw = firewalld
	$bind = 'bind'
	$bind_path = '/etc/named.conf'
	$network_path = '/etc/sysconfig/ifcfg-gre1'
	$network_source = 'ifcfg-gre1.erb'
	$network_service = 'NetworkManager'
}
}
