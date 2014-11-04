#
# Cookbook Name:: ebolabigdata  full stack install
# Recipe:: default
#
# Copyright 2014, ebolabigdata
#
# All rights reserved - MIT liecense
#


script "install_r" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  sudo apt-get update
  sudo apt-get install -y software-properties-common python-software-properties
  sudo add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu precise/"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
  sudo add-apt-repository -y ppa:marutter/rdev
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get update
  sudo apt-get install -y r-base r-base-dev 
  EOH
end

script "install_system_libraray_shiny" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  sudo apt-get install -y gdebi-core
  sudo apt-get install -y libapparmor1
  sudo R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\"
  wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.2.1.362-amd64.deb
  sudo gdebi -n shiny-server-1.2.1.362-amd64.deb
  EOH
end

remote_directory "/srv/shiny-server" do
  files_mode "0755"
  mode "0755"
  owner "root"
  group "root"
  mode 0755
  owner "root"
  source "website"
  action :create
end


remote_directory "/chefrepo/" do
  files_mode "0755"
  mode "0755"
  owner "root"
  group "root"
  mode 0755
  owner "root"
  source "chefrepo"
  action :create
end

package 'nginx' do
  action :install
end

template "/etc/nginx/nginx.conf" do
  mode "0644"
  source "nginx.conf.erb"
end

template "/etc/nginx/sites-available/default" do
  mode "0644"
  source "default.erb"
end

template "/etc/nginx/sites-enabled/default" do
  mode "0644"
  source "default.erb"
end

script "nginx_passwd_Secure" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /usr/local/bin
  wget http://trac.edgewall.org/export/10791/trunk/contrib/htpasswd.py
  chmod 755 /usr/local/bin/htpasswd.py
  sudo htpasswd.py -c -b /etc/nginx/sites-available/.htpasswd viki ruhil
  sudo service nginx restart
  EOH
end

script "Install_jslint" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  sudo add-apt-repository ppa:chris-lea/node.js
  sudo apt-get update
  sudo apt-get install -y nodejs
  sudo apt-get install -y npm
  sudo npm install -g jslint 
  EOH
end

 script "Install_gemdigitalocean" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  sudo /opt/chef/embedded/bin/gem install knife-digital_ocean
  cd /chefrepo/
  knife digital_ocean droplet list > list.txt
  EOH
end

script "statitc_analysis_start" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /srv/shiny-server/js/
  echo "###############STATIC CODE ANALYSIS Started for 'PWD' ####################################"
  jslint --white --vars --regexp  --color test.js > test_lint.txt
  sleep 3
  jslint --white --vars --regexp  --color test_pass.js > test_pass_lint.txt
  sleep 3
  jslint --white --vars --regexp  --color agency.js >> ageney_lint.txt
  sleep 3
  jslint --white --vars --regexp  --color contact_me.js >> contact_me_lint.txt
  sleep 3
  jslint --strict --white  --color cbpAnimatedHeader.min.js >> cbp_lint.txt
  echo "########################## Done with STATIC ANALYSIS ########################################"
  EOH
end



service 'nginx' do
  action [ :enable, :start ]
end

