require 'pathname'
require 'erb'

class PxeFile

attr_reader :host_info

	def initialize(host_info) 
		@host_info = host_info
	end

	def write(path)
		pxe_folder = Pathname.new(path) 
		raise StandardError, "PXE folder path (#{path}) not found." unless pxe_folder.exist?

		pxe_template = pxe_folder.join(@host_info['pxe_template'])
		raise StandardError, "pxe_template not found for #{@host_info}" unless pxe_template.exist?
	
		template = ERB.new(pxe_template.read)
		pxe_folder.join(host_info['pxe_file_name']).write(template.result(binding))
		puts "Wrote File: #{pxe_folder.join(host_info['pxe_file_name'])}"
	end

end
