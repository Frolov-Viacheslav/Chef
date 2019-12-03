current_dir = File.dirname(__FILE__)
log_level :info
log_location STDOUT
node_name 'slava_frolov777'
client_key 'chef.pem'
validation_client_name 'chef-on-ubuntu-validator'
validation_key 'chef-on-ubuntu.pem'
chef_server_url 'https://chef-server.us-west2-a.c.poised-time-251617.internal/organizations/chef-on-ubuntu'
cache_type 'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path ["#{current_dir}/../cookbooks"]
