package models

import java.util.Date

import com.mongodb.casbah.Imports._
import com.novus.salat.dao._
import models.MongoContext._
import play.api.Play.current
import play.api.libs.functional.syntax._
import se.radley.plugin.salat.Binders._
import se.radley.plugin.salat._

/**
 * The task model object
 */
case class Task(
     id: ObjectId = new ObjectId,
     added: Date = new Date(),
     updated: Option[Date] = None,
     
     // the data field
     description: String,
     complete: Boolean = false)


object Task {
  import play.api.libs.json._

  /**
   * Provides a helper method to have an optional field with a default value
   * @param path the path that will be augmented
   * @return
   */
  implicit def JsPathToDefaultValueHelper(path: JsPath) = new {
    def formatOptionalWithDefault[T](value: => T)(implicit f: Format[T]) =  {
      path.formatNullable[T].inmap[T](_.getOrElse(value), Some(_))
    }
  }

  /**
   * Defines the JSON formatter for the Task type
   */
  implicit val taskFormat: Format[Task] = (
      (JsPath \ "id").formatOptionalWithDefault(new ObjectId) and
      (JsPath \ "added").formatOptionalWithDefault(new Date) and
      (JsPath \ "updated").formatOptionalWithDefault(None: Option[Date]) and
      (JsPath \ "description").format[String] and
      (JsPath \ "complete").formatOptionalWithDefault(false)
  )(Task.apply, unlift(Task.unapply))
}

/**
 * This object wraps calls to mongo db
 */
object TaskDao extends ModelCompanion[Task, ObjectId] {
  
  /**
   * Configure the MongoDB collection for this entity
   */
  def collection = mongoCollection("tasks_collection")
  
  /**
   * Configure the Salat DAO
   */
  val dao = new SalatDAO[Task, ObjectId](collection) {}

  /**
   * Return all tasks in the collection
   */
  def all(): List[Task] = {
    dao.find(MongoDBObject()).toList
  }
}