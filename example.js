//To run:
//      $ node example.js [your-hipchat-api-key] [word]

var HipchatExec = require('./hipchat-exec');
    
//pass the constructor a config object with your key
var key = process.argv[2];
var room_notification_key = process.argv[3];
var HCExec = new HipchatExec({
    token: key,
    notify_token: room_notification_key
    room: 'Room name or id',
    frequency: 4000,
    commands: {
        test: 'echo $NODE_ENV'
    }
});
HCExec.run();

