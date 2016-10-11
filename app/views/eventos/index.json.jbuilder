json.array!(@eventos) do |evento|
  json.extract! evento, :id, :titulo, :data, :localizacao, :descricao
  json.url evento_url(evento, format: :json)
end
