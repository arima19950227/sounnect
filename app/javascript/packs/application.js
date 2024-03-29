// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import jQuery from "jquery";
import "bootstrap";
import "skippr.min";
import "popper.js";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

global.$ = jQuery;
window.$ = jQuery;
//require('packs/jquery.raty.js')
import "./jquery.raty.js"


// import Raty from "raty.js"
// window.raty = function(elem,opt) {
//   let raty =  new Raty(elem,opt);
//   raty.init();
//   return raty;
// }
$(document).on('turbolinks:load',function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});
