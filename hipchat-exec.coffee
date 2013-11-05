http = require('http')
path = require('path')
Hipchatter = require('hipchatter')
exec = require('child_process').exec
  
# HipchatExec constructor
class HipchatExec
    constructor: (config)->
        @commands = {}
        @commands[cmd] = script for cmd, script of config.commands
        @token = config.token
        @notify_token = config.notify_token
        @frequency = config.frequency
        @room = config.room
        @hipchatter = new Hipchatter(@token)
        @last = new Date
    run: ->
        self = @
        setInterval (-> self.pollHipchat()), @frequency
    pollHipchat: ->
        self = @
        @hipchatter.history @room, (err, history)->
            if err? then console.error 'Hipchat error '+err
            else 
                # for all the messages in the found history
                for item in history.items

                    # only check messages that we havent checked 
                    # since the global process started
                    date = new Date item.date
                    if date > self.last 
                        self.last = date

                        # check each of the commands to see if they match
                        for cmd, script of self.commands

                            # console.log 'checking '+cmd+' in '+item.message

                            # if we have a match (someone issued the command)
                            if item.message is cmd

                                # run the script
                                console.log 'Command: '+cmd
                                message = 'Received: <strong>'+cmd+'</strong><br />Running: <code>'+script+'</code>'
                                self.hipchatter.notify self.room, message, self.notify_token, (err, response)->
                                    if err? then console.error 'Message error', err
                                    else console.log 'Message successful: '+message
                                exec script, (err, stdout, stderr)->
                                    if err? then console.error 'Command error '+err
                                    console.log stdout
                                    console.error stderr




#export
module.exports = HipchatExec