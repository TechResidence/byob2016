package model

import play.api.libs.json.Json

case class MyObj(id:Int, name:String)

object MyObj {
  //these implicit serve convert(Json <-> ScalaObject)
  implicit val writes = Json.writes[MyObj]
  implicit val reads = Json.reads[MyObj]
}