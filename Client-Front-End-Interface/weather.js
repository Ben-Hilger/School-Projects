ZURL = "https://api.clearllc.com/api/v2"
WEATHERZURL = "https://api.openweathermap.org/data/2.5"

function getZipcodeWeather() {

	var zipcode = $("#zipcode").val()
	a = $.ajax({
		url : ZURL + "/miamidb/_table/zipcode?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&ids=" + zipcode,
		method :  "GET"
	}).done(function(data) {
		$("#alertWeather").addClass("d-none")
		var info = data["resource"][0]
		var lat = info["latitude"]
		var longitude = info["longitude"]
		$("#town-name").html(info["city"])
		getWeatherData(lat, longitude)
	}).fail(function(error) {
		$("#alertWeather").removeClass("d-none")
	})
}

function getWeatherData(lat, longitude) {
	
	a = $.ajax({
		url : WEATHERZURL + "/onecall?lat=" + lat + "&lon=" + longitude + "&exclude=hourly&units=imperial&appid=9d89acfd986e1660cac88343b6951014",
		method : "GET"
	}).done(function(data) {
		var daily = data["daily"]
		$("#forcastCon").removeClass("d-none")
		$("#weatherTable").html("")
		for(var i = 1; i <= daily.length; i++){
			var data = daily[i-1]
			var sunrise = data["sunrise"]
			var sunset = data["sunset"]
			var time = data["dt"]
			var dayTemp = data.temp["day"]
			var dayFeelsTemp = data.feels_like["day"]
			var minTemp = Math.round(data.temp["min"])
			var maxTemp = Math.round(data.temp["max"])

			if(i == 1) {
				$("#cur-weather-cond").html(data.weather[0]["main"])
				$("#today-high-low").html("H: " + maxTemp + " F L: " + minTemp + " F")
				$("#current-sunrise").html("Sunrise: " + getTimeFromDate(new Date(sunrise*1000)))
				$("#current-sunset").html("Sunset: " + getTimeFromDate(new Date(sunset*1000)))
			}
			var nightFeelsTemp = data.feels_like["night"]
			var eveningTemp = data.temp["eve"]
			var eveningFeelsTemp = data.feels_like["eve"]
			var mornTemp = data.temp["morn"]
			var mornFeelsTemp = data.feels_like["morn"]
			$("#weatherTable").append("<tr><td class='text-left align-middle'><h6>" + getFormattedDate(new Date(time*1000)) + "</h6><br>Sunrise: " + getTimeFromDate(new Date(sunrise*1000)) +  "<br>Sunset: " + getTimeFromDate(new Date(sunset*1000)) + "</td><td class='text-right'><img src=http://openweathermap.org/img/wn/" + data.weather[0]["icon"] + "@2x.png><td class='text-right align-middle'>" + (data.weather[0]["main"] == "Snow" || data.weather[0]["main"] == "Rain" ? Math.round(data[data.weather[0]["main"].toLowerCase()]/25.4*100)/100 + " inches" : "") +"</td><td class='text-right align-middle'>" + maxTemp + " F</td><td class='text-right align-middle'>" + minTemp +" F</td></tr>")	
		}
	}).fail(function(error) {
		console.log(error)
	})
}

function getFormattedDate(date) {
	var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
	return days[date.getDay()] + ", " + months[date.getMonth()] + " " + date.getDate() 
}

function getTimeFromDate(date) {
	return (date.getHours()%12) + ":" + (date.getMinutes() < 10 ? "0" : "") + date.getMinutes() + (date.getHours() >= 12 ? " PM" : " AM")
}
