$(function () {
	function display (bool) {
		if (bool){
			$("#container").show();
		} else {
			$("#container").hide();
		}
	}
	display(false)
	window.addEventListener("message", function(event) {
		var item = event.data;
		if (item.type === "ui") {
			if (item.status == true) {
				display(true)
			} else {
				display(false)
			}
		}
	})

	var boostValue
	var fuelValue
	var gearValue
	var brakingValue
	var driveValue

	document.onkeyup = function(data) {
		if (data.which == 27) {
			$.post("http://hurican_tunerchip/exit");
		}
	}

	var boostSlider = document.getElementById("boost");
	boostSlider.oninput = function() {
		boostValue = $("#boost").val()
	}

	var fuelSlider = document.getElementById("fuel");
	fuelSlider.oninput = function() {
		fuelValue = $("#fuel").val()
	}

	var gearSlider = document.getElementById("gear");
	gearSlider.oninput = function() {
		gearValue = $("#gear").val()
	}

	var brakingSlider = document.getElementById("braking");
	brakingSlider.oninput = function() {
		brakingValue = $("#braking").val()
	}

	var driveSlider = document.getElementById("drive");
	driveSlider.oninput = function() {
		driveValue = $("#drive").val()
	}

	$("#save").click(function () {
        $.post('http://hurican_tunerchip/save', JSON.stringify({
            boost: boostValue,
            fuel: fuelValue,
            gear: gearValue,
            braking: brakingValue,
            drive: driveValue
        }));
        return;
    })

    $("#default").click(function () {
        document.getElementById("boost").value = "nil";
    	document.getElementById("fuel").value = "nil";
        document.getElementById("gear").value = "nil";
        document.getElementById("braking").value = "nil";
        document.getElementById("drive").value = "nil";
        return;
    })

    $("#sport").click(function () {
    	document.getElementById("boost").value = "10";
    	document.getElementById("fuel").value = "nil";
        document.getElementById("gear").value = "10";
        document.getElementById("braking").value = "nil";
        document.getElementById("drive").value = "nil";
        return;
    })

}) 