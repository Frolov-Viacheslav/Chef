execute "Build jenkins_master image" do
  command "cd ~/chef-repo/jenkins_master/Docker && docker build -t jenkins_master ."
  action :run
end
execute "Create volume for jenkins_master" do
  command "docker volume create -d local-persist -o mountpoint=~/jenkins_volume --name=jenkins"
  action :run
end
execute "Run jenkins_master container" do
  command 'docker run -d -t -p 8080:8080 -p 2222:22 -p 50000:50000 --env "HOST_KEY=$(cat ~/.ssh/id_rsa.pub)" --name jenkins --mount source=jenkins,target=/var/lib/jenkins/ jenkins_master || docker start jenkins'
  action :run
end
execute "knife delete old node" do
  command "cd ~/chef-repo && knife node delete chef-client-node -y || true"
  action :run
end
execute "knife delete lod client" do
  command "cd ~/chef-repo && knife client delete chef-client-node -y || true"
  action :run
end
execute "Bootstrap jenkins_master container" do
  command "cd ~/chef-repo && knife bootstrap chef-client -x root --node-name chef-client-node"
  action :run
end
execute "Add recipe[jenkins] to jenkins_master container" do
  command 'cd ~/chef-repo && knife node run_list add chef-client-node "recipe[jenkins]"'
  action :run
end
