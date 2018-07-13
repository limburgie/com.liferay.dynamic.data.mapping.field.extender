package com.liferay.dynamic.data.mapping.field.extender;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.document.library.kernel.service.DLAppLocalService;
import com.liferay.dynamic.data.mapping.io.DDMFormJSONDeserializer;
import com.liferay.dynamic.data.mapping.io.DDMFormJSONSerializer;
import com.liferay.dynamic.data.mapping.io.DDMFormValuesJSONDeserializer;
import com.liferay.dynamic.data.mapping.io.DDMFormValuesJSONSerializer;
import com.liferay.dynamic.data.mapping.model.DDMFormField;
import com.liferay.dynamic.data.mapping.util.DDM;
import com.liferay.dynamic.data.mapping.util.DDMFormValuesToFieldsConverter;
import com.liferay.dynamic.data.mapping.util.FieldsToDDMFormValuesConverter;
import com.liferay.dynamic.data.mapping.util.impl.DDMImpl;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.service.ImageLocalService;
import com.liferay.portal.kernel.service.LayoutLocalService;
import com.liferay.portal.kernel.util.Http;
import com.liferay.portal.kernel.util.Portal;

@Component(
		immediate = true,
		property = {
				// Take precendence over the default DDMImpl implementation
				"service.ranking:Integer=100"
		},
		service = DDM.class
)
public class FieldExtenderDDMImpl extends DDMImpl {

	@Reference private Http _http;
	@Reference private Portal _portal;
	@Reference private DDMFormJSONDeserializer _ddmFormJSONDeserializer;
	@Reference private DDMFormJSONSerializer _ddmFormJSONSerializer;
	@Reference private DDMFormValuesJSONDeserializer _ddmFormValuesJSONDeserializer;
	@Reference private DDMFormValuesJSONSerializer _ddmFormValuesJSONSerializer;
	@Reference private DDMFormValuesToFieldsConverter _ddmFormValuesToFieldsConverter;
	@Reference private DLAppLocalService _dlAppLocalService;
	@Reference private FieldsToDDMFormValuesConverter _fieldsToDDMFormValuesConverter;
	@Reference private ImageLocalService _imageLocalService;
	@Reference private LayoutLocalService _layoutLocalService;

	/**
	 * These are all private fields which are injected with OSGi references in the DDMImpl superclass.
	 * We have to reflectively write to these fields in order to avoid getting NullPointerExceptions in the superclass' methods.
	 */
	@Activate
	public void activate() throws NoSuchFieldException, IllegalAccessException {
		setPrivateField("_http", _http);
		setPrivateField("_portal", _portal);
		setPrivateField("_ddmFormJSONDeserializer", _ddmFormJSONDeserializer);
		setPrivateField("_ddmFormJSONSerializer", _ddmFormJSONSerializer);
		setPrivateField("_ddmFormValuesJSONDeserializer", _ddmFormValuesJSONDeserializer);
		setPrivateField("_ddmFormValuesJSONSerializer", _ddmFormValuesJSONSerializer);
		setPrivateField("_ddmFormValuesToFieldsConverter", _ddmFormValuesToFieldsConverter);
		setPrivateField("_dlAppLocalService", _dlAppLocalService);
		setPrivateField("_fieldsToDDMFormValuesConverter", _fieldsToDDMFormValuesConverter);
		setPrivateField("_imageLocalService", _imageLocalService);
		setPrivateField("_layoutLocalService", _layoutLocalService);
	}

	private void setPrivateField(String fieldName, Object fieldValue) throws IllegalAccessException, NoSuchFieldException {
		Field httpField = getClass().getSuperclass().getDeclaredField(fieldName);
		httpField.setAccessible(true);
		httpField.set(this, fieldValue);
	}
	protected JSONArray getDDMFormFieldsJSONArray(List<DDMFormField> ddmFormFields, Set<Locale> availableLocales, Locale defaultLocale) {
		JSONArray jsonArray = super.getDDMFormFieldsJSONArray(ddmFormFields, availableLocales, defaultLocale);

		for(int i = 0; i < ddmFormFields.size(); i++) {
			JSONObject object = jsonArray.getJSONObject(i);
			DDMFormField ddmFormField = ddmFormFields.get(i);

			//TODO if custom DDM field attributes are used, put them on the JSONObject here.
			if ("ddm-rest-select".equals(ddmFormField.getType())) {
				object.put("restUrl", ddmFormField.getProperty("restUrl"));
				object.put("restKey", ddmFormField.getProperty("restKey"));
				object.put("restValue", ddmFormField.getProperty("restValue"));
			}
		}

		return jsonArray;
	}
}
