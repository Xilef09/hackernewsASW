json.array!(@contributions) do |contribution|
  json.extract! contribution, :id
end
