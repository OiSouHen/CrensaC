$(document).ready(function(){
	const buttons = [];
	const submenus = [];
	var normalButtons = 0;

	document.onkeyup = function(data){
		if (data["which"] == 27){
			for (i = 1; i <= normalButtons; ++i){
				$("#normalbutton-"+i).remove();
			}

			normalButtons = 0;
			$("button").remove();
			$("#goback").remove();
			buttons["length"] = 0;
			submenus["length"] = 0;
			$(".container").html("");

			$.post("http://dynamic/close");
		}
	}

	window.addEventListener("message",function(event){
		var item = event["data"];

		if (item["addbutton"] == true){
			if(item.id == false || null){
				normalButtons = normalButtons + 1;
				var b = (`<div id="normalbutton-${normalButtons}" data-trigger="`+item["trigger"]+`" data-parm="`+item["par"]+`" data-server="`+item["server"]+`" class="normalbutton ${item["title"] == "Guardar" ? "amarelo":""}"><div class="title">`+item["title"]+`</div><div class="description" >`+item["description"]+`</div></div>`);
				$(".container").append(b);
				buttons.push(b);
			} else {
				var b = (`<button id="`+item["id"]+`" data-trigger="`+item["trigger"]+`" data-parm="`+item["par"]+`" data-server="`+item["server"]+`" class="a btn"><div class="title">`+item["title"]+`</div><div class="description" >`+item["description"]+`</div></button>`);
				buttons.push(b);
			}
		} else if(item["addmenu"] == true){
			var aa = (`<button data-menu="`+item["menuid"]+`" class="b btn"><div class="title">`+item["title"]+`</div><div class="description" >`+item["description"]+`</div><i class="fas fa-chevron-right" style="float:right;margin-top:-10%"></i></button>`)
			$(".container").append(aa);
			submenus.push(aa);
		}

		if (item["close"] == true){
			for (i = 1; i <= normalButtons; ++i){
				$("#normalbutton-"+i).remove();
			}

			normalButtons = 0;
			$("button").remove();
			$("#goback").remove();
			buttons["length"] = 0;
			submenus["length"] = 0;
			$(".container").html("");

			$.post("http://dynamic/close");
		}

		if (item["show"] == true){
			$(".container").show();
		}
	});

	$("body").on("click",".normalbutton",function(){
		$.post("http://dynamic/clicked",JSON.stringify({ trigger: $(this).attr("data-trigger"), param: $(this).attr("data-parm"), server: $(this).attr("data-server") }));
	});

	$("body").on("click",".a",function(){
		$.post("http://dynamic/clicked",JSON.stringify({ trigger:$(this).attr("data-trigger"), param:$(this).attr("data-parm"), server: $(this).attr("data-server") }));
	});

	$("body").on("click",".b",function(){
		$(".b").remove();
		$(".a").remove();

		for (i = 1; i <= normalButtons; ++i){
			$("#normalbutton-"+i).hide();
		}

		var goBack = (`<div id="goback" class="normalbutton amarelo"><div class="title">Voltar</div><div class="description" >Clique e volte nas opções anteriores</div></div>`);
		$(".container").append(goBack).show();

		var menuid = $(this).attr("data-menu");
		for (i = 0; i < buttons["length"]; ++i){
			var div = buttons[i];
			var match = div.match(`id="`+menuid+`"`);
			if (match){
				$(".container").append(div);
			}
		}
	});

	$("body").on("click","[id=goback]",function(){
		$(".b").remove();
		$(".a").remove();
		$("button").remove();
		$("#goback").remove();
		$(".container").append(submenus).show();

		for (i = 1; i <= normalButtons; ++i){
			$("#normalbutton-"+i).show();
		}
	});
});