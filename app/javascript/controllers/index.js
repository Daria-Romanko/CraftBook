// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import LinkDeactivationController from "./link_deactivation_controller"
application.register("link-deactivation", LinkDeactivationController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import SectionController from "./section_controller"
application.register("section", SectionController)

import TurboModalController from "./turbo_modal_controller"
application.register("turbo-modal", TurboModalController)
