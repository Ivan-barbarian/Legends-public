::mods_hookExactClass("skills/racial/ghost_racial", function(o)
{
	o.onUpdate <- function (_properties)
	{
		_properties.DamageReceivedDirectMult *= 0.00; // ghosts don't have armor so this doesn't matter for regular ghosts, just ghost armor/wichts
	}
});
