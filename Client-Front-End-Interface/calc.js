calcURL = "https://api.clearllc.com/api/v2/math"

function calc() {
	
	$("#errorCalc").html("")
	$("#errorCalc").addClass("d-none")

	if($("#numberOne").val() == "" || $("#numberTwo").val() == "") {
		$("#errorCalc").append("<h6>Please fill out both number fields!</h6>")
		$("#errorCalc").removeClass("d-none")
		return
	}

	var operation = $("#operation").val()
	
	if(operation == "") {
		$("#errorCalc").append("<h6>Please select an operation to perform!</h6>")
		$("#errorCalc").removeClass("d-none")
		return
	}

	$("#calcTable").removeClass("d-none")
	if(operation == "add") {
		add()
	} else if(operation == "sub") {
		sub()
	} else if(operation == "multi") {
		multi()
	} else if(operation == "div") {
		div()
	}
}

function add() {
	
	var num1 = $("#numberOne").val()
	var num2 =  $("#numberTwo").val()
	a = $.ajax({
		url : calcURL + "/Add?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&n1=" + num1 + "&n2=" + num2,
		method : "GET"
	}).done(function(data) {
		updateCalcTable(num1, num2, "+", data["result"])
	}).fail(function(error) {
		response = error.responseJSON.error.message
		updateCalcTable(num1, num2, "+", response)
		
	})

}

function sub() {
	
	var num1 = $("#numberOne").val()
	var num2 =  $("#numberTwo").val()

	a = $.ajax({
		url : calcURL + "/Subtract?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&n1=" + num1 + "&n2=" + num2,
		method : "GET"
	}).done(function(data) {
		updateCalcTable(num1, num2, "-", data["result"])
	}).fail(function(error) {
		response = error.responseJSON.error.message
		updateCalcTable(num1, num2, "-", response)
	})

}

function multi() {
	
	var num1 = $("#numberOne").val()
	var num2 =  $("#numberTwo").val()

	a = $.ajax({
		url : calcURL + "/Multiply?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&n1=" + num1 + "&n2=" + num2,
		method : "GET"
	}).done(function(data) {
		updateCalcTable(num1, num2, "*", data["result"])
	}).fail(function(error) {
		response = error.responseJSON.error.message
		updateCalcTable(num1, num2, "*", response)
	})

}

function div() {
	
	var num1 = $("#numberOne").val()
	var num2 =  $("#numberTwo").val()

	a = $.ajax({
		url : calcURL + "/Divide?api_key=bed859b37ac6f1dd59387829a18db84c22ac99c09ee0f5fb99cb708364858818&n1=" + num1 + "&n2=" + num2,
		method : "GET"
	}).done(function(data) {
		updateCalcTable(num1, num2, "/", data["result"])
	}).fail(function(error) {
		response = error.responseJSON.error.message
		updateCalcTable(num1, num2, "/", response)
	})

}

function updateCalcTable(num1, num2, op, result) {
	$("#calc-results-table").prepend("<tr><td>" + num1 + "</td><td>" + op + "</td><td>" + num2 + "</td><td>=</td><td>" + result + "</td></tr>")
}



