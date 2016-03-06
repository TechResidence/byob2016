package controllers

import java.util.concurrent.TimeUnit
import javax.inject.{Inject, _}

import akka.actor.{ActorSystem, Props}
import akka.pattern.ask
import akka.util.Timeout
import model.MyObj
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.api.libs.json.Json
import play.api.mvc.{Action, Controller}

import scala.concurrent.Future

@Singleton
class JsonController @Inject() (system: ActorSystem) extends Controller {

  val helloActor = system.actorOf(Props[JsonActor])
  implicit val timeout = Timeout(1000, TimeUnit.MILLISECONDS)

  def get() = Action.async { request =>
    (helloActor ? "hello" ).mapTo[Seq[MyObj]].map { message =>
      Ok(Json.toJson(message))
    }
  }

  def post() = Action.async { request =>
    val myObjOpt = for{
      json <- request.body.asJson
      myObj <- Json.fromJson[MyObj](json).asOpt
    }yield myObj
    myObjOpt match{
      case None => Future.successful(BadRequest(Json.toJson("illegal")))
      case Some(o) => (helloActor ? o ).mapTo[MyObj].map { message =>
        Ok(Json.toJson(message))
      }
    }
  }
}