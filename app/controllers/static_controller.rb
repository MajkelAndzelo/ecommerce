class StaticController < ApplicationController
    def bootstrap
      send_file "#{Rails.root}/public/bootstrap.css", type: 'text/css', disposition: 'inline'
    end
end
  