module ApplicationHelper
  def imprime_data (data)
    aux = " ";
    case data.month
    when 1
      aux = "Jan";
    when 2
      aux = "Fev";
    when 3
      aux = "Mar";
    when 4
      aux = "Abr";
    when 5
      aux = "Maio";
    when 6
      aux = "Jun";
    when 7
      aux = "Jul";
    when 8
      aux = "Ago";
    when 9
      aux = "Set";
    when 10
      aux = "Out";
    when 11
      aux = "Nov";
    else 
      aux = "Dez";
    end
    data.strftime("%d " + aux + "/%y - %H:%M")
    
  end
end
