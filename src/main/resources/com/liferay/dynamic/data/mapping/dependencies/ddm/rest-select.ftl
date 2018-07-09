<#include "../init-ext.ftl">

REST select
<#--
<#assign userLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.UserLocalService")>
<#assign multiple = false>
<#if fieldStructure.multiItem?? && (escape(fieldStructure.multiItem) == "true")>
	<#assign multiple = true>
</#if>

<@liferay_aui["field-wrapper"] data=data helpMessage=escape(fieldStructure.tip)>
	<#if fieldValue = "">
		<#assign values = []>
	<#else>
		<#assign values = fieldValue?split(",", "r")>
	</#if>
	<#assign users = userLocalService.getUsers(-1, -1)>

	<@liferay_aui.input cssClass=cssClass label=escape(label) name=namespacedFieldName type="text" value=fieldValue id="${namespacedFieldName}_hiddenUserList" style="display:none;">
		<#if required>
			<@liferay_aui.validator name="required" />
		</#if>
	</@liferay_aui.input>
<style>
	b {
		font-weight: bold;
	}
</style>
<div id="userContainer">
	<input type="text" id="${namespacedFieldName}_userInput" name="user_input" value="" title="Users" />
	<ul id="${namespacedFieldName}_userList" class="helper-clearfix textboxlistentry-holder unstyled"></ul>
</div>
<script type="text/javascript">
	YUI().use('autocomplete', 'autocomplete-highlighters', function(Y) {
				var users = [
                <#list users as user>
					<#assign value = user.screenName>
					<#assign label = user.fullName>
                    {displayname:"${value}",fullname:"${label} - ${value}"}<#if user_has_next>,</#if>
				</#list>
				];

				var defaultUsers =  [
                <#list values as user>
                    "${user}"<#if user_has_next>,</#if>
				</#list>
				];

				var selected = [];
				var clear = false;

				init();

				Y.one('#${namespacedFieldName}_userInput').plug(Y.Plugin.AutoComplete, {
					resultFilters: customFilter,
					resultHighlighter: 'phraseMatch',
					source: users,
					resultTextLocator: 'fullname',
					on: {
						select: function(event) {
							var item = event.result.raw;
							if (isUniqueInList(item.displayname)) {
                            <#if !multiple>
                                selected = [];
                                Y.one('[id="${namespacedFieldName}_userList"]').get('childNodes').remove();
							</#if>
								selected.push(item);

								updateHiddenUserList();

								addUserItem(item);

								addRemoveUserItemEvent(item);
							}
							clear = true;
						},
						activeItemChange: function(e) {
							if (clear) {
								clear = false;
								Y.one('#${namespacedFieldName}_userInput').set("value","");
							}

						}
					}
				});

				function init() {
					for(var i = 0; i < defaultUsers.length; i++) {
						var item = defaultUsers[i];
						var user = {displayname:item,fullname:item};

						for(var j = 0; j < users.length; j++) {
							if (users[j].displayname == item) {
								user = users[j];
								break;
							}
						}
						selected.push(user);

						addUserItem(user);

						addRemoveUserItemEvent(user);
					}
					updateHiddenUserList();
				}

				function customFilter(query, results) {
					query = query.toLowerCase();

					return Y.Array.filter(results, function (result) {
						return result.text.toLowerCase().indexOf(query) !== -1;
					});
				}

				function isUniqueInList(name) {
					var names = [];
					for(var i = 0; i < selected.length; i++) {
						names.push(selected[i].displayname);
					}
					return (names.indexOf(name) == -1);
				}

				function updateHiddenUserList() {
					var values = [];
					for(var i = 0; i < selected.length; i++) {
						values.push(selected[i].displayname);
					}
					Y.one('[id$="${namespacedFieldName}_hiddenUserList"]').set("value", values);
				}

				function addUserItem(item) {
					Y.one('[id="${namespacedFieldName}_userList"]').append('<li class="yui3-widget component textboxlistentry" id="${namespacedFieldName}_userItem_'+item.displayname+'"><span class="textboxlistentry-text">' + item.fullname + '</span><span class="textboxlistentry-remove"><i class="icon icon-remove"></i></span></li>');
				}

				function addRemoveUserItemEvent(item) {
					Y.one('[id="${namespacedFieldName}_userItem_'+item.displayname+'"] .textboxlistentry-remove').on("click", function (e) {
						Y.one('[id="${namespacedFieldName}_userItem_'+item.displayname+'"]').remove();
						var index = selected.indexOf(item);
						if (index > -1) {
							selected.splice(index, 1);
						}
						updateHiddenUserList();
					});
				}
			}
	);
</script>
</@>
-->