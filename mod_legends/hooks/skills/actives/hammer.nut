::mods_hookExactClass("skills/actives/hammer", function(o)
{
	o.m.IsMordhau <- false;

	o.setItem <- function (_item) {
		if (this.m.IsMordhau)
		{
			this.m.Name = "Mordhau";
			this.m.Description = "Grip your sword by the blade and strike with the guard and pommel for a strike that can be felt through the thickest of armor and will leave a lasting mark.";
			this.m.Icon = "skills/active_mordhau.png";
			this.m.IconDisabled = "skills/active_mordhau_bw.png";
			this.m.Overlay = "active_mordhau";
			this.m.ActionPointCost = 5;
		}
		this.skill.setItem(_item);
	}

	o.getTooltip = function ()
	{
		return this.getDefaultTooltip();
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageMinimum += 10;
			if (this.m.IsMordhau)
			{
				_properties.DamageArmorMult *= 2.0;
			}
		}
	}
});
