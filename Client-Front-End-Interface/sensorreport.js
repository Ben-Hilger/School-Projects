URL = "https://hilgerbj.aws.csi.miamioh.edu/final.php"

console.log("HERE")
for(var i = 1; i <= 99; i++) {
	$("#qty").append("<option>" + i + "</option>")
}

a = $.ajax({
	url : "https://hilgerbj.aws.csi.miamioh.edu/final.php?method=getLocations",
	method : "GET"
}).then(function(data){
	if(data["status"] == 0) {
		for(var i = 0; i < data.result.length; i++) {
			$("#sensorLocGet").append("<option>" + data.result[i]["location"] + "</option>")
		}
	} else {
		$("#alertSensorReport").removeClass("d-none")
		$("#alertSensorReport").append("<h6>There was an issue loading sensor locations</h6><br>")
	}
})

a = $.ajax({
	url : "https://hilgerbj.aws.csi.miamioh.edu/final.php?method=getSensors",
	method : "GET"
}).then(function(data) {
	if(data["status"] == 0) {
		for(var i = 0; i < data.result.length; i++) {
			$("#sensorGet").append("<option>" + data.result[i]["sensor"] + "</option>")
		}
	} else {
		$("#alertSensorReport").removeClass("d-none")
		$("#alertSensorReport").append("<h6>There was an issue loading the sensor list</h6><br>")
	}
})


function getSensorReport() {
	var loc = $("#sensorLocGet").val()
	var qty = $("#qty").val()
	var sensor = $("#sensorGet").val()
	
	$("#alertSensorReport").html("")
	$("#alertSensorReport").addClass("d-none")
	if(qty == "") {
		$("#alertSensorReport").append("<h6>Please enter a valid quantity!</h6>")
		$("#alertSensorReport").removeClass("d-none")
		return
	}

	if(sensor == null) {
		sensor = 0
	}

	if(loc == null) {
		loc = " "
	}
	
	a = $.ajax({
		url : URL + "?Method=getTemp&qty=" + qty + "&location=" + loc + "&sensor=" + sensor,
		method : "GET"
	}).then(function(data) {
		if(data["status"] == 0){
			var tableBody = $("#reportbody")
			tableBody.html("")
			let result = data.result
			for(var i = 0; i < result.length; i++) {
				var source = "https://cse383-hilgerbj.s3.amazonaws.com/sensor" + result[i]["sensor"] + ".jpg"
				tableBody.append("<tr><td>"+ result[i]["location"] +"</td><td> Sensor "+ result[i]["sensor"] + "</td><td>"+ result[i]["date"] +"</td><td>"+ result[i]["value"]+"</td><td class='w-25'><img class='img-thumbnail img-fluid' src='"+ source +"'></td></tr>")
			}
			$("#sensorReportTable").removeClass("d-none")
		} else {
			$("#alertSensorReport").append("<h6>There was an issue processing your request, please try again later.</h6>")
			$("#alertSensorReport").removeClass("d-none")
		}
	}).catch(function(error) {
		console.log(error)
	})
}
