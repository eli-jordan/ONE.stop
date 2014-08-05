import com.typesafe.sbt.jse.JsEngineImport._
import com.typesafe.sbteclipse.plugin.EclipsePlugin._
import play.PlayImport._
import play.twirl.sbt.Import._
import sbt.Keys._
import sbt._

object Build extends Build {

  import com.typesafe.sbt.coffeescript.Import.CoffeeScriptKeys
  import com.typesafe.sbt.web.SbtWeb

  val AppName = "todo"
  
  val AppVersion = "1.0-SNAPSHOT"
  
  val AppScalaVersion = "2.11.1"
  
  val AppDependencies = Seq(
     "se.radley" %% "play-plugins-salat" % "1.5.0",
     "org.webjars" %% "webjars-play" % "2.3.0",
     "org.webjars" % "bootstrap" % "3.1.1-1",
     "org.webjars" % "jquery" % "2.0.3"
  )

  /**
   * Configure the main application
   */
  val main = Project(AppName, file(".")).enablePlugins(play.PlayScala, SbtWeb).settings(

    Keys.version := AppVersion,

    Keys.scalaVersion := AppScalaVersion,

    // append the application dependencies to the project dependencies
    Keys.libraryDependencies ++= AppDependencies,

    // mongo db library implicit imports
    PlayKeys.routesImport += "se.radley.plugin.salat.Binders._",
    TwirlKeys.templateImports += "org.bson.types.ObjectId",

    // create source maps so the coffee script can be debugged easily
    CoffeeScriptKeys.sourceMap := true,

    // use node to compile coffeescript
    JsEngineKeys.engineType := JsEngineKeys.EngineType.Node,

    // download the source
    EclipseKeys.withSource := true
  )
}