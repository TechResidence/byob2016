package controllers

import akka.actor.Actor
import model.MyObj

class JsonActor extends Actor {

  def receive = {
    case name: String => {
      val obj1 = MyObj(1, "uryyyyyyy")
      val obj2 = MyObj(2, name)
      sender() ! Seq(obj1, obj2)
    }

    case obj: MyObj => {
      sender() ! MyObj(obj.id, obj.name + " super")
    }
  }
}