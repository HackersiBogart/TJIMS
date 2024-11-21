// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Automatically load all controllers defined in the "controllers" directory
eagerLoadControllersFrom("controllers", application)
