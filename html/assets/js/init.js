$(document).ready(function(){
  window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        $('#wrapper').show();
      } else if (event.data.action == 'close') {
        $('#wrapper').hide();
      } else if (event.data.action == 'callback') {
        if (event.data.array == 'upload-fail') {
          $('#upload h1').text('Du har inget DNA på dig..');
          $('.progress').hide();
        } else if (event.data.array == 'upload-success') {
          var txt;
          if (event.data.atype == 'murder') {
            txt = 'Laddat upp ett DNA med ID: ' + event.data.value;
          } else {
            txt = 'Laddat upp ett DNA för ' + event.data.value;
          }
		  setTimeout(function(){
			  $('#upload h1').text('Klart!');
			  $('.progress').hide();
			  $('.upload-success').text(txt);
		   }, 3000);
        } else if (event.data.array == 'upload-failed') {
          setTimeout(function(){
            $('#upload h1').text('Personen finns redan registrerad..');
            $('.progress').hide();
          }, 3000);
        } else if (event.data.array == 'match-fail') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text('Ingen match..').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'match-exists') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text('Det finns redan en matchning..').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'match-success') {
          $('#match-message').css('background', '#00ae22');
          $('#match-message').text('Vi har en match! Skickar labbrapport..').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'search-fail') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text('Hittade inte ID i databasen').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'remove-success') {
          $('#remove-message').css('background', '#00ae22');
          $('#remove-message').text('DNA borttaget!').slideDown().show();
          setTimeout(function(){
            $('#remove-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'remove-fail') {
          $('#remove-message').css('background', '#ae0e00');
          $('#remove-message').text('Hittade inget DNA..').slideDown().show();
          setTimeout(function(){
            $('#remove-message').slideUp();
          }, 3000);
        }
      } else if (event.data.action == 'murder') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#brottsplatser ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].pk+'</p><p>Uppladdat av:</p><p>'+event.data.array[i].uploader+'</p><p>'+event.data.array[i].datum+'</p></li>');
          }
        } else {
          $('#database h1').text('Hittade inget..');
        }
      } else if (event.data.action == 'prov') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#personer ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].killer+'</p><p>Uppladdat av:</p><p>'+event.data.array[i].uploader+'</p><p>'+event.data.array[i].datum+'</p></li>');
          }
        } else {
          $('#database h1').text('Hittade inget..');
        }
      } else if (event.data.action == 'match') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#lab ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].pk+'</p><p>Hittade spår av DNA från</p><p>'+event.data.array[i].killer+'</p></li>');
          }
          $('#lab h1').text('Labbrapporter');
        } else {
          $('#lab h1').text('Hittade inget..');
        }
      }
  });

function resetAll() {
  $('#database h1').text('Database');
  $('#upload h1').text('Laddar upp..');
  $('.upload-success').text('');
  $('.progress').show();
  $('#upload').hide();
  $('#match').hide();
  $('#match-message').hide();
  $('#remove').hide();
  $('#remove-password').val('');
  $('#remove-id').val('');
  $('#remove-message').hide();
  $('#lab').hide();
  $('#database').hide();
  $('#brottsplatser').hide();
  $('#personer').hide();
  $('#brottsplatser ul').html('');
  $('#personer ul').html('');
  $('#lab ul').html('');
  $('#match-input').val('');
  $('#home').show();
}

$('.btn-back').click(function(){
  resetAll()
});
  $('#btn-upload').click(function() {
    $('#home').hide();
    $('#upload').show();
    $.post('http://jsfour-dna/upload', JSON.stringify({}));
  });

  $('#btn-match').click(function() {
    $('#home').hide();
    $('#match').show();
  });

  $('#btn-remove').click(function() {
    $('#home').hide();
    $('#remove').show();
  });

  $('#btn-remove-go').click(function() {
    if ($('#remove-password').val() == 'jsfour') {
      if ($('#remove-id').val() != '') {
        if (parseInt($('#remove-id').val())) {
          if ($('#remove-id').val().includes("#m")) {
            $.post('http://jsfour-dna/remove', JSON.stringify({match: $('#remove-id').val()}));
          } else {
            $.post('http://jsfour-dna/remove', JSON.stringify({id: $('#remove-id').val()}));
          }
        } else {
          $.post('http://jsfour-dna/remove', JSON.stringify({name: $('#remove-id').val()}));
        }
      }
    } else {
      $('#remove-message').css('background', '#ae0e00');
      $('#remove-message').text('Fel lösenord').slideDown().show();
      setTimeout(function(){
        $('#remove-message').slideUp();
      }, 3000);
    }
  });

  $('#btn-match-go').click(function() {
    if ($('#match-input').val() != '') {
      $.post('http://jsfour-dna/match', JSON.stringify({id: $('#match-input').val()}));
    }
  });

  $('#btn-lab').click(function() {
    $('#home').hide();
    console.log("JS FETCH");
    $.post('http://jsfour-dna/fetch', JSON.stringify({type: "match"}));
    $('#lab').show();
  });

  $('#btn-brottsplatser').click(function() {
    $('#home').hide();
    $.post('http://jsfour-dna/fetch', JSON.stringify({type: "murder"}));
    $('#database h1').text('Database - Brottsplatser');
    $('#database').show();
    $('#brottsplatser').show();
  });

  $('#btn-personer').click(function() {
    $('#home').hide();
    $.post('http://jsfour-dna/fetch', JSON.stringify({type: "prov"}));
    $('#database h1').text('Database - Personer');
    $('#database').show();
    $('#personer').show();
  });

  $(document).keyup(function(e) {
     if (e.keyCode == 27) {
       $('#wrapper').hide();
       resetAll()
       $.post('http://jsfour-dna/escape', JSON.stringify({}));
    }
  });
});
