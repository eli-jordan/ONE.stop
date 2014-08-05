package controllers

import models._
import org.bson.types.ObjectId
import play.api.libs.json._
import play.api.mvc._


object TasksController extends Controller {

  /**
   * The request handler that returns a list of all the tasks in the database
   * in JSON
   */
  def listTasksAsJson = Action {
    Ok(Json.toJson(TaskDao.all())).as("application/json")
  }
  
  /**
   * The request handler for the form POSt to create a new task
   */
  def createNewTask = Action {
    implicit request => {
      import models.Task._

      // create the request body into a task object
      val task: Task = Json.fromJson(request.body.asJson.get).get

      // perform the save operation
      TaskDao.save(task)
      //val id: ObjectId = save.getUpsertedId.asInstanceOf[ObjectId]

      // return the created task as json
      val createdTask: Option[Task] = TaskDao.findOneById(task.id)
      Ok(Json.toJson(createdTask.get)).as("application/json")
    }
  }


  /**
   * Update an exisitng task
   * @param id
   *    the id of the item to updatew
   * @return
   *    the updated task json
   */
  def updateTask(id: String) = Action {
    implicit request => {
      import models.Task._
      val taskJson = Json.fromJson(request.body.asJson.get)
      TaskDao.save(taskJson.get)
      Ok(Json.toJson(TaskDao.findOneById(taskJson.get.id)))
    }
  }

  /**
   * Delete an existing task
   * @param id the id of the task
   * @return
   */
  def deleteTask(id: String) = Action {
    TaskDao.removeById(new ObjectId(id))
    Ok("Deleted")
  }


  /**
   * The index view
   * @return
   */
  def tasksIndexView = Action {
    Ok(views.html.index())
  }

  /**
   * Get the specified task
   * @param id the id of the task to lookup
   * @return
   */
  def getTask(id: String) = Action {
    val task: Option[Task] = TaskDao.findOneById(new ObjectId(id))
    task match {
      case Some(value) => Ok(Json.toJson(value))
      case None => NotFound
    }
  }
}