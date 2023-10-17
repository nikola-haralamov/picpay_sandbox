require_relative 'base.rb'

module Routes
  class Auth < Base

    # ALGORITHM = 'HS256'

    route do |r|
      @accounts = DB.new('accounts')

      r.post do
        #exp = Time.now.to_i + 4 * 3600
        payload = JSON.parse(request.body.read, symbolize_names: true)

        access_token_record = {}
        refresh_token_record = {}

        if payload[:grand_type] == 'client_credentials'
          access_token_id = SecureRandom.uuid
          access_token_record = {
            grant_type: payload[:grant_type],
            scope: payload[:scope],
            client_id: payload[:client_id],
            client_secret: payload[:client_secret],
          }

          access_token = ::Auth::encode(access_token_record)
          access_token_record.merge!({ access_token: access_token, expires_in: 300, token_type: 'bearer' })

          return { error: 'Something was wrong.' } unless @accounts.create(access_token_id, access_token_record)

        elsif payload[:grand_type] == 'refresh_token'
          refresh_token_id = SecureRandom.uuid
          refresh_token_record = {
            grant_type: payload[:grant_type],
            client_id: payload[:client_id],
            client_secret: payload[:client_secret],
            refresh_token: payload[:client_secret],
          }
          refresh_token = ::Auth::encode(refresh_token_record)
          refresh_token_record.merge!({ refresh_token: refresh_token, refresh_expires_in: 1800, token_type: 'bearer' })

          return { error: 'Something was wrong.' } unless @accounts.create(refresh_token_id, refresh_token_record)
        end

        {}.merge(access_token_record, refresh_token_record)
      end
    end


    # private
    #
    # def encode(payload)
    #   JWT.encode(payload, auth_secret, ALGORITHM)
    # end
    #
    # def decode(token)
    #   JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
    # end
    #
    # def auth_secret
    #   ENV['AUTH_SECRET']
    # end

  end
end
