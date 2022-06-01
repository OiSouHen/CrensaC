window.addEventListener("load",function(){
	errdiv = document.createElement("div");
	if (true){
		errdiv.classList.add("console");
		document.body.appendChild(errdiv);
		window.onerror = function(errorMsg,url,lineNumber,column,errorObj){
			errdiv.innerHTML += '<br />Error: ' + errorMsg + ' Script: ' + url + ' Line: ' + lineNumber + ' Column: ' + column + ' StackTrace: ' +  errorObj;
		}
	}

	var requestmgr = new RequestManager();

	requestmgr.onResponse = function(id,ok){ $.post("http://vrp/request",JSON.stringify({ act: "response", id: id, ok: ok })); }

	window.addEventListener("message",function(evt){
		var data = evt["data"];

		if(data["act"] == "request"){
			requestmgr.addRequest(data["id"],data["text"],data["accept"],data["reject"]);
		}

		if(data["act"] == "event"){
			if(data["event"] == "Y"){
				requestmgr.respond(true);
			}
			else if(data["event"] == "U"){
				requestmgr.respond(false);
			}
		}

		if (data["death"] == true){
			$("#deathDiv").css("display","block");
		}

		if (data["death"] == false){
			$("#deathDiv").css("display","none");
		}

		if (data["deathtext"] !== undefined){
			$("#deathText").html(data["deathtext"]);
		}
	});
});