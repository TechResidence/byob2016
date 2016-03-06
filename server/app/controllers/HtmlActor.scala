package controllers

import akka.actor.Actor

class HtmlActor extends Actor {

  def receive = {
    case name: String => {
      sender() ! "hello" + name
    }
  }
}