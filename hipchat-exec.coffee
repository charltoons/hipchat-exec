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
        runFunction = -> console.log 'test'
        setInterval runFunction, @frequency

#export
module.exports = HipchatExec