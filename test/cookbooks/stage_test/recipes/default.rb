include_recipe "stage"

stage "install a gem" do
  run_list "recipe[stage_test::prerequisite]"
end

stage "use the gem" do
  run_list  "recipe[stage_test::test]"
end
