// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import VueRouter from 'vue-router';
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Set up Vue
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import Home from "../routes/home.vue"
import List from "../routes/list.vue"


Vue.use(TurbolinksAdapter)
Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    { path: "/", component: Home },
    { path: "/list/:id", component: List}
  ],
  mode: "history",
})

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#root',
    router
  })
})

import "stylesheets/application"
