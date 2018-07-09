;(function() {
	var base = MODULE_PATH + '/js/';

	AUI().applyConfig(
		{
			groups: {
				mymodulesoverride: {
					base: base,
					combine: Liferay.AUI.getCombine(),
					filter: Liferay.AUI.getFilterConfig(),
					modules: {
						'liferay-dynamic-data-mapping-override': {
							path: 'main.ext.js',
							condition: {
								name: 'liferay-dynamic-data-mapping-override',
								trigger: 'liferay-portlet-dynamic-data-mapping',
								when: 'instead'
							}
						},
						'liferay-portlet-dynamic-data-mapping-custom-fields-override': {
							path: 'custom_fields.ext.js',
							condition: {
								name: 'liferay-portlet-dynamic-data-mapping-custom-fields-override',
								trigger: 'liferay-portlet-dynamic-data-mapping-custom-fields'
							}
						}
					},
					root: base
				}
			}
		}
	);
})();