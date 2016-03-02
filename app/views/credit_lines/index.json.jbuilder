json.array!(@credit_lines) do |credit_line|
  json.extract! credit_line, :id, :apr, :limit, :amount_drawn
  json.url credit_line_url(credit_line, format: :json)
end
