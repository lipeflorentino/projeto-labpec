json.array!(@simposios) do |simposio|
  json.extract! simposio, :id, :conteudo, :picture, :titulo, :video
  json.url simposio_url(simposio, format: :json)
end
