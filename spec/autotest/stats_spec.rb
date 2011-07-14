require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AutotestStats" do
  it "should add hooks to autotest" do 
    Autotest.should_receive(:add_hook).with(:initialize)
    Autotest.should_receive(:add_hook).with(:red)
    Autotest.should_receive(:add_hook).with(:green)
    require File.expand_path(File.dirname(__FILE__)+'/../../lib/autotest/stats')
  end
  describe "after init" do
    include Autotest::Stats
    before(:each) do
      init_hook
    end
    it "should track the number of red/green cycles" do
      @cycles.should == 0
      red_hook
      green_hook
      @cycles.should == 1

    end

    it "should not treat 2 green as a cycle" do
      @cycles.should == 0
      2.times do
        green_hook
      end
      @cycles.should == 0
    end

  end
end
