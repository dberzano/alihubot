#!coffee
# Description:
#   Example scripts for you to examine and try out.
#
# Commands:
# Notes:
#   Catches all the messages which do not match any rule and which are
#   addressed to us.
module.exports = (robot) ->
  robot.catchAll (msg) ->
    if msg.message.text.match(/^@?alibot.*/)
      msg.send (msg.random ["I don't know how to react to: \"#{msg.message.text}\".",
                           "I am not sure I understand.",
                           "Can you use different words?",
                           ]) + " You can ask me for help with `alibot: help`"

