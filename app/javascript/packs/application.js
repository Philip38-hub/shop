// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'core-js/stable'
import 'regenerator-runtime/runtime'
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "./product_animations"

// Ensure Rails UJS is properly initialized after Turbolinks loads
document.addEventListener('turbolinks:load', () => {
  // Ensure delete links work properly
  document.querySelectorAll('a[data-method="delete"]').forEach(link => {
    link.addEventListener('ajax:success', () => {
      // If needed, add custom success handling here
    });
  });
});
