package controllers.oauth

import javax.inject.Inject

import play.api.libs.ws.WSClient
import play.api.mvc.{Action, Controller}
import play.libs.Json.toJson

import scala.concurrent.Await
import scala.concurrent.duration.Duration

class MUFGOauthController @Inject()(ws: WSClient) extends Controller {

  def clientID = "b2ba87dca40b71666b5a"

  def clientSecret = "da5f60a1b3e039ab6d55c2a130f32679f661a6dd"

  def showSignIn = Action { implicit request =>
    val opt = request.session.get("access_token")

    Ok(views.html.githubSignin(clientID, opt))
  }

  def callBackGitHub(code: String) = Action { implicit request =>

    println("start")
    import play.api.libs.json._
    val postBodyJson = Json.obj(
      "client_id" -> toJson(clientID),
      "client_secret" -> toJson(clientSecret),
      "code" -> toJson(code)
    )
    println("postBody=" + postBodyJson)

    val responce = ws.url("https://github.com/login/oauth/access_token")
      .withHeaders("Content-Type" ->  "application/json")
      .withHeaders("Accept" ->  "application/json")
      .post(postBodyJson.toString)
    val ss = Await.result(responce, Duration.Inf)

    println(ss.json)
    val accessToken = (ss.json \ "access_token").asOpt[String].get
    println(accessToken)

    val sss = ws.url("https://api.github.com/user")
      .withQueryString("access_token" ->  accessToken)
      .withHeaders("Accept" ->  "application/json")
      .get
    val user = Await.result(sss, Duration.Inf).json
    println(user)

    //WARNING: you should not use accessToken directly. it is just sample
    Redirect("/github/signin", MOVED_PERMANENTLY).withSession("access_token" -> (user \ "login").asOpt[String].get)
  }

  def signOut = Action {
    Redirect("/github/signin").withNewSession.flashing(
      "success" -> "You are now logged out."
    )
  }
}
