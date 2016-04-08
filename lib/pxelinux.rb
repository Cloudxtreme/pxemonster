class PXELinux 

	def initialize()
		@host_configs = HostConfigs.new
	end


	def get_host_info(ip)
		@host_configs[ip]
	end

end