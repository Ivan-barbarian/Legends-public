this.legend_ardent_admirer_event <- this.inherit("scripts/events/event", {
m = {
		randombrother = null,
		adoringfan = null
	},
	function create()
	{
		this.m.ID = "legend_ardent_admirer";
		this.m.Title = "On the Road...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "Almost out of nowhere, a peculiar looking figure catches your eye. Clearly, you caught his too, because he smiles like he knows you and eagerly approaches, though if he did he would surely reconsider. Reflexively pommelling your sword with one hand and halting them with another, you call out and ask what on earth they want.\n\n\"It\'s- it\'s you! It really IS you! I thought it was, but now I\'m here I can see you up close in all your glory!\n\nTheir voice immediately forces an involuntary wince: it harbours an enthusiasm only seen in naive children and the hopelessly lovestruck, though he doesn\'t seem to be either. He\'s practically slack-jawed as he admires %randombrother%,all but worshipping the very ground %they_randombrother% occupy. You ask him who exactly \'we\' are, to which they jolt forward with a burst of sickening glee. \n\n\"Well, you\'re… I don\'t know your name, actually. That\'s %randombrother% the mighty, over there is %randombrother2% the invincible! But you\'re the captain of the %company%, only the most heroic and noble warriors in all the lands, and now you\'re here, standing before me!\"\n\nRight. While you wouldn\'t phrase it quite so poetically, the fool is correct about who you are. A number of the men are visibly upset by their presence, his whiny voice and unnaturally upbeat tone clearly triggering some primal unease, like looking at a corpse or someone very, very ill. Mercilessly, his grating voice begins again, this time enchanted with some gross mix of admiration and pleading. He remarks how he could clean and carry some of your equipment, but quickly abandons the prospect when seeing the lethal scowls of the company.\n\n\"I know! I can spread the word of your glorious deeds to the people of the world! People need to hear of the %company%\'s brilliant exploits. Your name will live on through the ages when I regale people of your achievements!\"\n\nA useful idiot is still useful, and you could let them go to spread the word of your \'glorious deeds\'. That said, some of the company already resemble hungry wolves, seemingly pushed by the fool\'s hideous voice and energy to a violent boil.\n",
			Image = "12",
			List = [],
			Options = [
				{
					Text = "Yes, spread the word of our prowess. Far away from here. ",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Can someone kill this fool already? ",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.randombrother.getImagePath());
				this.Characters.push(_event.m.adoringfan.getImagePath());
				this.Options.push({
					Text = "Yes, spread the word of our prowess. Far away from here. ",
					function getResult( _event )
					{
						return "";
					}
				});
				this.Options.push({
					Text = "Can someone kill this fool already? ",
					function getResult( _event )
					{
						return "";
					}
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "Your eagerness to shoo away this gnat of a man is met with groans by the company, quickly drowned out by an eager gasp from the starstruck fool. He moves to shake your hand, and it takes all your willpower to resist breaking the outstretched fingers like so much bramble. Catching the hint, he recoils his hand and punishes your mercy with more of his grating voice.\n\n%SPEECH_ON%Very well! I will travel, far and wide across all these lands to share the story of your troop and your legendary exploits. Soon, the whole world will call your name, uhhh… captain. Safe travels, my champion!%SPEECH_OFF%\n\nWith that, he turns and runs away to only gods know where. His peculiar gait and frankly absurd appearance marks him out as almost otherworldly, though you try not to dwell on it as you strive to put him out of your mind. It\'s only a matter of time before they end up with a knife between the ribs, or so you hope. Turning to the company, it\'s apparent many of the men wished it to be their knives repeatedly slotted between his ribs, but that opportunity quickly disappears with the strange man. %randombrother% rubs their forehead and thanks seemingly every god there is that they\'re gone. Blinking away the absurdity of the past few minutes, you order the men back on the road.",
			Image = "64",
			List = [],
			Options = [
				{
					Text = "I\'ve always wanted a fan club.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.randombrother.getImagePath());
				this.Characters.push(_event.m.adoringfan.getImagePath());
				this.Options.push({
					Text = "I\'ve always wanted a fan club.",
					function getResult( _event )
					{
						return 0;
					}
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%SPEECH_ON%Very well! I will- wait, wha-%SPEECH_OFF%\n\nMercifully, the fool\'s theatrical monologue is cut short with a swift jab from %randombrother% which launches him to the ground in a frankly absurd movement. Unfortunately, the strange man\'s rehearsed speech is replaced with twisted yelps and wails of pain which only invite more abuse from some of the company, who has fallen in around the crumpled mess of a man to offer him kicks and punches. One of the men loudly groans \'fark this\', and pulls a knife, looking to finish the job. A few deliberately messy stabs later, and the fool lays dead, their limbs splayed in almost every direction as their body takes on a bizarre form. Beside them, a pool of oozing crimson grows, and a few of the company sign their handiwork with a few hocks of spit and markedly unkind remarks, after relieving him of his belongings of course. %randombrother% rubs %their_randombrother% pate and says to no one in particular.\n\n%SPEECH_ON%Gods, man. Even killing him was irritating, it almost wasn\'t worth it. Almost.%SPEECH_OFF%\n\nAlmost indeed. While some of the men are simply relieved to be rid of such a blight on their ears, you catch a few with mean smirks, glancing back to the fresh body of their making. Either way, with the company\'s bloodlust satisfied and a pestering fool dispatched, you order the men back on to the road, content to let the vultures and wildlife clean up your mess.",
			Image = "46",
			List = [],
			Options = [
				{
					Text = "Never meet your heroes, I guess…",
					function getResult( _event )
					{
						return "";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.randombrother.getImagePath());
				this.Characters.push(_event.m.adoringfan.getImagePath());
				// Rewards
        //Couldnt include these on the Poss event frame, but rewards for options are as follow:
        //Accept the man's offer to spread the word (B), gain 50 renown, one brother receives Hangover, and everyone in the company has a 50% chance to receive a minor (0.5) mood penalty.
        //Description for mood penalty: "Had to suffer the blabbering of a starstruck fool."
        //Reject the offer, kill the man (C), 50% of the company receive a minor (1.0) mood boost.
        //Description for mood boost: "Satisfied to see an annoying fool gutted."
				{
          
					local __count = 1;
					for (local i = 0; i < __count; i++)
					{
						local item = this.new("scripts/items/weapons/dagger");
						this.World.Assets.getStash().add(item);
						this.List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName() });
					}
				}
				this.World.Assets.addMoney(0);
				this.List.push({ id = 10, icon = "ui/icons/asset_money.png", text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + 0 + "[/color] Crowns" });
				{
					local __count = 1;
					for (local i = 0; i < __count; i++)
					{
						local item = this.new("scripts/items/armour/cloth_tunic");
						this.World.Assets.getStash().add(item);
						this.List.push({ id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName() });
					}
				}
				this.Options.push({
					Text = "Never meet your heroes, I guess…",
					function getResult( _event )
					{
						return "";
					}
				});
			}

		});
	}


	function onPrepare()
	{
	}


	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.randombrother = null;
		this.m.adoringfan = null;
	}

});
