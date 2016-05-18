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

  robot.hear /(where can I find )?alibuild instructions/i, (res) ->
    res.send "They are at http://alisw.github.io/alibuild"

  robot.hear /(where can i find )?alibuild troubleshooting/i, (res) ->
    res.send "They are at http://alisw.github.io/alibuild/troubleshooting.html"

  robot.hear /(where is )?your knowledge/i, (res) ->
    res.send "My code is at https://github.com/alisw/alihubot . Feel free to modify me, e.g. at scripts/example.coffee, and open a PR."

  robot.respond /build ([^ ]+)/i, (res) ->
    user = "#{res.envelope.user}"
    if not robot.auth
      res.reply "Looks like the auth plugin is not installed"
      return

    if not robot.auth.hasRole(res.envelope.user, "builder")
      res.reply "Ehy, #{res.message.user.name}, you do not have the `builder' role. Please ask some admin to add you."
      return
    res.reply user
    pkg = res.match[1]
    tag = null
    architecture = "slc7_x86-64"
    if pkg.match "^vAN-20[0-9-]+$"
      res.reply "It's a daily. I cannot force build those, yet."
      return
    if pkg.match "^v[0-9]+-[0-9]+-[0-9]+[a-z]*$"
      overrides = "aliroot=#{pkg}"
      pkg = "AliRoot"
    if pkg.match "^v[0-9]+-[0-9]+-[0-9]+[a-z]*-[0-9]+$"
      # Determine AliRoot tag from aliphysics
      tag = pkg
      match = /^(v[0-9]+-[0-9]+-[0-9]+[a-z]*).*/i.exec pkg
      overrides  = "aliroot=#{match[1]} aliphysics=#{tag}"
      pkg = "AliPhysics"
    action = "Building package #{pkg}"
    if overrides
      action += " with overrides #{overrides}"
    res.reply "I do not know yet how to build jenkins scripts." +
              " If I did, I would however do the following: " + action

  robot.respond /deploy build infrastructure/, (res) ->
    if robot.auth.hasRole(res.envelope.user, "deployer")
      res.reply "Your are not allowed to deploy. Please ask an admin for the `deployer` role"
      return
    res.reply "Starting job deploy-build-infrastructure in jenkins"
    robot.jenkins.build("test-mesos")

  robot.respond /who is your creator/, (res) ->
    res.reply "I am a creation of Pdor, Pdor the great, son of Kmer, of the Ishtar tribe, from the lost land of Kfnir, one of the last 7 sages: Pfulur, Galér, Astaparigna, Sùsar, Param, Fusus and Tarìm."
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
