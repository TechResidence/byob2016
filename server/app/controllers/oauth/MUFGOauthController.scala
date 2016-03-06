package controllers.oauth

import javax.inject.Inject

import play.api.libs.ws.WSClient
import play.api.mvc.{Action, Controller}
import play.core.routing.Route
import play.libs.Json.toJson

import scala.concurrent.Await
import scala.concurrent.duration.Duration

class MUFGOauthController @Inject()(ws: WSClient) extends Controller {

  val clientID = "GcGqiJ5UrwK8wpEomuhghVLZnknCRWtW"

  val clientSecret = "Ses97NrVJiKLSfpN"

  def showSignIn = Action { implicit request =>
    val opt = request.session.get("access_token")

    Ok(views.html.mufgSignin(clientID, opt))
  }

  def callBack() = Action { implicit request =>
    Ok(views.html.mufgCallback())
  }

  def callBack2(scope: Option[String], expires_in: Long, access_token: String) = Action { implicit request =>

    println("start")
    println("scope: " + scope)
    println("expires_in: " + expires_in)
    println("access_token: " + access_token)

    val auth = "Bearer " + access_token

    val sss = ws.url("http://demo-ap08-prod.apigee.net/v1/users/me")
      .withHeaders("Accept" ->  "application/json", "Authorization" ->  auth)
      .get

    val user = Await.result(sss, Duration.Inf).json
    println(user)

    //WARNING: you should not use accessToken directly. it is just sample
    Redirect("/mufg/api", MOVED_PERMANENTLY).withSession("access_token" -> access_token)
  }

  def signOut = Action {
    Redirect("/mufg/signin").withNewSession.flashing(
      "success" -> "You are now logged out."
    )
  }

  def api() = Action { request =>
    val opt = request.session.get("access_token")
    opt match {
      case None => Redirect("/mufg/signin").withNewSession.flashing(
        "success" -> "You are now logged out."
      )
      case Some(u) => Ok(views.html.mufgAPI(u))
    }
  }
}
