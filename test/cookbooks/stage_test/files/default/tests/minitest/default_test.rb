

describe_recipe "stage_test::default" do
  it "should install the facter gem" do
    require 'facter'
    Facter.version.wont_be_nil
  end
end
