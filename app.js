var Ansible = require('node-ansible');

const TelegramBot = require('node-telegram-bot-api');
const token = '513434634:AAHhFY8i_vgavxEFI5cPfEro0_A1ore8gc4';


const bot = new TelegramBot(token, {polling: true});


bot.on('message', (msg) => {
        const chatId = msg.chat.id;

        bot.sendMessage(chatId, 'Received your message');

        var cmd = msg.text.toString().toLowerCase();
                bot.onText(/\/restart/, (msg) => {

        bot.sendMessage(msg.chat.id, "Click options on Screen Telegram, Please!!!", {
        "reply_markup": {
        "keyboard": [["restart wowza03", "restart wowza04", "restart wowza05", "restart wowza15"],["restart wowza16", "restart wowza17", "restart wowza18", "restart wowza19"]
                           ,["restart wowza20", "restart wowza21", "restart wowzagw01"], ["No, Thanks"] ]
           }
      });

});
        if (cmd.indexOf('restart') === 0) {
                var values = cmd.split(" ");
                if (values.length !== 2) {
                        return bot.sendMessage(chatId, 'Wrong input');
                }

                var playbook = new Ansible.Playbook().playbook('/etc/ansible/playbooks/wowza-edge/telegram/restart_'+values[1]);

                var promise = playbook.exec();
                promise.then(function(successResult) {
                        console.log(successResult.code); // Exit code of the executed command
                        console.log(successResult.output) // Standard output/error of the executed command
                        bot.sendMessage(chatId, 'Done restart!!!');
                }, function(error) {
                console.log('******************************');
                  console.error(error);
                console.log('******************************');
                        bot.sendMessage(chatId, 'Restart Server failed. Are you restart Server again?');
                });
        }

});

bot.on('polling_error', (error) => {
  console.log(error.code);  // => 'EFATAL'
  console.log(error);  // => 'EFATAL'
});

