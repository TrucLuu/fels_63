
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function() {

  $(".delete_ans").on('click', function() {
    id = parseInt($(this).attr("id"));
    $("#word_answers_attributes_"+id+"__destroy").prop('value', true);
    $(this).parent().parent().slideUp(100).remove();
    number = 1;
    $('.label_answer').each(function(){
      $(this).attr("number",number);
      $(this).html("Answer "+ number);
      number++
    });
  })

  $(".answer_radio").on('click', function() {
    $(".answer_radio").prop('checked', false);
    $(".answer_radio").prop('value', false);
    $(this).prop('checked', true);
    $(this).prop('value', true);
  })

  numberMax = parseInt($('.result:last').attr('number'));

  total = numberMax+1

  $('.realtime').html("1/"+total);

  $("#next").click(function(){
    $('#prev').removeClass('disabled');

    number = parseInt($('.result:visible').attr('number')) + 1
    numberShow = number+1
    $('.realtime').html(numberShow+"/"+total);

    $('.result').hide();
    $('.result').eq(number).show();

    if (number == numberMax) {
      $(this).addClass('disabled');
    }
    return false;
  })

  $("#prev").addClass('disabled');

  $("#prev").click(function() {
    $('#next').removeClass('disabled')

    number = parseInt($('.result:visible').attr('number')) - 1
    $('.result').hide();
    $('.result').eq(number).show();

    numberShow = number+1
    $('.realtime').html(numberShow+"/"+total);

    if (number == 0) {
      $(this).addClass('disabled');
    }
    return false
  })

  var page = $("#page").val();
  if(page == 1) {
    if (window.history && window.history.pushState) {
      window.history.pushState('forward', null, '');
      $(window).on('popstate', function() {
        return false;
      })
    }
  }
})
