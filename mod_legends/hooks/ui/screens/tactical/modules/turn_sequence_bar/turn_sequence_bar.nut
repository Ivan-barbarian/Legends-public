::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function (o) {
	local _convertEntitySkillsToUIData = o.convertEntitySkillsToUIData;
	o.convertEntitySkillsToUIData = function (_entity) {
		if (!_entity.isPlayerControlled()) {
			return null;
		}

		local result = _convertEntitySkillsToUIData(_entity);

		foreach (item in _entity.querySwitchableItems()) {
			result.push({
				id = item.getInstanceID(),
				imagePath = "ui/items/" + item.getIcon(),
				isUsable = true,
				isAffordable = true
			});
		}

		return result;
	}

	o.updateEntity = function (_entityId) {
		if (this.m.CurrentEntities.len() == 0) {
			return;
		}

		local result = this.findEntityByID(this.m.AllEntities, _entityId);

		if (result != null
			&& !::Legends.S.isEntityNullOrDead(result.entity)
			&& result.entity.isPlacedOnMap())
		{
			this.Tooltip.reloadDataIfEqual(_entityId);
			this.Time.scheduleEvent(this.TimeUnit.Real, 10, function (_tag) {

				if (_tag.bar == null || _tag.bar.m.CurrentEntities.len() == 0) {
					return;
				}

				local resultUpdated = _tag.bar.findEntityByID(_tag.bar.m.CurrentEntities, _tag.EntityID);

				if (resultUpdated != null && !::Legends.S.isEntityNullOrDead(resultUpdated.entity) && resultUpdated.index < this.m.MaxVisibleEntities) {
					_tag.bar.m.JSHandle.call("updateEntity", _tag.bar.convertEntityToUIData(resultUpdated.entity));
				}

			}.bindenv(this), { bar = this, EntityID = _entityId });
		}
	}
});
