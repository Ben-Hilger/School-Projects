APIURL = "https://api.clearllc.com/api/v2"


function updateSensor() {

	var loc = $("#sensorLoc").val()
	var sensor = $("#sensor").val()
	var value = $("#sensorValue").val()
	
	$("#sensorErr").html("")
	$("#sensorErr").addClass("d-none")
	if(sensor == null) {
		$("#sensorErr").append("<h6>Please select a valid sensor from the list</h6>")
		$("#sensorErr").removeClass("d-none")
		return
	}	
	if(loc == null) {
		$("#sensorErr").append("<h6>Please select a valid sensor location from the list</h6")
		$("#sensorErr").removeClass("d-none")
		return
	}
	if(value == "") {
		$("#sensorErr").append("<h6>Please enter a valid numberic value</h6>")
		$("#sensorErr").removeClass("d-none")
		return
	}
	

	a = $.ajax({
		url : APIURL + "/setTemp?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&userid=hilgerbj&location=" + loc + "&sensor=" + sensor + "&value=" + value,
		method : "GET"
	}).then(function(result) {
		if(result["status"] == 0){
			$("#sensorCom").removeClass("d-none")
			$("#sensorErr").addClass("d-none")
		} else {
			$("#sensorCom").append("<h6>Please enter a valid numeric value</h6>")
			$("#sensorCom").addClass("d-none")
			$("#sensorErr").removeClass("d-none")
		}
	}).catch(function(error) {
		$("#sensorCom").addClass("d-none")
		$("#sensorErr").removeClass("d-none")
	})
}

