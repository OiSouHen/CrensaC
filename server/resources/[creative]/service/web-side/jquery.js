/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("#Body").css("display","block");
				$(".Title").html(event["data"]["title"]);
				Groups();
			break;

			case "closeSystem":
				$("#Body").css("display","none");
			break;

			case "updateSystem":
				Groups();
			break;
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://service/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const Groups = () => {
	$.post("http://service/Request","",(data) => {
		var List = data["Result"].sort((a,b) => (a["Passport"] > b["Passport"]) ? 1: -1);

		$("#Content").html(`
			${List.map((item) => (`
				<div class="Line">
					<div class="Line-Number">${item["Passport"]}</div>
					<div class="Line-Name">${item["Name"]}</div>
					<div class="Line-Phone">${item["Phone"]}</div>
					<div class="Line-Status">${item["Status"] == undefined ? "<vermelho>Offline</vermelho>":"<verde>Online</verde>"}</div>
					<div class="Line-Remove" data-passport="${item["Passport"]}">Remover</div>
				</div>
			`)).join('')}
		`);
	});
};
/* ----------LINE-REMOVE---------- */
$(document).on("click",".Line-Remove",function(e){
	$.post("http://service/Remove",JSON.stringify({ passport: e["target"]["dataset"]["passport"] }));
});
/* ----------ADD---------- */
$(document).on("click",".Add",function(e){
	$("#Modal").css("display","block");
});
/* ----------CANCEL---------- */
$(document).on("click","#Cancel",function(e){
	$("#Modal").css("display","none");
});
/* ----------SAVE-BUTTON---------- */
$(document).on("click","#Save",function(e){
	$("#Modal").css("display","none");
	$.post("http://service/Add",JSON.stringify({ passport: $(".Input").val() }));
});