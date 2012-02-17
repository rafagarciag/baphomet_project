// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require ../../assets/javascripts/edit_area/edit_area_full.js
//= require ../../assets/javascripts/tiny_mce/tiny_mce.js
$(document).ready(function() {
    $(".danger").click(function() {
        $('#modal-sign-in').modal()
    })
    
    $(".info").click(function() {
        $('#modal-sign-up').modal()
    })

    $(".success").click(function() {
        $('#modal-for-fun').modal()
    })

});


