//To run:
//      $ node example.js [your-hipchat-api-key] [word]

var HipchatExec = require('./hipchat-exec');
    
//pass the constructor a config object with your key
var key = process.argv[2];
var HCExec = new HipchatExec({
    token: key,
    room: 'Projeqt Command Test',
    frequency: 4000,
    commands: {
        test: 'echo $NODE_ENV'
    }
});
HCExec.run();

