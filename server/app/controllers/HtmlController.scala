package controllers

import java.util.concurrent.TimeUnit
import javax.inject.{Inject, Singleton}

import akka.actor.{ActorSystem, Props}
import akka.pattern.ask
import akka.routing.RoundRobinPool
import akka.util.Timeout
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.api.mvc._

@Singleton
class HtmlController @Inject() (system: ActorSystem) extends Controller {

  var router = system.actorOf(RoundRobinPool(5).props(Props[HtmlActor]))

  implicit val timeout = Timeout(1000, TimeUnit.MILLISECONDS)

  def index = Action.async {
    (router ? "uryyyyyyy" ).mapTo[String].map { message =>
      Ok(views.html.index(message))
    }
  }

}
