package controllers.oauth

import javax.inject.Inject

import play.api.libs.json.{JsArray, JsValue}
import play.api.libs.ws.WSClient
import play.api.mvc.{Action, Controller}

import scala.concurrent.Await
import scala.concurrent.duration.Duration
import scala.util.parsing.json.JSONArray

class MUFGOauthController @Inject()(ws: WSClient) extends Controller {

	val mufgAPIUrlBase = "http://demo-ap08-prod.apigee.net/v1"

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

	def users() = Action { request =>
		val access_token = request.session.get("access_token").get

		val auth = "Bearer " + access_token

		val sss = ws.url("http://demo-ap08-prod.apigee.net/v1/users")
			.withHeaders("Accept" ->  "application/json", "Authorization" ->  auth)
			.get

		val user = Await.result(sss, Duration.Inf).json
		Ok(user)
	}

	def userMe() = Action { request =>
		val access_token = request.session.get("access_token").get

		val user = fetchMyDetail(access_token)

		val myAccounts = (user \ "my_accounts").asOpt[JsArray].get
		val accountId = (myAccounts.value.head \ "account_id").asOpt[String].get

		val account = fetchAccountDetail(access_token, accountId)

		val balance = (account \ "balance").asOpt[Long].get

		println(balance)

		Ok(user)
	}


	def furikomi() = Action { request =>
		val access_token = request.session.get("access_token").get

		val user = fetchMyDetail(access_token)


		val myAccounts = (user \ "my_accounts").asOpt[JsArray].get
		val accountId = (myAccounts.value.head \ "account_id").asOpt[String].get

		val account = fetchAccountDetail(access_token, accountId)

		val balance = (account \ "balance").asOpt[Long].get

		println(balance)

		Ok(user)
	}

	private def fetchMyDetail(access_token: String): JsValue ={
		val auth = "Bearer " + "1vofwhWOUzEInySGxhKglS4kd1LZ"

		println(auth)
		val s1 = ws.url(mufgAPIUrlBase + "/users/me")
			.withHeaders("Accept" ->  "application/json", "Authorization" ->  auth)
			.get

		Await.result(s1, Duration.Inf).json
	}

	private def fetchAccountDetail(access_token: String, accountId: String): JsValue ={
		val auth = "Bearer " + access_token

		val s2 = ws.url(mufgAPIUrlBase + "/accounts/" + accountId)
			.withHeaders("Accept" ->  "application/json", "Authorization" ->  auth)
			.get
		Await.result(s2, Duration.Inf).json
	}

	private def postFurikomi(access_token: String, fromAccountId: String, toAccountId: String, amount: Long): JsValue ={
		val auth = "Bearer " + access_token

		val s2 = ws.url(mufgAPIUrlBase + "/accounts/" + fromAccountId)
			.withHeaders(
				"Accept" ->  "application/json",
				"Authorization" ->  auth,
				"action" -> ""
			)
			.get
		Await.result(s2, Duration.Inf).json
	}
}
