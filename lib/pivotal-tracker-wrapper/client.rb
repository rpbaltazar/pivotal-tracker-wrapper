module PivotalTracker
  class Client
    class NoToken < StandardError; end

    class << self
      attr_writer :use_ssl, :token, :tracker_host, :name

      def use_ssl
        @use_ssl || true
      end

      def token(username, password, method='get')
        # https://username:password@www.pivotaltracker.com/services/v5/me
        response = RestClient.get "#{api_ssl_url(username, password)}/me"
        #TODO: add post method
        begin
          parsedBody = JSON.parse(response.body)
          @token = parsedBody['api_token']
          @name = parsedBody['name']
        rescue Exception => e
          p e.inspect
          @token = nil
          @name = nil
        end
      end

      # this is your connection for the entire module
      def connection(options={})
        raise NoToken if @token.to_s.empty?

        @connections ||= {}

        cached_connection? && !protocol_changed? ? cached_connection : new_connection
      end

      def clear_connections
        @connections = nil
      end

      def tracker_host
        @tracker_host ||= "www.pivotaltracker.com"
      end

      def api_ssl_url(user=nil, password=nil)
        user_password = (user && password) ? "#{user}:#{password}@" : ''
        "https://#{user_password}#{tracker_host}#{api_path}"
      end

      protected

      def protocol
        use_ssl ? 'https' : 'http'
      end

      def cached_connection?
        !@connections[@token].nil?
      end

      def cached_connection
        @connections[@token]
      end

      def new_connection
        @connections[@token] = RestClient::Resource.new("#{api_ssl_url}", :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/json' })
      end

      def protocol_changed?
        cached_connection? ? (cached_connection_protocol != protocol) : false
      end

      def cached_connection_protocol
        cached_connection.url.match(/^(.*):\/\//).captures.first
      end

      def api_path
        '/services/v5'
      end
    end
  end
end
