this.legend_swordmaster_fav_enemy_event <- this.inherit("scripts/events/event", {
	m = {
		Stats = null,
		MinStrength = 100,
		Candidates = null,
		Champion = null,
		Flags = null,
		Perk = ::Legends.Perks.getID(::Legends.Perk.LegendFavouredEnemySwordmaster),
		ValidTypes = this.Const.LegendMod.FavoriteSwordmaster,
		WasInReserves = [],
		isValidForEncounter = false
	},
	function create()
	{
		this.m.ID = "event.legend_swordmaster_fav_enemy";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_134.png[/img]{Marching through countryside. Your feet are still tired from the strain of the last few days. Your marching is interrupted by a lean, young and eager looking fellow.%SPEECH_ON%Stop right there, rabble!%SPEECH_OFF% He shouts to you and your company. Slightly confused, your mercenaries throw glances to each other, raising their shoulders. %randombrother% replies, slightly amused.%SPEECH_ON%What in the hells do you think you're doing, you little wanker? Those rabble you\'re talking to will cut your throat just for fun. Didn\'t your parents teach you any common sense?%SPEECH_OFF%Carelessly, the young fellow proceeds. %SPEECH_ON%My name is %enemyname%. Looks like it is I who will have to teach you some common sense. It is I who decide which throats get cut! One more insolent comment like that from any of you, and I\'ll have you all hanged!%SPEECH_OFF% Your mercenaries start to fall in laughter. %randombrother2% replies with an angry voice. %SPEECH_ON% Ha. You? I don\'t see your army. Or is it the lordship himself, which wants to do all the dirty work, hm? Come here and try me.%SPEECH_OFF% %enemyname% answers. %SPEECH_ON% It is not you I want to fight. It is %chosen%. I heard %they're_champion% a good fighter. I want to beat %them_champion%. In the glory of my name, I demand a fight to life or death!%SPEECH_OFF% The haughty juvenile raises his weapon, pointing it toward %chosen%. \n\n Despite the fact that a couple meters separate %enemyname% and %chosen%, you can feel the tension in the air.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "While marching...";

				foreach( bro in _event.m.Candidates )
				{
					_event.m.Candidates.sort(function ( _a, _b )
					{
						if (_a.getXP() > _b.getXP())
						{
							return -1;
						}
						else if (_a.getXP() < _b.getXP())
						{
							return 1;
						}

						return 0;
					});
				}

				local e = this.Math.min(4, _event.m.Candidates.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "Alright " + bro.getName() + ", teach this little wanker a lesson.",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "N";
						}

					});

				}

				this.Options.push({
					Text = "Leave him alone. Slaughtering a kid wont bring us any fame.",
					function getResult( _event )
					{
						return 0;
					}

				});
				_event.m.Champion = _event.m.Candidates[this.Math.rand(0, _event.m.Candidates.len() - 1)];
				_event.m.Flags.set("EnemyChampionName", this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]);
			}

		});
		this.m.Screens.push({
			ID = "N",
			Text = "[img]gfx/ui/events/event_35.png[/img]{%chosen% heads off to confront %enemyname% while the rest of the company observes from a distance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "",
					function getResult( _event )
					{
						local r = this.Math.rand(0, 2);
						local name = _event.m.Flags.get("EnemyChampionName");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.NobleTracks;
						properties.Entities = [];

						if (r == 0)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.Swordmaster,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/humans/swordmaster",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (r == 1)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.BanditLeader,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/enemies/bandit_leader",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (r == 2)
						{
							properties.Entities.push({
								ID = this.Const.EntityType.HedgeKnight,
								Variant = 1,
								Row = 0,
								Name = name,
								Script = "scripts/entity/tactical/humans/hedge_knight",
								Faction = this.Const.Faction.Enemy,
								function Callback( _entity, _tag )
								{
									_entity.setName(name);
								}

							});
						}

						if (_event.m.Champion.isInReserves())
						{
							_event.m.WasInReserves.push(_event.m.Champion);
							_event.m.Champion.setInReserves(false);
						}

						properties.Players.push(_event.m.Champion);
						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						properties.IsAttackingLocation = true;
						properties.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = x )
							{
								for( local y = 0; y < size.Y; y = y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									y = ++y;
								}

								x = ++x;
							}
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(properties, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "The duel!";
				this.Options[0].Text = "You can take him, %chosen%!";
				this.Characters.push(_event.m.Champion.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_96.png[/img]{%chosen% stands victorious over the badly wounded %enemyname%. The defeated nobleman can barely catch his breath. Every gasp of air comes with great pain for him. Bleeding and shaking, he is soon to depart from the world of the living. The duel was meant to be to the death but %chosen% does not deliver a final blow. The rest of your mercenaries gather around the winner. Most of the company is cheering the now glorious %chosen%, but some are more concerned about the unfinished business laying on the ground in a pool of his own blood. %randombrother% speaks up with strong contempt for the loser of this duel. %SPEECH_ON%What are you waiting for %chosen%? You think this whipster would show you mercy?%SPEECH_OFF% The company champion answers. %SPEECH_ON%I will take his equipment as spoils, but he's no good to me dead.%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You did well, %chosen%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				this.Characters.push(_event.m.Champion.getImagePath());
				this.World.Assets.addBusinessReputation(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/special.png",
						text = "The company gained renown"
					}
				];

				if (_event.m.Champion.getBaseProperties().MeleeSkill < 100)
				{
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Champion, ::Math.rand(1, 3)));
				}

				if (_event.m.Champion.getBaseProperties().MeleeDefense < 50)
				{
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					::Legends.EventList.changeMeleeDefense(_event.m.Champion, ::Math.rand(1, 3));
				}

				if (_event.m.Champion.getMoodState() >= this.Const.MoodState.Neutral) {
					this.List.push(::Legends.EventList.changeMood(_event.m.Champion));
				}

				_event.m.Champion.getSkills().update();
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) && this.Math.rand(1, 100) <= 33) {
						bro.improveMood(0.5, "The company\'s champion won an impressive duel");
					}

					if (bro.getMoodState() > this.Const.MoodState.Neutral) {
						this.List.push(::Legends.EventList.changeMood(bro));
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_58.png[/img]{%enemyname% emerges victorious from the duel. Winning this fight made him even more eager and confident. Looks like he wants to fight everybody in the company, one by one. With a voice full of pride he shouts to your men. %SPEECH_ON%Who\'s  next ?!%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				foreach( bro in _event.m.Candidates )
				{
					_event.m.Candidates.sort(function ( _a, _b )
					{
						if (_a.getXP() > _b.getXP())
						{
							return -1;
						}
						else if (_a.getXP() < _b.getXP())
						{
							return 1;
						}

						return 0;
					});
				}

				local e = this.Math.min(4, _event.m.Candidates.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "I need you to avenge us, " + bro.getName() + ".",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "N";
						}

					});
				}

				this.Options.push({
					Text = "This isn\'t worth it. We should leave.",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 8 && !t.isIsolated()) // WAS 10
			{
				town = t;
				break;
			}
		}

		if (town == null)
		{
			return;
		}

		local candidates = [];

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (!bro.getSkills().hasPerk(::Legends.Perk.LegendFavouredEnemySwordmaster)) // perk check
				continue;

			if (bro.getLevel() < 11) // level check
				continue;

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, this.Const.LegendMod.FavoriteSwordmaster);

			for( ; stats.Strength < this.m.MinStrength;  )
			{
				this.logInfo("BRO " + bro.getName() + " Min strength < m.MinStrength : " + stats.Strength);
			}

			this.m.Stats = this.Math.floor(stats.Strength);
			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Candidates = candidates;
		this.m.Score = 9999 + this.m.Stats * 0.1;

		this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
		this.m.Score = 0; // this disables event from happening normally
	}

	function onPrepare()
	{
		this.m.Flags = this.new("scripts/tools/tag_collection");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"chosen",
			this.m.Champion != null ? this.m.Champion.getName() : ""
		]);
		_vars.push([
			"enemyname",
			this.m.Flags != null ? this.m.Flags.get("EnemyChampionName") : ""
		]);
	}

	function onDetermineStartScreen()
	{
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.7)
			return "A";
		return "A";
	}

	function onClear()
	{
		this.m.Stats = null;
		this.m.Champion = null;
		this.m.MinStrength = null;
		this.m.Perk = null;
		this.m.ValidTypes = null;
		foreach (bro in this.m.WasInReserves)
		{
			bro.setInReserves(true);
		}

		this.m.WasInReserves.clear();
	}

});
