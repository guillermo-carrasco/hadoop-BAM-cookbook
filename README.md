##Description
This is a chef recipe to install [Hadoop-BAM](http://sourceforge.net/projects/hadoop-bam/)

#Requirements
* [Hadoop cookbook](http://github.com/guillermo-carrasco/cloudera-hadoop) (which also installs
[Java cookbook](https://github.com/opscode-cookbooks/java))
* [Git cookbook](https://github.com/opscode-cookbooks/git)

_You can also prvide this requirements by your own and remove the dependencies
from the recipe. Keep in mind that you need Java SDK and ant_

##Recipes
* **default** - Install from source code
* **precompiled** - Install Hadoop-BAM from its latest precompiled jar

##Attributes
* default['hadoop-BAM-release-jar']: Download page for Hadoop-BAM jar
* default['hadoop-BAM-repo']: Hadoop-BAM git repository
* default['hadoop-BAM-version']: a source code revision (a tag, a branch or a commit)
* default['tmp']: Temporal directory for the installation
* default['install\_dir']: Installation directory


##Usage
Depending on how you have Chef installed, you'll use this recipe in one way or another. Here I describe
how to run this recipe with chef-solo.

###Prepare the environment
First, create a folder ```cookbooks``` where you'll put all your cookbooks. Clone this repository and its
requirements there. You can clone my [cookbooks](http://github.com/guillermo-carrasco/cookbooks.git) repository
with:

		git clone --recursive http://github.com/guillermo-carrasco/cookbooks.git

to pull all the cookbooks at once.

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
    "run_list": ["recipe[hadoop-BAM-cookbook]"]
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
