package controllers

import play.api._
import play.api.mvc._
import play.api.libs.json._

import play.api.data._
import play.api.data.Forms._

import models._
  
object Application extends Controller {

  /**
   * Redirect to the tasks page
   */
  def index = Action {
    Redirect(routes.TasksController.tasksIndexView)
  }
}