#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
docker_service 'default' do
  action [:create, :start]
end

docker_image 'busybox' do
  action :pull
end

docker_container 'an-echo-server' do
  repo 'busybox'
  port '1234:1234'
  command "nc -ll -p 1234 -e /bin/cat"
end
