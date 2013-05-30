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

#Add the variable HADOOP_BAM to bashrc
ruby_block "edit-bashrc" do
  block do
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bashrc")
    file.insert_line_if_no_match("HADOOP_BAM", "HADOOP_BAM=#{node['install_dir']}/hadoop-BAM")
    file.write_file
  end
end
