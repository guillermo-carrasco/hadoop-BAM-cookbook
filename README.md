##Description
This is a chef recipe to install [Hadoop-BAM](http://sourceforge.net/projects/hadoop-bam/)

#Requirements
* [Java cookbook](https://github.com/opscode-cookbooks/java)
* [Hadoop cookbook](http://github.com/guillermo-carrasco/cloudera-hadoop)
* [Git cookbook](https://github.com/opscode-cookbooks/git)

__You can also procure this requirements by your own and remove the dependencies
from the recipe.__

##Recipes
* **default** - Install latest stable release
* **latest_code** - Install Hadoop-BAM from its latest source code

##Attributes
* default['hadoop-BAM-release']: SourceForge download page of Hadoop-BAM
* default['hadoop-BAM-latest-code']: Hadoop-BAM githup repository
* default['tmp']: Temporal directory for the installation
* default['install\_dir']: Installation directory


##Usage
Depending on how you have Chef installed, you'll use this recipe in one way or another. Here I describe
how to run this recipe with chef-solo.

###Prepare the environment
First, create a folder ```cookbooks``` where you'll put all your cookbooks. Clone this repository and its
requirements there.

###Custom your installation
Edit the attributes of the recipe you're going to use at your convinience.

###Run chef
If you haven't done it already, create these two files:

solo.rb
```
file_cache_path "/tmp/chef-solo"
cookbook_path "<path to your cookbook folder>" (i.e /home/guillermo/cookbooks)
```
node.json
```
{
    "run_list": ["recipe[hadoop-BAM]"]
}
```

And run chef-solo
```
sudo chef-solo -c solo.rb -j node.json
```

##Tested on
Ubuntu 12.04

Shoud work on most linux distributions.

##Collaborations
Please feel free of pull-request, open issues, and comment anything you want :-)
