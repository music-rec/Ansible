var Ansible = require('node-ansible');

const TelegramBot = require('node-telegram-bot-api');
const token = '513434634:AAHhFY8i_vgavxEFI5cPfEro0_A1ore8gc4';

//Create a new bot
const bot = new TelegramBot(token, {polling: true});


bot.on('message', (msg) => {
  const chatId = msg.chat.id;

  // send a message to the chat acknowledging receipt of their message
     bot.sendMessage(chatId, 'Received your message');

	var cmd = msg.text.toString().toLowerCase();
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

