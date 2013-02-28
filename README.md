Description
====
 _stage_ facilitates multi stage chef runs

Requirements
====

Debian, Ubuntu, CentOS, Red Hat, Scientific, Fedora, SUSE, Amazon, GCEL.


Usage
====
```ruby
include_recipe "stage"

stage "first" do
  run_list "recipe[foo]"
end

stage "second" do
  run_list "recipe[bar]"
end
```


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

