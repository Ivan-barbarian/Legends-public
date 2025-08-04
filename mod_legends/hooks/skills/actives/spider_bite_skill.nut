::mods_hookExactClass("skills/actives/spider_bite_skill", function(o)
{
	o.m.IsRestrained <- false;
	o.m.IsSpent <- false;

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 40;
			_properties.DamageArmorMult *= 0.7;
		}
	}

	o.onUpdate = function( _properties )
	{
	}

	local onUse = o.onUse;
	o.onUse <- function( _user, _targetTile )
	{
		if (this.m.IsRestrained)
		{
			this.m.IsSpent = true;
			local skill = ::Legends.Actives.get(this, ::Legends.Active.Web);
			skill.setSpent(true);
		}
		return onUse(_user, _targetTile);
	}

	o.onTurnStart <- function()
	{
		this.m.IsSpent = false;
	}

	o.setRestrained <- function( _f )
	{
		this.m.IsRestrained = _f;
	}

	o.setSpent <- function( _f )
	{
		this.m.IsSpent = _f;
	}
});
