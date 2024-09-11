// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import { Application } from "@hotwired/stimulus"
import PaintColorsController from "./paint_colors_controller"


application.register("paint_colors", PaintColorsController)

