json.array!(@eventos) do |evento|
  json.extract! evento, :id, :titulo, :descricao, :data, :localizacao
  json.url evento_url(evento, format: :json)
end
