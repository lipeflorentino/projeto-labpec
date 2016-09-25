module PagesHelper
  def imprime_data_arquivo(data)
    aux = " ";
    case data.month
    when 1
      aux = "JANEIRO";
    when 2
      aux = "FEVEREIRO";
    when 3
      aux = "MARÇO";
    when 4
      aux = "ABRIL";
    when 5
      aux = "MAIO";
    when 6
      aux = "JUNHO";
    when 7
      aux = "JULHO";
    when 8
      aux = "AGOSTO";
    when 9
      aux = "SETEMBRO";
    when 10
      aux = "OUTUBRO";
    when 11
      aux = "NOVEMBRO";
    else 
      aux = "DEZEMBRO";
    end
    data.strftime(aux + " %Y")
  end
end
