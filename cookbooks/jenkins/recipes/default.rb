#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

execute "install openjdk-8" do
  command "apt-get update && apt install -y openjdk-8-jdk"
  action :run
end
package "wget" do
  action :install
end
package "gnupg" do
  action :install
end
execute "download Jenkins repository" do
  command "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -"
  action :run
end
execute "download jenkins package" do
  command "sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'"
  action :run
end
execute "Update repository" do
  command "apt-get update"
  action :run
end
package "jenkins" do
  action :install
end
service "jenkins" do
  action [:start, :enable]
end
package "git" do
  action :install
end
