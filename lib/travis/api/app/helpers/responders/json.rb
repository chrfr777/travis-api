module Travis::Api::App::Helpers::Responders
  class Json < Base
    ACCEPT_VERSION  = /vnd\.travis-ci\.(\d+)\+/
    DEFAULT_VERSION = 'v1'

    def render
      options[:version] ||= version
      builder  = Travis::Api.builder(resource, options) # || raise("could not determine a builder for #{resource}, #{options}")

      resource = builder.new(self.resource, request.params).data if builder
      resource = resource.to_json unless resource.is_a?(String)
      resource
    end

    private

      def version
        request.accept.join =~ ACCEPT_VERSION && "v#{$1}" || DEFAULT_VERSION
      end
  end
end
