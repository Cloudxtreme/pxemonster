# -*- encoding: utf-8 -*-
Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb").each { |file| require_relative file }
require 'json'
require 'pathname'
require 'sinatra'

class PxeMonster < Sinatra::Base

  set :client_headers,  { "Content-Type" => "application/json"}
  set :pxe, PXELinux.new


  delete '/pxe' do
    'Hi tony.  This is Awesome'
  end

  get '/pxe?' do
request_ip = params.fetch()
    [200, settings.client_headers, settings.pxe.get_host(request.ip).to_json]
  end
end