package com.liferay.dynamic.data.mapping.field.extender;

import java.util.Locale;

import org.osgi.service.component.annotations.Component;

import com.liferay.dynamic.data.mapping.render.BaseDDMFormFieldValueRenderer;
import com.liferay.dynamic.data.mapping.render.DDMFormFieldValueRenderer;
import com.liferay.dynamic.data.mapping.render.ValueAccessor;
import com.liferay.dynamic.data.mapping.storage.DDMFormFieldValue;

/**
 * This class tells Liferay how to render the user inside the overview list.
 * In this case, the value (a screen name) is converted to the users's full name.
 * If that fails or if the screen name is null or empty,
 */
@Component(immediate = true, service = DDMFormFieldValueRenderer.class)
public class RestSelectDDMFormFieldValueRenderer extends BaseDDMFormFieldValueRenderer {

	protected ValueAccessor getValueAcessor(Locale locale) {
		return new ValueAccessor(locale) {
			public String get(DDMFormFieldValue ddmFormFieldValue) {
				return ddmFormFieldValue.getValue().getString(locale);
			}
		};
	}

	public String getSupportedDDMFormFieldType() {
		return "ddm-rest-select";
	}
}