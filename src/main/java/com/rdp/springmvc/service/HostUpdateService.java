package com.rdp.springmvc.service;

import java.util.List;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.HostUpdate;
import com.rdp.springmvc.model.User;

public interface HostUpdateService {
	
	void saveHost(HostUpdate hostUpdate);
	
}
