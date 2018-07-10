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
										Y.one('.${namespacedFieldName}').append('<option value="' + results[i]["${fieldStructure.restValue}"] + '">' + results[i]["${fieldStructure.restKey}"] + '</option>');
									}
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