$('#tabela').dataTable({
	language:{
		info: "Mostrando de _START_ até _END_ de _TOTAL_ registros.",
		search: "Pesquisar ",
		paginate:{
			next: "Próxima",
			previous: "Anterior",
			first: "Primeira página",
			last: "Última página"
		},
		lengthMenu: "_MENU_ resultados por página",
		emptyTable: "Nenhum registro foi encontrado",
		zeroRecords: "Nenhum registro foi encontrado",	
	}
});