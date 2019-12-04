execute "Build jenkins_slave" do
  command "cd ~/chef-repo/jenkins_slave/Docker && docker build -t jenkins_slave ."
  action :run
end
execute "Run jenkins_slave container" do
  command 'docker run -d --name jenkins_ssh_slave jenkins_slave "$(cat ~/jenkins_volume/.ssh/id_rsa.pub)" || docker start jenkins_ssh_slave'
  action :run
end
