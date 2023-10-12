class Base < Roda
  plugin :head
  plugin :json, classes: [Array, Hash], content_type: 'application/json'
  plugin :json_parser
  plugin :all_verbs
end
