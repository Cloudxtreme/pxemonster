require_relative 'spec_helper'
require_relative '../lib/host_configs.rb'



describe 'HostConfigs' do

  before do
  	@pxe_dir = Pathname.new(File.dirname(File.expand_path(__FILE__))).join('pxelinux.cfg')
  end

  describe '#initialize' do
    
    it 'it should only load .yaml and .yml files that have all the proper fields from the config dir passed' do
     h = HostConfigs.new(@pxe_dir)
     
     # It should only load 2 files and discard all the others.
     h.should == {          
     	"10.0.0.2" => {
			"ip"=>"10.0.0.2",
			"host_name"=>"host1.somewhere.net",
			"mac"=>"6a:00:01:84:5e:30",
			"pxe_template"=>"ubuntu_1404.erb"},
 		"10.0.0.3" => {
			"ip"=>"10.0.0.3",
			"host_name"=>"host2.somewhere.net",
			"mac"=>"6a:00:01:84:5e:31",
			"pxe_template"=>"ubuntu_1404.erb"}
		}
   end


  end

end
