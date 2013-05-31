#
# Cookbook Name:: hadoop-BAM-cookbook
# Recipe:: default
#

include_recipe "hadoop"
include_recipe "git"

#Checkot Hdoop-BAM from Git
git "Checking out hadoop-BAM code" do
    repository  "#{node['hadoop-BAM-latest-code']}"
    action :sync
    destination "#{node['install_dir']}/hadoop-BAM"
end

#Compile Hadoop-BAM. Requires java SDK!
execute "Compiling hadoop-BAM" do
    command "cd #{node['install_dir']}/hadoop-BAM && ant"
    action :run
end

#Create a file in /etc/profile.d to export HADOOP_BAM variable
hadoop_home = { :value => "#{node['install_dir']}/hadoop-BAM" }
template '/etc/profile.d/hadoop_bam.sh' do
    source 'hadoop_bam.erb'
    mode 0644
    owner "root"
    group "root"
    action :create
    variables hadoop_home
end

#Set the environment variable for this provess
ruby_block "Setting HADOOP_BAM environment variable" do
  block do
    ENV['HADOOP_BAM'] = "#{node['install_dir']}/hadoop-BAM"
  end
end
