#!coffee
# Description:
#   Example scripts for you to examine and try out.
#
# Commands:
#   where can I find alibuild instructions? - Link to alibuild instructions
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
module.exports = (robot) ->
  robot.catchAll (msg) ->
    if msg.message.text.match(/^@?alibot.*/)
      msg.send (msg.random ["I don't know how to react to: \"#{msg.message.text}\".",
                           "I am not sure I understand.",
                           "Can you use different words?",
                           ]) + " You can ask me for help with `alibot: help`"

