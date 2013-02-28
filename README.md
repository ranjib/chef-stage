
Description
====

 _stage_ facilitates multi stage chef runs

Requirements
====

Debian, Ubuntu, CentOS, Red Hat, Scientific, Fedora, SUSE, Amazon, GCEL.


Usage
====
include the "stage" recipe to use the lwrp. this recipe provides a default resource name "stage". 
__stage__ resource can take four options, __run_list__ which is simlar to node run list and can be
a comma separated string of recipes and roles. the other option __save__ is a boolean, which dictates
whether the attributes from the run list will be saved or merged against the current node or not, __save__
is true by default. __stage__ resource right now supports only _:run_ action. Stage reasource is idempotent
and can be used to notify other resources (assuming the resources invoked by the run list attribute are 
idempotent).

the options __json_attributes__ and __args__ can be used to pass additional json attributes and arguments
to the sub chef runs.

__stage__ resources can also 


    include_recipe "stage"

    stage "first" do
      run_list "recipe[foo]"
    end

    stage "second" do
      run_list "recipe[bar]"
    end

    stage "third" do
      run_list "recipe[baz]"
      save false # attributes from baz wont be merged against the node
    end


License and Author
====

Author:: Ranjib Dey (<dey.ranjib@gmail.com>)
Copyright:: 2013, Ranjib Dey

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations License.

