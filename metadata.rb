# encoding: UTF-8
name             'razor_server'
maintainer       'Myles Steinhauser'
maintainer_email 'myles.steinhauser@gmail.com'
license          'Apache 2.0 License'
description      'Installs/Configures puppetlabs/razor-server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.6'

%w{ ubuntu }.each do |os|
  supports os
end

depends 'apt'
depends 'ark'
depends 'build-essential'
depends 'database'
depends 'dhcp'
depends 'java'
depends 'nginx'
depends 'postgresql'
depends 'tftp'
