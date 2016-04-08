
require 'pathname'
require 'yaml'


class HostConfigs  < Hash

	def initialize(path = '/pxelinxu.cfg') 
 
 		config_dir = Pathname.new(path)
 		return unless config_dir.exist?

		config_dir.each_child(false) {|f| 
			next unless f.extname == '.yml' or f.extname == '.yaml'
			
			cf = config_dir.join(f)
			data = YAML::load_file(cf) #rescue nil
			next if data.nil?

			next unless data['ip'] 
			next unless data['host_name'] 
			next unless data['mac']

			data['data_file'] = cf
			self[data['ip']]  = data
		}
	end
end
 
