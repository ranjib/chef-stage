name              "stage"
maintainer        "Ranjib Dey"
maintainer_email  "dey.ranjib@gmail.com"
license           "Apache 2.0"
description       "Multi stage chef runs. Run sub chef runs"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.4"

%w{ debian ubuntu redhat centos fedora scientific amazon oracle}.each do |os|
  supports os
end
