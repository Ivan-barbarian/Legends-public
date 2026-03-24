::mods_hookExactClass("skills/racial/ghost_racial", function(o)
{	
	o.m.ArmorAdded <- 0;
	o.m.HelmetAdded <- 0;
	o.m.ArmorDifficultyMult <- 0.5;
	o.m.IsChamp <- false;

	o.onUpdate <- function (_properties)
	{
		_properties.DamageReceivedDirectMult *= 0.00; // ghosts don't have armor so this doesn't matter for regular ghosts, just ghost armor/wichts
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			_properties.Armor[this.Const.BodyPart.Head] += this.m.ArmorDifficultyMult * _properties.Armor[this.Const.BodyPart.Head];
			_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.ArmorDifficultyMult * _properties.ArmorMax[this.Const.BodyPart.Head];
			_properties.Armor[this.Const.BodyPart.Body] += this.m.ArmorDifficultyMult * _properties.Armor[this.Const.BodyPart.Body];
			_properties.ArmorMax[this.Const.BodyPart.Body] += this.m.ArmorDifficultyMult * _properties.ArmorMax[this.Const.BodyPart.Body];
		}
	}

	o.onCombatStarted <- function ()
	{
		this.m.ArmorAdded = 0;
		this.m.HelmetAdded = 0;
	}

	o.onCombatFinished <- function()
	{
		this.m.ArmorAdded = 0;
		this.m.HelmetAdded = 0;
	}

	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
			return;

		_hitInfo.DamageDirect = 0;
	}
});
