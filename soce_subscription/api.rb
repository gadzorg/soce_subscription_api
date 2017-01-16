require 'grape'

module SoceSubscription
  class API < Grape::API
    format :json
    prefix :api

    get :hello do
      { hello: 'world' }
    end

  end
end