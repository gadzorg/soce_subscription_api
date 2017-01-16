$:.unshift File.dirname(__FILE__)

require 'grape'
require 'grape-swagger'
require 'soce/user'

module SoceSubscription
  class API < Grape::API
    format :json
    prefix :api


    resource :subscription_status do
      http_basic do |user, password|
        user == ENV['SOCE_API_USER'] && ENV['SOCE_API_PASSWORD']
      end

      desc 'Return subscription status of given user '
      params do
        requires :uuid, type: String , desc: 'user uuid.'
      end
      route_param :uuid do
        get do
          user=Soce::User.find_by(uuid:  params[:uuid])
          if user
            user.subscription_hash
          else
            error! :not_found, 404
          end
        end
      end
    end

    add_swagger_documentation mount_path: '/doc'

  end
end