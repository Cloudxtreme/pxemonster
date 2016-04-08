# -*- encoding: utf-8 -*-
Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb").each { |file| require_relative file }
require 'json'
require 'pathname'
require 'sinatra'

class PxeMonster < Sinatra::Base

  set :client_headers,  { "Content-Type" => "application/json"}



  delete '/pxe' do
    'Hi tony.  This is Awesome'
  end

  get '/pxe?' do
	request_ip = params.fetch('spoof', request.ip)
	d = PXELinux.new.get_host_info(request_ip)
	return [404, settings.client_headers, {:error => "No PXE data for #{request_ip}"}.to_json] if d.nil?
    [200, settings.client_headers, d.to_json]
  end
end