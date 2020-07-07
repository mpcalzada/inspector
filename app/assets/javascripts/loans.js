//= require footable/footable.all.min.js
//= require dataTables/datatables.min.js
//= require flot/jquery.flot.js
//= require ./amortize/amortize.js
//= require jasny/jasny-bootstrap.min.js
//= require datapicker/bootstrap-datepicker.js

const dateOptions = {year: 'numeric', month: 'long', day: 'numeric'};

function calculateAmortize(amount, rate, totalTerm, amortizeTerm) {
    return amortize({
        amount: amount,
        rate: rate,
        totalTerm: totalTerm,
        amortizeTerm: amortizeTerm
    });
}

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

function loadTable() {

    $('.dataTables-example').DataTable({
        pageLength: 10,
        responsive: true,
        dom: '<"html5buttons"B>lTfgitp',
        buttons: [
            {extend: 'excel', title: 'Prestamo (Tabla de Amortizacion)'},
            {extend: 'pdf', title: 'Prestamo (Tabla de Amortizacion)'},

            {
                extend: 'print',
                customize: function (win) {
                    $(win.document.body).addClass('white-bg');
                    $(win.document.body).css('font-size', '10px');

                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            }
        ]

    });


}

function computeAmortization() {
    $('.dataTables-example').DataTable().clear();
    $('.dataTables-example').DataTable().destroy();
    const balance = parseFloat($('#amount_field').val()
        .replace(',', '')
        .replace('$', ''))
    const term = $('#term_field').val()
    const rate = $('#rate_field').val()
        .replace('%', '')

    const date = new Date($('#date_field').val());
    const table = document.getElementById("amortization_table").getElementsByTagName('tbody')[0];
    const inputs_histories = document.getElementById("inputs_histories");

    for (var i = table.children.length - 1; i >= 0; i--) {
        table.children[0].remove();
    }
    while (inputs_histories.hasChildNodes()) {
        inputs_histories.removeChild(inputs_histories.lastChild);
    }

    let totalPayment = 0;
    let jsonAmortize;

    let input_opts;
    for (let month = 0; month < term; month++) {
        jsonAmortize = calculateAmortize(balance, rate, term, month + 1)
        let row = table.insertRow(-1);
        console.log(jsonAmortize)

        let dateCell = row.insertCell(0);
        let monthlyPayCell = row.insertCell(1);
        let interestCell = row.insertCell(2);
        let totalCell = row.insertCell(3);

        const amount = jsonAmortize.paymentRound;
        const interest = Math.round((jsonAmortize.term.interest + Number.EPSILON) * 100) / 100;
        const remaining_amount = Math.round((jsonAmortize.balance + Number.EPSILON) * 100) / 100;

        dateCell.innerHTML = date.toLocaleDateString("en-US", dateOptions);
        monthlyPayCell.innerHTML = '$' + amount;
        interestCell.innerHTML = '$' + interest;
        totalCell.innerHTML = '$' + remaining_amount;

        input_opts = [
            {"name": `histories[${month}][amount]`, "value": amount},
            {"name": `histories[${month}][interest]`, "value": interest},
            {"name": `histories[${month}][remaining_amount]`, "value": remaining_amount},
        ]

        for (let i in input_opts) {
            let jsonInputValues = input_opts[i]

            $('#inputs_histories')
                .append(`<input type="hidden" name=${jsonInputValues.name} value=${jsonInputValues.value} />`);
        }

        date.setMonth(date.getMonth() + 1)
    }

    totalPayment = (jsonAmortize.principal + parseFloat(jsonAmortize.interestRound))
    $('#interests_field').val('$' + jsonAmortize.interestRound)
    $('#total_field').val('$' + Math.round((totalPayment + Number.EPSILON) * 100) / 100)
    $('#submit_button').attr('disabled', false)
    loadTable();
}

$('#amortization-form').submit(computeAmortization)

$('#btn_calcular').click(computeAmortization);

initDatepicker();
loadTable();
