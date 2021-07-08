// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import Inputmask from "inputmask";

import '../js/bootstrap_js_files.js'

global.toastr = require("toastr")

import "controllers"
import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

document.addEventListener("turbolinks:load", () => {
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: "j F, Y",
    dateFormat: "Y-m-d",
  })
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
