module Routes
  class Base < Roda
    DEFAULT_HEADERS = {
      RodaResponseHeaders::CONTENT_TYPE => 'application/json'
    }

    plugin :head
    plugin :default_headers, RodaResponseHeaders::CONTENT_TYPE => 'application/json'
    plugin :json, classes: [Array, Hash], content_type: 'application/json'
    plugin :json_parser
    plugin :all_verbs
  end
end
