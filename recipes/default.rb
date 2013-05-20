#
# Cookbook Name:: hadoop-BAM-cookbook
# Recipe:: default
#

#include_recipe "hadoop"

package "curl" do
  action :install
end

#Create temporary directory for the installation
directory node['tmp'] do
    mode 0755
    recursive true
end.run_action(:create)

#Download the latest release of hadoop-BAM.
execute "Downloding latest Hadoop-BAM release from SourceForge" do
    cwd "#{node['tmp']}"
    command "curl -O -J -L #{node['hadoop-BAM-release']} && tar xvzf * && rm *gz"
    action :nothing
end.run_action(:run)

hadoop_bam = %x( ls #{node['tmp']} ).strip

execute "Moving hadoop-BAM to the installation directory" do
    command "cp -r  #{node['tmp']}/#{hadoop_bam} #{node['install_dir']}"
end

#Add the variable HADOOP_BAM to bashrc
ruby_block "edit-bashrc" do
  block do
    file = Chef::Util::FileEdit.new("#{ENV['HOME']}/.bashrc")
    file.insert_line_if_no_match("HADOOP_BAM", "HADOOP_BAM=#{node['install_dir']}/#{hadoop_bam}")
    file.write_file
  end
end
