require_relative 'spec_helper'
require_relative '../lib/pxe_file.rb'



describe 'PxeFile' do

  before do
  	@pxe_dir = Pathname.new(File.dirname(File.expand_path(__FILE__))).join('pxelinux.cfg')
    @host_info =  {
                    "ip"=>"10.0.0.2",
                    "pxe_template"=>"ubuntu_1404.erb",
                    "kickstart_url"=>"http://192.168.1.1/ubuntu_1404/ubuntu.ks",
                    "pxe_file_name"=>"0A000002",
                    "pxe_file_exists"=>true
                  }
  end

  describe '#initialize' do
    
   it 'it should store the host info passed to it' do
    @host_info
    pf = PxeFile.new(@host_info)
    pf.host_info.should == @host_info
   end

  end

  describe '#write' do
    #TODO: Write these tests


  end

end
