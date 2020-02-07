package com.rdp.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class ErrorController {
	
	  @RequestMapping(value = "404",method = RequestMethod.GET)
	  public String Page404(ModelMap model) {
	    return "error-404";
	  }
	    @RequestMapping(value = "500",method = RequestMethod.GET)
	    public String Page500(ModelMap model) {
	        return "error-500";
	    }

}
