
$("#movie").submit(function() {  
    var valuesToSubmit = $(this).serialize();
    $.ajax({
        type: "POST",
         // url: '$(this).attr('action')', //sumbits it to the given url of the form
        url: 'http://localhost:3000/movies',
        data: valuesToSubmit,

        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
        console.log("success", json);
    });
    return false; // prevents normal behaviour
});

$(document).ready(function () {
    $("#movie_release").datepicker()
       
    $("#movie_trailerdate").datepicker();

    $('.rateit').bind('rated reset', function (e) {
        var ri = $(this);
        var value = ri.rateit('value');
        ri.rateit('readonly', true);
       // var frm = ri.closest('form');
        var movie_id = $(this).parent().parent().attr("id")
        $.ajax({
            url: 'movies/' + movie_id + '/rate',
            data: { ratings: value },
            type: 'POST',
            success: function (data) {
            }

        });

    });

    $("#sortable").sortable({
        update: function (event, ui) {
            var list = [];
            var changed_list = $("#sortable").sortable('toArray');

            for (var i = 0; i < changed_list.length; i++) {
                list.push({id: changed_list[i], order_no: i})
                console.log(changed_list[i], i)

            }
            $.ajax({
                dataType: 'json',
                url: '/movies/sort',
                method: "POST",
                data: {changed_orders: list}

            });
        }
    });

 });
