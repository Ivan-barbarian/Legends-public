::mods_hookExactClass("ai/tactical/agents/ghoul_agent", function(o)
{	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.m.Properties.TargetPriorityHittingAlliesMult = 3.0;
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
	}
});
