//= require flot/jquery.flot.js
//= require flot/jquery.flot.tooltip.min.js
//= require flot/jquery.flot.resize.js
//= require flot/jquery.flot.pie.js
//= require flot/jquery.flot.time.js
//= require flot/jquery.flot.spline.js
//= require sparkline/jquery.sparkline.min.js
//= require chartjs/Chart.min.js
//= require jvectormap/jquery-jvectormap-2.0.2.min.js
//= require jvectormap/jquery-jvectormap-world-mill-en.js
//= require toastr/toastr.min.js

//= require iCheck/icheck.min.js
//= require staps/jquery.steps.min.js
//= require validate/jquery.validate.min.js
//= require dropzone/dropzone.js
//= require summernote/summernote.min.js
//= require colorpicker/bootstrap-colorpicker.min.js
//= require cropper/cropper.min.js
//= require datapicker/bootstrap-datepicker.js
//= require ionRangeSlider/ion.rangeSlider.min.js
//= require jasny/jasny-bootstrap.min.js
//= require jsKnob/jquery.knob.js
//= require nouslider/jquery.nouislider.min.js
//= require switchery/switchery.js
//= require chosen/chosen.jquery.js
//= require fullcalendar/moment.min.js
//= require clockpicker/clockpicker.js
//= require daterangepicker/daterangepicker.js
//= require bootstrap/bootstrap-tagsinput


/** FORM VIEW JAVASCRIPT **/

function initWizard() {
    $("#form").steps({
        bodyTag: "fieldset",
        onCanceled: function () {
            window.history.back();
        },
        onStepChanging: function (event, currentIndex, newIndex) {
            // Always allow going backward even if the current step contains invalid fields!
            if (currentIndex > newIndex) {
                return true;
            }

            // Forbid suppressing "Warning" step if the user is to young
            if (newIndex === 3 && Number($("#age").val()) < 18) {
                return false;
            }

            var form = $(this);

            // Clean up if user went backward before
            if (currentIndex < newIndex) {
                // To remove error styles
                $(".body:eq(" + newIndex + ") label.error", form).remove();
                $(".body:eq(" + newIndex + ") .error", form).removeClass("error");
            }

            // Disable validation on fields that are disabled or hidden.
            form.validate().settings.ignore = ":disabled,:hidden";

            // Start validation; Prevent going forward if false
            return form.valid();
        },
        onStepChanged: function (event, currentIndex, priorIndex) {
            // Suppress (skip) "Warning" step if the user is old enough.
            if (currentIndex === 2 && Number($("#age").val()) >= 18) {
                $(this).steps("next");
            }

            // Suppress (skip) "Warning" step if the user is old enough and wants to the previous step.
            if (currentIndex === 2 && priorIndex === 3) {
                $(this).steps("previous");
            }
        },
        onFinishing: function (event, currentIndex) {
            var form = $(this);

            // Disable validation on fields that are disabled.
            // At this point it's recommended to do an overall check (mean ignoring only disabled fields)
            form.validate().settings.ignore = ":disabled";

            // Start validation; Prevent form submission if false
            return form.valid();
        },
        onFinished: function (event, currentIndex) {
            var form = $(this);

            // Submit form input
            form.submit();
        }
    }).validate({
        errorPlacement: function (error, element) {
            element.before(error);
        },
        rules: {
            confirm: {
                equalTo: "#password"
            }
        }
    });
}

function initClockPicker() {
    $('.clockpicker').clockpicker();
}

$('input[type="checkbox"]').change(function () {
    this.value = (Number(this.checked));
});

