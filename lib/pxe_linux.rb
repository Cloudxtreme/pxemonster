require_relative 'host_configs'
require_relative 'pxe_file' 

require 'pathname'
require 'pp'


class PXELinux 

	def initialize()
		@host_configs = HostConfigs.new
	end


	def get(ip)
		info = @host_configs[ip]
		puts "get: the host confis is #{@host_configs}"
		puts "get: info = #{info}"
		raise NoConfigFoundForIp.new(ip) if info.nil?
		info
	end

	def create(ip)
		info = get(ip)
		pxe_file = PxeFile.new(info)
		pxe_file.write(@host_configs.config_dir)
		info["pxe_file_exists"] = true
		info
	end

	def delete(ip)
	
		info = @host_configs[ip.to_s]
		puts "delete: the host confis is #{@host_configs}"
		puts "delete: info = #{info}" 
		raise NoConfigFoundForIp.new(ip) if info.nil?
		pxe_file = @host_configs.config_dir.join(info["pxe_file_name"])
		pxe_file.delete unless pxe_file.exist?
		info["pxe_file_exists"] = false
		info
	end

end

class NoConfigFoundForIp < StandardError
	def initialize(ip)
	  super("No configuration was found in pxemonster.yml for the ip #{ip}")
	end
end
