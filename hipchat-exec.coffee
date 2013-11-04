http = require('http')
path = require('path')
Hipchatter = require('hipchatter')
sh = require('execSync')
  
# HipchatExec constructor
class HipchatExec
    constructor: (config)->
        @commands = {}
        @commands[cmd] = script for cmd, script of config.commands
        @token = config.token
        @frequency = config.frequency
        @room = config.room
        @hipchatter = new Hipchatter(@token)
    run: ->
        self = @
        setInterval (-> self.pollHipchat()), @frequency
    pollHipchat: ->
        @hipchatter.history @room, (err, history)->
            if err? then console.error 'Hipchat error '+err
            else console.log history


#export
module.exports = HipchatExec