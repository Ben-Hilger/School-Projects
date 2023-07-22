currentTab = "Information"
function goToTab(tabName) {
	$("#" + tabName + "-button").addClass("active")
	$("#" + currentTab + "-button").removeClass("active")
	currentTab = tabName
	$(".nav-tab").removeClass("d-none")
	$(".nav-tab").css("display","none")
	$("#" + tabName).css("display", "block")
}
