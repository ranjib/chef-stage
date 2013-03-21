site :opscode

metadata

group :dev do
  cookbook 'git'
end

group :integration do
  cookbook "minitest-handler"
  cookbook "stage_test", :path => "./test/cookbooks/stage_test"
end