function initDatepicker() {
    $('.form_datepicker').find('.input-group.date').datepicker({
        format: "yyyy-mm-dd",
        startView: 2,
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
}

function initChosen() {
    var config = {
        '.chosen-select': {},
        '.chosen-select-deselect': {allow_single_deselect: true},
        '.chosen-select-no-single': {disable_search_threshold: 10},
        '.chosen-select-no-results': {no_results_text: 'Oops, nothing found!'},
        '.chosen-select-width': {width: "95%"}
    }

    for (var selector in config) {
        $(selector).chosen(config[selector]);
    }
}

var avatarImage = $("#avatarImage");
if (window.FileReader) {
    avatarImage.change(function () {
        let avatar_button = $("#avatar-button");
        avatar_button.css('background-color', '#1AB394');
        avatar_button.css('border-color', '#1AB394');
    });
} else {
    avatarImage.addClass("hide");
}

var curriculumInput = $("#curriculumInput");
if (window.FileReader) {
    curriculumInput.change(function () {
        $("#curriculum-button").css('background-color', '#1AB394');
        $("#curriculum-button").css('border-color', '#1AB394');
    });
} else {
    curriculumInput.addClass("hide");
}

initWizard();
initDatepicker();
initClockPicker();
initChosen();


/** SHOW VIEW JAVASCRIPT **/

$(function () {

    $("span.pie").peity("pie", {
        fill: ['#1ab394', '#d7d7d7', '#ffffff']
    })

    $(".line").peity("line", {
        fill: '#1ab394',
        stroke: '#169c81',
    })

    $(".bar").peity("bar", {
        fill: ["#1ab394", "#d7d7d7"]
    })


});


function plotGraph(data) {
    var dataset = [
        {
            label: "Worked Hours",
            data: data,
            color: "#1ab394",
            bars: {
                show: true,
                align: "center",
                barWidth: 24 * 60 * 60 * 600,
                lineWidth: 0
            }

        }
    ];


    const options = {
        xaxis: {
            mode: "time",
            tickSize: [1, "day"],
            tickLength: 0,
            axisLabel: "Date",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Arial',
            axisLabelPadding: 10,
            color: "#d5d5d5"
        },
        yaxes: [{
            position: "left",
            max: 15,
            color: "#d5d5d5",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Arial',
            axisLabelPadding: 3
        }, {
            position: "right",
            clolor: "#d5d5d5",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: ' Arial',
            axisLabelPadding: 67
        }
        ],
        legend: {
            noColumns: 1,
            labelBoxBorderColor: "#000000",
            position: "nw"
        },
        grid: {
            hoverable: false,
            borderWidth: 0
        }
    };

    $.plot($("#flot-dashboard-chart"), dataset, options);
}

function modifyAttendanceIndicators(workedHoursArray, delays) {
    let totalWorkedHours = 0;

    for (let i in workedHoursArray) {
        totalWorkedHours += workedHoursArray[i][1];
    }

    $('#total-worked-hours-label').text(Math.round((totalWorkedHours + Number.EPSILON) * 100) / 100);
    $('#delays-label').text(delays);
    $('#average-per-day-label').text(Math.round((totalWorkedHours / workedHoursArray.length + Number.EPSILON) * 100) / 100);

    let delaysPercentage = ((delays / workedHoursArray.length) * 100) + "%";
    let totalWorkedPercentage = ((Math.round((totalWorkedHours / (workedHoursArray.length * 8)) * 100) / 100) * 100) + '%';

    $('#total-worked-hours-stat').text(totalWorkedPercentage);
    $('#delays-stat').text(delaysPercentage);

}

function modifyAttendanceTable(jsonDataSet) {

    for (let i in jsonDataSet) {
        let table = document.getElementById("attendance-table");
        let row = table.insertRow(-1);

        let dateCell = row.insertCell(0);
        let entranceCell = row.insertCell(1);
        let exitCell = row.insertCell(2);
        let workedHoursCell = row.insertCell(3);

        let options = {weekday: 'short', year: 'numeric', month: 'short', day: '2-digit'};
        let date = new Date(jsonDataSet[i].date);

        let tick = '<a class="btn btn-xs" style="background-color: #3a9ab3"><i class="fa fa-check" style="color: white;"></i></a>';
        let strike = '<a class="btn btn-xs" onclick="showModal(`${this}`)" style="background-color: #ed5565"><i class="fa fa-times" style="color: white;"></i></a>';


        dateCell.innerHTML = date.toLocaleDateString("es", options);
        entranceCell.innerHTML = jsonDataSet[i].entrance_time;

        entranceCell.innerHTML = jsonDataSet[i].entrance_time + ' - ' + ((jsonDataSet[i].entrance_time < '09:10:00') ? tick : strike);

        if (jsonDataSet[i].finished_time > '18:00:00') {
            exitCell.innerHTML = jsonDataSet[i].finished_time + ' - ' + tick
        } else if (jsonDataSet[i].finished_time > '16:00:00' && date.getDay() === 5) {
            exitCell.innerHTML = jsonDataSet[i].finished_time + ' - ' + tick
        } else {
            exitCell.innerHTML = jsonDataSet[i].finished_time + ' - ' + strike
        }
        workedHoursCell.innerHTML = jsonDataSet[i].worked_hours;
    }
}

function showModal(registerId) {
    $('#myModal6').modal()
}

function gatherData() {
    let jsonText = $('#attendance-graph-data').text();
    if (jsonText) {
        let json = JSON.parse(jsonText);
        let plotArray = [];

        if (json.length > 0) {
            let delays = 0;

            for (let i in json) {
                let date = new Date(json[i].date).getTime();
                let workedHours = json[i].worked_hours;

                if (json[i].entrance_time > '09:10:00') {
                    delays++;
                }

                plotArray.push([date, workedHours]);
            }

            modifyAttendanceTable(json);
            modifyAttendanceIndicators(plotArray, delays);
        }
        plotGraph(plotArray);
    }
}

gatherData();