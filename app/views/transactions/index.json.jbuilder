json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :transaction_type, :credit_line_id, :amount, :date
  json.url transaction_url(transaction, format: :json)
end
