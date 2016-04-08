class PXELinux {

	def initialize(){
		@host_configs = HostConfigs.new
	}


	def get_host_info(ip){
		h = @host_configs.select { |h| h['ip'] == ip}
		h
	}

}