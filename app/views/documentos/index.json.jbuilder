json.array!(@documentos) do |documento|
  json.extract! documento, :id, :user_id, :titulo, :descricao,:author, :status, :data_defesa, :tese, :mestrado
  json.url documento_url(documento, format: :json)
end
