#
# Cookbook:: webserver
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
case node['os']
when 'linux'
    #  if node['platform_family'] == 'rhel'
    node.default['webserver'] = "nginx"
    include_recipe "mywebserver::nginx_repo"

    package "nginx"

    service "nginx" do
        action [:enable, :start]
    end

    template '/usr/share/nginx/html/index.html' do  # custom content
        source 'index.html.erb'
    end

    template '/etc/nginx/conf.d/default.conf' do  # custom configuration
        source 'default.conf.erb'
    end

when 'windows'
    node.default['webserver'] = "IIS"

    windows_feature ['TelnetClient'] do
        action :install
    end

    windows_package "Notepad++" do
        source 'https://notepad-plus-plus.org/repository/7.x/7.6.3/npp.7.6.3.Installer.x64.exe'
        #source 'C:tmpnpp.6.5.3.Installer.exe'
        action :install
    end

#    %w{IIS-WebServerRole IIS-WebServer}.each do |feature|
#        windows_feature feature do
#            action :install
#    #        install_method :windows_feature_powershell
#        end
#    end

    iis_install 'install IIS' do
        additional_components node['iis']['components']
        source node['iis']['source']
    end

    service 'iis' do
        service_name 'W3SVC'
        action [:enable, :start]
    end

    template 'c:/inetpub/wwwroot/index.htm' do  # custom content
        source 'index.html.erb'
    end
end
