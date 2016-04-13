# -*- encoding: utf-8 -*-
Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb").each { |file| require_relative file }

require 'json'
require 'sinatra'

class PxeMonster < Sinatra::Base

  configure do
    set :reload_templates, true   
    set :show_exceptions,  false 
    set :raise_errors,     false 
    set :dump_errors,      true  
    set :logging,          true   
  end


  set :client_headers,  { "Content-Type" => "application/json"}

  delete '/pxe' do
    request_ip = params.fetch('spoof', request.ip)
    [200, settings.client_headers, PXELinux.new.delete(request_ip).to_json]
  end


  post '/pxe/?' do
    request_ip = params.fetch('spoof', request.ip)
    [200, settings.client_headers, PXELinux.new.create(request_ip).to_json]
  end


  get '/pxe?' do
  	request_ip = params.fetch('spoof', request.ip)
    [200, settings.client_headers, PXELinux.new.get(request_ip).to_json]
  end


  error NoConfigFoundForIp do
    error = env['sinatra.error']
    response = {"error" => error.message, "type"  => error.class.name }
    [404, settings.client_headers, response.to_json]
  end


  error StandardError do
    error = env['sinatra.error']
    response = {"error" => error.message, "type"  => error.class.name }
    [500, settings.client_headers, response.to_json]
  end
end