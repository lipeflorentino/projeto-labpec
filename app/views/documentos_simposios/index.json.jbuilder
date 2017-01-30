json.array!(@documentos_simposios) do |documentos_simposio|
  json.extract! documentos_simposio, :id, :arquivo, :simposio_id
  json.url documentos_simposio_url(documentos_simposio, format: :json)
end
