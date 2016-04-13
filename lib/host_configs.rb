
require 'pathname'
require 'ipaddress'
require 'yaml'


class HostConfigs  < Hash

	attr_reader :config_dir

	def initialize(path = '/pxelinux.cfg') 
 
 		@config_dir = Pathname.new(path)
 		return unless config_dir.exist?

 		data = YAML::load_file(config_dir.join('pxemonster.yml'))
 		data.each do |h|
 		    unless h['ip']  
 		      STDERR.puts "Warning section of pxemonister.yml skipped becuase no ip was set. #{h.inspect}"
 		      next
 		    end

 			# Using the ip address as hex for the boot file.  
 			# See: http://www.syslinux.org/wiki/index.php?title=PXELINUX#Configuration
			h['pxe_file_name']   = IPAddress::IPv4.new(h['ip']).to_hex.upcase
			h['pxe_file_exists'] = config_dir.join(h['pxe_file_name']).exist?
			self[h['ip']] = h
 		end
	end
end
 
