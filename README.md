# Chef
Задание:  
1. Поднять Chef-server (поковырять, разобраться как с ним работать)  
2. Написать cookbook, который устанавливает Jenkins (только без chef supermarket'a) - требования к cookbook'y такие же как и для Ansible (data_bags, templates, environment)
# How to configure chef-server, chef-workstation, chef-node  
### Chef-server configuration
1. Download the latest Chef server:  
`wget https://packages.chef.io/files/stable/chef-server/12.18.14/ubuntu/18.04/chef-server-core_12.18.14-1_amd64.deb` 
2. Install the Chef server package  
`dpkg -i chef-server-core_*.deb`  
3. Start the Chef server services  
`chef-server-ctl reconfigure` 
4. Check Chef server services  
`chef-server-ctl status`
5. Create a .chef directory  
`mkdir .chef`  
6. Use chef-server-ctl to create a user  
`chef-server-ctl user-create slava_frolov777 Slava Frolov Viacheslav_Frolov@epam.com '123' --filename ~/.chef/chef.pem`  
7. View list of Chef-server users  
`chef-server-ctl user-list`  
8. Create an organization and add the user   
`sudo chef-server-ctl org-create chef-on-ubuntu "Chef Infrastructure on Ubuntu 18.04" --association_user slava_frolov777 --filename ~/.chef/chef-on-ubuntu.pem`  
9. View list of Chef-server organization  
`chef-server-ctl org-list`  
10. Generate ssh-keys  (optional)
`ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa`  
### Chef-workstation configuration  
1. Download the latest Chef-Workstation  
`wget  https://packages.chef.io/files/stable/chef-workstation/0.2.43/ubuntu/18.04/chef-workstation_0.2.43-1_amd64.deb`  
2. Install Chef Workstation  
`dpkg -i chef-workstation_*.deb`  
3. Create the Chef repository  
`chef generate repo chef-repo` 
4. Create a .chef subdirectory  
`mkdir ~/chef-repo/.chef`  
5. Generate ssh-keys  (optional)  
`ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa`  
6. Copy ssh public key  
`cat ~/.ssh/id_rsa.pub`  
7. Paste Chef-Workstation ssh public key to Chef-Server authorized_keys  
`echo "SSH_PUBLIC_KEY" >> ~/.ssh/authorized_keys`  
8. Copy the .pem files from Chef-Server to  Chef-Workstation  
`scp slava_frolov@CHEF_SERVER_IP:~/.chef/*.pem ~/chef-repo/.chef/`  
9. Generate a new Chef cookbook  
`chef generate cookbook chef-first-cookbook`  
10. Generate the chef-repo  
`chef generate app chef-repo`  
### Knife and Chef-Node configuration  
1. Create a knife configuration file  
`echo "current_dir = File.dirname(__FILE__)`  
`log_level                :info`  
`log_location             STDOUT`  
`node_name                'slava_frolov777'`  
`client_key               'chef.pem'`  
`validation_client_name   'chef-on-ubuntu-validator'`  
`validation_key           'chef-on-ubuntu.pem'`  
`chef_server_url          'https://CHEF_SERVER_IP/organizations/chef-on-ubuntu'`  
`cache_type               'BasicFile'`  
`cache_options( :path => \"#{ENV['HOME']}/.chef/checksums\" )`  
`cookbook_path            [\"#{current_dir}/../cookbooks\"]" > ~/chef-repo/.chef/config.rb`   
2. Copy the user and organithation SSL certificates from the Chef-Server  
`cd ~/chef-repo && knife ssl fetch`  
3. View the client list  
`knife client list`  
4. Add node to hosts list  
`echo "172.17.0.2 chef-client" >> /etc/hosts`  
5. Bootstrap the client node  
`cd ~/chef-repo/.chef && knife bootstrap chef-client -x root --node-name chef-client-node`  
6. Check bootstraping of node  
`knife node show chef-client-node`  
### Create cookbook  and implemented it on Chef-Client
1. Generate cookbook  
`cd chef-repo/cookbooks && chef generate cookbook jenkins`  
2. Edit cookbook metadata  
`cd jenkins && nano metadata.rb`  
3. Edit cookbook recipes    
`cd recipes && nano default.rb`   
4. Upload cookbook to Chef-Server  
`knife cookbook upload jenkins`  
5. Add the recipe to node’s run list  
`knife node run_list add chef-client-node "recipe[jenkins]"`  
6. Connect to Chef-Client via ssh  
`ssh root@chef-client`  
7. Run chef-client command  
`chef-client`  

