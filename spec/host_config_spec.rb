require_relative 'spec_helper'
require_relative '../lib/host_configs.rb'


describe 'HostConfigs' do

  before do
  	@pxe_dir = Pathname.new(File.dirname(File.expand_path(__FILE__))).join('pxelinux.cfg')
  end

  describe '#initialize' do
    it 'it should only load .yaml and .yml files that have all the proper fields from the config dir passed' do
     h = HostConfigs.new(@pxe_dir)
     pp h
    end


  end
end
