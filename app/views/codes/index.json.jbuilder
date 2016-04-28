json.array!(@codes) do |code|
  json.extract! code, :id, :active, :student, :instructor
  json.url code_url(code, format: :json)
end
