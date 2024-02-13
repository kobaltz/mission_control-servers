module MissionControl
  module Servers
    class RequestTallyMiddleware
      @@tally = Hash.new(0)

      def initialize(app)
        @app = app
        @hostname = if ENV["KAMAL_VERSION"].present?
          Socket.gethostname.to_s.split("-").first
        else
          ENV.fetch('HOSTNAME', Socket.gethostname)
        end
      end

      def call(env)
        req = Rack::Request.new(env)
        if ingress_request?(req)
          req.update_param('tally', @@tally.clone.merge('hostname' => @hostname))
          @@tally.clear
        end

        status, headers, response = @app.call(env)

        if !ingress_request?(req)
          category = categorize_status(status)
          update_tally(category)
        end

        [status, headers, response]
      end

      private

      def ingress_request?(req)
        req.post? && req.path.match?(/^\/[^\/]+\/projects\/[^\/]+\/ingress$/)
      end

      def update_tally(category)
        @@tally[category] += 1
      end

      def categorize_status(status)
        case status
        when 200..299 then 'sum_2xx'
        when 300..399 then 'sum_3xx'
        when 400..499 then 'sum_4xx'
        when 500..599 then 'sum_5xx'
        else 'unknown'
        end
      end
    end
  end
end
