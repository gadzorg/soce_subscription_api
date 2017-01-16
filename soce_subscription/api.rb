require 'grape'

module SoceSubscription
  class API < Grape::API
    format :json
    prefix :api

    http_basic do |user, password|
      user == ENV['SOCE_API_USER'] && ENV['SOCE_API_PASSWORD']
    end

    resource :subscription_status do

      desc 'Return subscription status of given user '
      params do
        requires :uuid, type: String , desc: 'user uuid.'
      end
      route_param :uuid do
        get do
          { hello: 'world' }
        end
      end
    end

  end
end