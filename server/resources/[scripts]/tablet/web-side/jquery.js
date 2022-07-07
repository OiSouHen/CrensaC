var benMode = "Carros";
var benSearch = "alphabetic";
var selectPage = "benefactor";
var reversePage = "benefactor";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	benefactor("Carros");

	window.addEventListener("message",function(event){
		switch (event["data"]["action"]){
			case "openSystem":
				$("#mainPage").css("display","block");
			break;

			case "closeSystem":
				$("#mainPage").css("display","none");
			break;
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://tablet/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click","#mainMenu li",function(){
	if (selectPage != reversePage){
		let isActive = $(this).hasClass("active");
		$("#mainMenu li").removeClass("active");
		if (!isActive){
			$(this).addClass("active");
			reversePage = selectPage;
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const searchTypePage = (mode) => {
	benSearch = mode;
	benefactor(benMode);
}
/* ---------------------------------------------------------------------------------------------------------------- */
const benefactor = (mode) => {
	benMode = mode;
	selectPage = "benefactor";

	$("#content").html(`
		<div id="benefactorBar">
			<li id="benefactor" data-id="Carros" ${mode == "Carros" ? "class=active":""}>CARROS</li>
			<li id="benefactor" data-id="Motos" ${mode == "Motos" ? "class=active":""}>MOTOS</li>
			<li id="benefactor" data-id="Aluguel" ${mode == "Aluguel" ? "class=active":""}>ALUGUEL</li>
		</div>

		<div id="contentVehicles">
			<div id="titleVehicles">${mode}</div>
			<div id="typeSearch"><span onclick="searchTypePage('alphabetic');">Ordem Alfabética</span> / <span onclick="searchTypePage('crescent');">Valor Crescente</span></div>
			<div id="pageVehicles"></div>
		</div>
	`);

	$.post("http://tablet/request"+ mode,JSON.stringify({}),(data) => {
		if (benSearch == "alphabetic"){
			var nameList = data["result"].sort((a,b) => (a["name"] > b["name"]) ? 1: -1);
		} else {
			var nameList = data["result"].sort((a,b) => (a["price"] > b["price"]) ? 1: -1);
		}

		$("#pageVehicles").html(`
			${nameList.map((item) => (`<span>
				<left>
					<i>${item["name"]}</i>
					<b>Valor:</b> ${mode == "Aluguel" ? item["price"] +" Gemas":"$"+format(item["price"])}<br>
					<b>Taxa:</b> $${format(item["tax"])}<br>
					<b>Porta-Malas:</b> ${item["chest"]}Kg
				</left>
				<right>
					${mode == "Aluguel" ? "<div id=\"benefactorRental\" data-name="+item["k"]+">ALUGAR</div>":"<div id=\"benefactorBuy\" data-name="+item["k"]+">COMPRAR</div>"}
					<div id="benefactorDrive" data-name="${item["k"]}">TESTAR</div>
				</right>
			</span>`)).join('')}
		`);
	});
};
/* ----------BENEFACTOR---------- */
$(document).on("click","#benefactor",function(e){
	benefactor(e["target"]["dataset"]["id"]);
});
/* ----------BENEFACTORBUY---------- */
$(document).on("click","#benefactorBuy",function(e){
	$.post("http://tablet/requestBuy",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});
/* ----------BENEFACTORRENTAL---------- */
$(document).on("click","#benefactorRental",function(e){
	$.post("http://tablet/requestRental",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});
/* ----------BENEFACTORDRIVE---------- */
$(document).on("click","#benefactorDrive",function(e){
	$.post("http://tablet/requestDrive",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}