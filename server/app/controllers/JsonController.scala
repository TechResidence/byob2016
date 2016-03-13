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

import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}

@Singleton
class JsonController @Inject() (system: ActorSystem) extends Controller {

  var flag = false

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

  def changeFalse() = Action { request =>
    flag = false
    Ok("aa")
  }

  def change() = Action { request =>
    flag = true
    Ok("aa")
  }

  def fetch() = Action { request =>
    if(flag){
      val obj1 = MyObj(1, "true")
      Ok(Json.toJson(obj1))
    }else{
      val obj1 = MyObj(1, "false")
      Ok(Json.toJson(obj1))
    }
  }


}