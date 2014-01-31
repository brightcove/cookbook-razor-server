name             "razor-server"
maintainer       "Myles Steinhauser"
maintainer_email "myles.steinhasuer@gmail.com"
license          "MIT License"
description      "Installs/Configures puppetlabs/razor-server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

depends "apt"  # In order to notify execute[apt-get-update]
depends "build-essential"
depends "postgresql"
