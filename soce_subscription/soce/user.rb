require 'active_record'

module Soce
  class User < ActiveRecord::Base
    establish_connection ENV['SOCE_DATABASE_URL']

    self.table_name = "users"

    def is_amm_subscriber
      type_abt.to_i > 0
    end

    def subscription_type
      case type_abt
        when 0
          {
              subscription_type_id: type_abt,
              subscription_type_label: 'not_subscriber'
          }
        when 1
          {
              subscription_type_id: type_abt,
              subscription_type_label: 'free_subscriber'
          }
        when 2
          {
              subscription_type_id: type_abt,
              subscription_type_label: 'standard_subscriber'
          }
        when 3
          {
              subscription_type_id: type_abt,
              subscription_type_label: 'discounted_subscriber'
          }
        else
          {
            subscription_type_id: type_abt,
            subscription_type_label: 'unknown'
          }
      end
    end

    def subscription_hash
      hash={
          uuid: uuid,
          id_soce: id_user,
          is_subscriber: is_amm_subscriber,
          firstname: prenom,
          lastname: nom,
          email: email
      }
      if is_amm_subscriber
        hash[:subscription_type]=subscription_type
        hash[:subscription_ending]=fin_abt
      end
      hash
    end

  end
end

