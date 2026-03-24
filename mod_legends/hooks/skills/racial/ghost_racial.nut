::mods_hookExactClass("skills/racial/ghost_racial", function(o)
{	
	o.m.ArmorAdded <- 0;
	o.m.HelmetAdded <- 0;

	o.onUpdate <- function (_properties)
	{
		_properties.DamageReceivedDirectMult *= 0.00; // ghosts don't have armor so this doesn't matter for regular ghosts, just ghost armor/wichts
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
