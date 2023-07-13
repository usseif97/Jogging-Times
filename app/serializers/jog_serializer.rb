class JogSerializer
  include JSONAPI::Serializer
  attributes :date, :distance, :time
end
