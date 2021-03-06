name 'mywebserver'
maintainer 'tio bagio'
maintainer_email 'tio@chef.io'
license 'All Rights Reserved'
description 'Installs/Configures mywindows'
long_description 'Installs/Configures mywindows'
version '0.1.1'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'iis', '>= 7.2.0'
#depends 'windows', '>= 4.1.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/mywindows/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/tiobagio/mywebserver'
