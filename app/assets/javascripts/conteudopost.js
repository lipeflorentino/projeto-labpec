$(document).ready(function () {
    var descricao = $('form#enquiry textarea'),
        contador = '',
        minDescricao = 35, // tamanho mínimo da descrição
        maxDescricao = 150, // tamanho máximo da descrição
        $descricaoValue = descricao.val(),
        $descricaoLength = $descricaoValue.length,
        
    contador = $('span.counter');
    //contador.html.style.color = "#FF0000"; // não funciona
    contador.html(0); // inicializa o contador no html com zero
    descricao.attr('maxlength', maxDescricao); // adiciona o atributo de 'maxlength'
    // chama a função toda vez que o usuário digita uma letra
    descricao.keyup(function () {
      var $this = $(this);
      
      $descricaoLength = $this.val().length; // pega a quantidade de caracteres
      contador.html($descricaoLength); // atualiza
      
    });
  });