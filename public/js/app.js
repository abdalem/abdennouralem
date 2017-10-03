jQuery(function($){
  var randomSkills = null,
    words = ["AngularJs", "Angular Material Design", "Angular2", "jQuery", "Ruby Cuba", "Ruby on Rails", "Ruby Sinatra", "Unicorn", "Puma", "Nginx", "Apache", "Bootstrap", "Flexbox", "PostgreSql", "MySql", "Laravel", "Symfony", "Fullstack", "AGILE", "UML"],
    slide = true,
    index = 0;

  $(document).ready(function(){
    var diff = $(window).height()/200;

    $('.header').css('height', 'calc(100vh - ' + $('.navbar').height() + ')');

    $(window).scroll(function (event) {
        var scroll = $(window).scrollTop();
        $('#img-bckg').css('background-position-y', -(scroll/(diff)));
    });

    $( window ).resize(function() {
      console.log("here");
      stylizeLogo();
    });

    stylizeLogo();

    $('#scrollTo').on('click', function() {
			var page = $(this).attr('href');
			var speed = 750;
			$('html, body').animate( { scrollTop: $(page).offset().top }, speed );
		});
	})


  for (var i = 0; i <= words.length - 1; i++) {
    $( ".sliding-words>ul" ).append( "<li>" + words[i] + "</li>" );
  }

  var slideUp = function () {
    $( ".sliding-words>ul" ).animate({
              marginTop: "-=40px"
    }, 400, function() {
      if(index == words.length - 2) {
        slide = false;
      } else {
        index += 1;
      }
    });
  }

  var slideDown = function () {
    $( ".sliding-words>ul" ).animate({
              marginTop: "+=40px"
    }, 400, function() {
      if(index == 0) {
        slide = true;
      } else {
        index -= 1;
      }
    });
  }

  setInterval(function(){
  if (slide){
      slideUp();
    } else {
      slideDown();
    }
  }, 2000);

  var stylizeLogo = function() {
    $('.logo').removeAttr( 'style' ).css({
      padding: (($('#logo').width() - $('#logo').height() + 20)/2) + 'px 10px',
      margin: '10px ' + (($('.logo').width() - $('#logo').width() - 20)/2) + 'px',
      borderRadius: (($('#logo').width() + 20)/2) + 'px'
    });
  }
});
