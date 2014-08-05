
import models._
import Task._
import org.junit._

import play.api.libs.json._

class TaskJsonTest {

  @Test
  def testDeserialiseTask(): Unit = {
    val jsonString = "{\"description\":\"the task description\"}"
    val jsonValue = Json.parse(jsonString)
    val task: JsResult[Task] = Json.fromJson(jsonValue)
    Assert.assertEquals(task.get.description, "the task description")
  }
}
