<#include "../init-ext.ftl">

<@liferay_aui["field-wrapper"] cssClass="form-builder-field" data=data>
	<div class="form-group">
		<@liferay_aui.select
			cssClass="${cssClass} ${namespacedFieldName}"
			helpMessage=escape(fieldStructure.tip)
			label=escape(label)
			name=namespacedFieldName
			required=required
		>
			<option></option>
		</@liferay_aui.select>
	</div>
</@>

<#if fieldStructure.restUrl?? && fieldStructure.restValue?? && fieldStructure.restKey??>
	<script type="text/javascript">
		YUI().use(
				'aui-io-request',
				'node',
				function(Y) {
					Y.io.request(
							'${fieldStructure.restUrl}',
							{
								dataType: 'json',
								on: {
									success: function () {
										var results = this.get('responseData');
										for (var i = 0; i < results.length; i++) {
											var value = results[i]["${fieldStructure.restValue}"];
											var label = results[i]["${fieldStructure.restKey}"];
											Y.one('.${namespacedFieldName}').append('<option value="' + value + '">' + label + '</option>');
										}
										Y.one('.${namespacedFieldName}').set("value", "${fieldValue}");
									}
								},
								data: {
									p_auth: Liferay.authToken
								}
							}
					);
				}
		);
	</script>
</#if>