//package dao
//
//import javax.inject.{Inject, Singleton}
//
//import dao.spec.QiitaClient
//import model.qiita.QiitaUser
//import play.api.libs.concurrent.Execution.Implicits.defaultContext
//import play.api.libs.json.Json
//import play.api.libs.ws.{WSClient, WSRequest}
//
//import scala.concurrent.Future
//import scala.concurrent.duration._
//
//@Singleton
//class QiitaClientImpl @Inject()(ws: WSClient) extends QiitaClient{
//
//  def getUsers():Future[Seq[QiitaUser]] ={
//    val url = "http://qiita.com/api/v2/users"
//    val complexRequest: WSRequest =
//      ws.url(url).withHeaders("Accept" -> "application/json")
//        .withRequestTimeout(10000.millis)
//        .withQueryString("page" -> "1", "per_page" -> "5")
//
//    complexRequest.get().map(res => {
//      val opt = Json.fromJson[Seq[QiitaUser]](res.json).asOpt
//      opt.get
//    })
//  }
//
//}
