json.array!(@tests) do |test|
  json.extract! test, :id, :attr1, :attr2
  json.url test_url(test, format: :json)
end
