json.array!(@outputs) do |output|
  json.extract! output, :id, :group_name, :money_left, :money_spent_vaccines, :money_spent_ads, :vaccs_left, :population, :sick, :immune, :pop_age0, :sick_age0, :pop_age1, :sick_age1, :pop_age2, :sick_age2, :day, :cityID
  json.url output_url(output, format: :json)
end
