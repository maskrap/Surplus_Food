$(function(){
  $('.hamburger').click(function(){
    $('.nav-ul').slideDown('500');
    $('hamburger').off('click');
  });
  // $('.hamburger').click(function(){
  //   $('.nav-ul').slideUp('500');
  // });

  // $('.dropbtn').hover(function(){
  //   $('.dropdown-content').slideDown('500');
  // })
});
