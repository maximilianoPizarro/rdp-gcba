package com.rdp.springmvc.converter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.rdp.springmvc.model.HostArea;
import com.rdp.springmvc.model.UserProfile;
import com.rdp.springmvc.service.AreaService;
import com.rdp.springmvc.service.UserProfileService;

/**
 * A converter class used in views to map id's to actual areaHost objects.
 */
@Component
public class AreaToHostAreaConverter implements Converter<Object, HostArea>{

	@Autowired
	AreaService areaService;

	/**
	 * Gets UserProfile by Id
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	public HostArea convert(Object element) {
		Integer id = Integer.parseInt((String)element);
		HostArea area= areaService.findById(id);
		System.out.println("Area : "+area);
		return area;
	}
	
}