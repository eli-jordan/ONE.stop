package controllers

import models._
import org.bson.types.ObjectId
import play.api.libs.json._
import play.api.mvc._

object AccessManagerController extends Controller {

  /**
   * Render the user details page
   * @return
   */
  def personalDetailsView = Action {
     Ok(views.html.userdetails())
  }

  /**
   * Render the professional details page
   * @return
   */
  def professionalDetailsView() = Action {
    Ok(views.html.professionaldetails())
  }

  /**
   * Render the system access view
   * @return
   */
  def systemAccessView() = Action {
    Ok(views.html.systemaccess())
  }
}
