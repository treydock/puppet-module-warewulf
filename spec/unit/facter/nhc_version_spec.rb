require 'spec_helper'

describe 'nhc_version fact' do

  before :each do
    Facter.clear
    Facter.fact(:osfamily).stubs(:value).returns("RedHat")
  end

  it "should return 1.4.1" do
    Facter::Util::Resolution.stubs(:exec).with("rpm -q --queryformat '%{NAME}-%{VERSION}' warewulf-nhc").returns("warewulf-nhc-1.4.1")
    Facter.fact(:nhc_version).value.should == "1.4.1"
  end

  it "should handle package not installed" do
    Facter::Util::Resolution.stubs(:exec).with("rpm -q --queryformat '%{NAME}-%{VERSION}' warewulf-nhc").returns("package warewulf-nhc is not installed\n")
    Facter.fact(:nhc_version).value.should == nil
  end
end
