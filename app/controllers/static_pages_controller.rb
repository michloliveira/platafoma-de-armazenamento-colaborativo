require 'jwt'

class StaticPagesController < ApplicationController

    def index
        puts(ENV['DEVISE_SECRET_KEY'])
        puts(jwt.dispatch_requests)
    end
end
