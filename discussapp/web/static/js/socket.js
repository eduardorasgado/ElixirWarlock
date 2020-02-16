// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

/**
 * Steps to perform a web socket connection
 * 
 * 1 ) conencting to socket
 * 
 */
socket.connect()

// 2 ) client socket performs a connection to comments channel
// let channel = socket.channel("topic:subtopic", {})
let channel = socket.channel("comments:1", {})

// 5 ) receiving the map and acting in server side by returning a message and the
// map content
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
