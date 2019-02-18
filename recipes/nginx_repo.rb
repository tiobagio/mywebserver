# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# rhel ->node['kernel']['machine']  =~ /x86_64/ ? 'x86_64' : 'i686'
# ubuntu->node['hostnamectl']['architecture'] =~ /x86_64/ ? `x86_64` :
case node['platform_family']
when 'rhel'
  yum_repository 'nginx' do
      description 'official nginx repo'
      #baseurl=https://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
      baseurl "https://nginx.org/packages/mainline/#{node['platform_family']}/#{node['nginx']['rhel_version']}/$basearch/"
      gpgcheck false
      enabled true
      action :create
  end
when 'debian'
  apt_repository 'nginx' do
    #deb https://nginx.org/packages/mainline/ubuntu/ codename nginx
    uri "https://nginx.org/packages/mainline/#{node[:platform]}/"
    distribution "#{node[:lsb][:codename]} #{node[:nginx][:package_name]}"

    #$wget https://nginx.org/keys/nginx_signing.key
    #$apt-key add nginx_signing.key
    key 'https://nginx.org/keys/nginx_signing.key'
    action :add
  end
end