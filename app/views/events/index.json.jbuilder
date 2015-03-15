json.array!(@events) do |event|
  json.extract! event, :id, :name, :year, :term, :date, :location, :time
  json.url event_url(event, format: :json)
end
