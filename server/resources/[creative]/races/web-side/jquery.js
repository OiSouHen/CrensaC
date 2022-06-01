var maxCheckpoint = 0;
var Checkpoint = 0;
// -------------------------------------------------------------------------------------------
function minimalTimers(Seconds){
	var Seconds = parseInt(Seconds / 1000)
	var Days = Math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	var Hours = Math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	var Minutes = Math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	const [D,H,M,S] = [Days,Hours,Minutes,Seconds].map(s => s.toString().padStart(2,0))

	if (Days > 0){
		return D + ":" + H
	} else if (Hours > 0){
		return H + ":" + M
	} else if (Minutes > 0){
		return M + ":" + S
	} else if (Seconds > 0){
		return "00:" + S
	} else {
		return "00:00"
	}
}
// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event["data"]["show"] !== undefined){
			if (event["data"]["show"] == true){
				$("#displayRunners").css("display","block");
				maxCheckpoint = event["data"]["maxCheckpoint"];
				Checkpoint = 1;
			} else {
				$("#displayRunners").css("display","none");
			}

			return
		}

		if (event["data"]["upCheckpoint"] !== undefined){
			Checkpoint = Checkpoint + 1;

			return
		}

		if (event["data"]["ranking"] !== undefined){
			if (event["data"]["ranking"] == false){
				$("#displayRanking").css("display","none");
			} else {
				var resultTable = event["data"]["ranking"];

				if (resultTable !== "[]"){
					$("#displayRanking").css("display","block");

					var position = 0;
					$("#displayRanking").html("");
					$("#displayRanking").html(`
						<div id="raceTitle">RANKING</div>
						<div id="raceLegend">Lista dos 5 melhores colocados neste circuito.</div>
					`);

					$("#displayRanking").css("display","block");

					$.each(JSON.parse(resultTable),(k,v) => {
						$('#displayRanking').append(`
							<div id="raceLine">
							<div class="racePosition">${position = position + 1}</div>
							<div class="raceName">${v["name"]}</div>
							<div class="raceVehicle">${v["vehicle"]}</div>
							<div class="racePoints">${minimalTimers(v["points"])}</div>
							</div>
						`);
					});

					$('#displayRanking').append(`<div id="raceButtom">Pressionando a tecla <key>G</key> você fecha o ranking</div>`);
				}
			}

			return
		}

		$("#displayRunners").html(`
			CHECKPOINTS <s>${Checkpoint} / ${maxCheckpoint}</s><br>
			PERCORRIDO <s>${minimalTimers(event["data"]["Points"])}</s>
		`);

		if (parseInt(event["data"]["Explosive"]) > 0){
			$('#displayRunners').append(`<br>EXPLOSÃO <s>${minimalTimers(event["data"]["Explosive"])}</s>`);
		}
	});
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}