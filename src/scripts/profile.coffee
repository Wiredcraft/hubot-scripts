# Description
#   Store personal profile in hubot's brain, then later we can use it.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot profile remember <key> of <user> is <value>
#   hubot profile recall <user>
#   hubot profile recall <key> of <user>
#
# Author:
#   wiredcraft

module.exports = (robot) ->
  #
  robot.respond /profile\ remember\ (\w+)\ of\ (\w+)\ is\ ([\w|\d]+)*$/i, (msg) ->
  	key = msg.match[1].trim()
  	user = msg.match[2].trim()
  	value = msg.match[3].trim()

  	users = robot.brain.data.users

  	unless users[user]
  		msg.send 'Who is #{user}?'
  	else
  	    profile = users[user]['profile'] or {}
  	    profile[key] = value

  	    users[user]['profile'] = profile
  	    robot.brain.data.users = users

  	    msg.send 'I\' never forget'

  #
  robot.respond /profile\ recall\ (\w+)*$/i, (msg) ->
  	user = msg.match[1].trim()

  	unless robot.brain.data.users[user]
  		msg.send 'Who is #{user}?'
  	else
  	    unless robot.brain.data.users[user]['profile']
  	    	msg.send 'Not found profile'
  	    else
  	        response = "\n"
  	        profile = robot.brain.data.users[user]['profile']
           for own key, value of profile
               response += "#{key} #{value}"
               response += "\n"

               msg.send response

  #
  robot.respond /profile\ recall\ (\w+)\ of\ (\w+)*$/i, (msg) ->
  	key = msg.match[1].trim()
  	user = msg.match[2].trim()

  	unless robot.brain.data.users[user]
  		msg.send 'Who is #{user}?'
  	else
  	    unless robot.brain.data.users[user]['profile']
  	    	msg.send 'Not found profile'
  	    else
  	        profile = robot.brain.data.users[user]['profile']
  	        value = profile[key]

  	        unless value
  	        	msg.send '#{user} dose not has #{key}'
  	        else
               response = "#{value}"
               msg.send response