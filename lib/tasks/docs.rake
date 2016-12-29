namespace :docs do
  desc "Rake task pra deletar documentos reprovados à mais de duas semanas"
  task limpa: :environment do
    Documento.docs_antigos_reprovados.destroy_all
  end
end