#
# Cookbook Name:: hadoop-BAM-cookbook
#


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
    command "curl -O -J -L #{node['hadoop-BAM-release-jar']} && tar xvzf * && rm *gz"
    action :nothing
end.run_action(:run)

hadoop_bam = %x( ls #{node['tmp']} ).strip

execute "Moving hadoop-BAM to the installation directory" do
    command "cp -r  #{node['tmp']}/#{hadoop_bam} #{node['install_dir']}"
end

#Create a file in /etc/profile.d to export HADOOP_BAM variable
hadoop_home = { :value => "#{node['install_dir']}/#{hadoop_bam}" }
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
    ENV['HADOOP_BAM'] = "#{node['install_dir']}/#{hadoop_bam}"
  end
end
