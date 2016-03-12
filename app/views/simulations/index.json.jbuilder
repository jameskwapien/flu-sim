json.array!(@simulations) do |simulation|
  json.extract! simulation, :id, :input
  json.url simulation_url(simulation, format: :json)
end
