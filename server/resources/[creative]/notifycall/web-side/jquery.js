$(document).ready(function(){
	let list = [];
	let blocked = false;

	window.addEventListener("message",function(event){
		switch(event["data"]["action"]){
			case "notify":
				addNotification(event["data"]["data"]);
			break

			case "showAll":
				if (list["length"] > 0){
					showLast()
					$.post("http://notifycall/focusOn");
				}
			break

			case "hideAll":
				hideAll();
				$.post("http://notifycall/focusOff");
			break
		}
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			hideAll();
			$.post("http://notifycall/focusOff");
		}
	};

	$(document).on("click","#loc",function(){
		$.post("http://notifycall/setWay",JSON.stringify({ x: $(this).attr("data-x"), y: $(this).attr("data-y") }));
	});

	$(document).on("click","#phone",function(){
		$.post("http://notifycall/phoneCall",JSON.stringify({ phone: $(this).attr("data-phone") }));
	});

	const hideAll = () => {
		blocked = false;
		$(".body").html("");
		$(".body").css("overflow","hidden");
	};

	const addNotification = data => {
		if (list["length"] > 9) list.shift();

		const html = `<div class="notification">
			<div class="content">
				${data["code"] === undefined ? "" : `<div class="code">10-${data["code"]}</div>`}

				<div class="titulo">${data["title"]}</div>

				${data["name"] === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data["name"]}</div>`}

				${data["street"] === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data["street"]}</div>`}

				${data["criminal"] === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data["criminal"]}</div>`}

				${data["vehicle"] === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data["vehicle"]}</div>`}

				${data["time"] === undefined ? "" : `<div class="content-line"><i class="fa fa-arrow-right"></i>  ${data["time"]}</div>`}
			</div>

			<div class="buttons">
				<div class="chamados" id="loc" data-x="${data["x"]}" data-y="${data["y"]}"><i class="fas fa-map-marker-alt fa-lg"></i></div>
				${data["phone"] === undefined ? "" : `<div class="chamados" id="phone" data-phone="${data["phone"]}"><i class="fas fa-phone-alt"></i></div>`}
			</div>

			${data["text"] === undefined ? "" : `<div class="texto">${data["text"]}</div>`}
		</div>`

		list.push(html);

		if (!blocked){
			$(html).prependTo(".body")
			.hide()
			.show("slide",{ direction: "right" },500)
			.delay(5000)
			.hide("slide",{ direction: "right" },500)
		}
	};

	const showLast = () => {
		hideAll();
		blocked = true
		$(".body").css("overflow-y","scroll");

		for (i in list){
			$(list[i]).prependTo(".body");
		}
	};
});