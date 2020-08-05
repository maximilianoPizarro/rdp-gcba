package com.rdp.springmvc.controller;

import java.util.List;
import java.util.Locale;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.WebRequest;

import com.rdp.springmvc.model.User;
import com.rdp.springmvc.model.UserProfile;
import com.rdp.springmvc.service.UserProfileService;
import com.rdp.springmvc.service.UserService;

@Controller
@RequestMapping("/abm-usuarios-rdp")
@SessionAttributes("roles")
public class AppController {

	@Autowired
	UserService userService;

	@Autowired
	UserProfileService userProfileService;

	@Autowired
	MessageSource messageSource;

	/**
	 * This method will list all existing users.
	 */

	@RequestMapping(value = { "/lista-de-usuarios" }, method = RequestMethod.GET)
	public String listUsers(ModelMap model, WebRequest request) {

		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			User tipoDeUsuario = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);
			if (tipoDeUsuario.esAdmin() || tipoDeUsuario.esGerente()) {
				//List<User> users = userService.findAllUsers();
				model.addAttribute("users", userService.findAllUsersJson());
				if(tipoDeUsuario.esAdmin())
					model.addAttribute("abm",true);
				return "userslist";
			} else {
				return "redirect:/index";
			}

		} else {
			return "redirect:/index";
		}
	}

	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/alta-de-usuario" }, method = RequestMethod.GET)
	public String newUser(ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			User user = new User();
			model.addAttribute("user", user);
			model.addAttribute("edit", false);
			return "registration";
		} else {
			return "redirect:/index";
		}
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/alta-de-usuario" }, method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*
		 * Preferred way to achieve uniqueness of field [sso] should be
		 * implementing custom @Unique annotation and applying it on field [sso]
		 * of Model class [User].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you
		 * can fill custom errors outside the validation framework as well while
		 * still using internationalized messages.
		 * 
		 */
		if (!userService.isUserSSOUnique(user.getId(), user.getSsoId())) {
			FieldError ssoError = new FieldError("user", "ssoId", messageSource.getMessage("non.unique.ssoId",
					new String[] { user.getSsoId() }, Locale.getDefault()));
			result.addError(ssoError);
			return "registration";
		}

		userService.saveUser(user);

		model.addAttribute("accion", true);
		model.addAttribute("success",
				"Usuario " + user.getFirstName() + " " + user.getLastName() + " registrado exitosamente");
		// return "success";
		return "redirect:/abm-usuarios-rdp/lista-de-usuarios";
	}

	/**
	 * This method will provide the medium to update an existing user.
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.GET)
	public String editUser(@PathVariable String ssoId, ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			User tipoDeUsuario = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);
			if (tipoDeUsuario.esAdmin() || tipoDeUsuario.esGerente()) {
				User user = userService.findBySSO(ssoId.substring(1, ssoId.length() - 1));
				model.addAttribute("user", user);
				model.addAttribute("edit", true);
				return "registration";
			} else {
				return "redirect:/index";
			}
		} else {
			return "redirect:/index";
		}
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result, ModelMap model, @PathVariable String ssoId) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*
		 * //Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in
		 * UI which is a unique key to a User.
		 * if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
		 * FieldError ssoError =new
		 * FieldError("user","ssoId",messageSource.getMessage(
		 * "non.unique.ssoId", new String[]{user.getSsoId()},
		 * Locale.getDefault())); result.addError(ssoError); return
		 * "registration"; }
		 */
		user.setSsoId(ssoId.substring(1, ssoId.length() - 1));
		userService.updateUser(user);

		model.addAttribute("accion", true);
		model.addAttribute("success",
				"Usuario " + user.getFirstName() + " " + user.getLastName() + " actualizado exitosamente ");
		return "redirect:/abm-usuarios-rdp/lista-de-usuarios";
	}

	/**
	 * This method will delete an user by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-user-{ssoId}" }, method = RequestMethod.GET)
	public String deleteUser(@PathVariable String ssoId, ModelMap model) {
		userService.deleteUserBySSO(ssoId.substring(1, ssoId.length() - 1));
		model.addAttribute("accion", true);
		model.addAttribute("success", "Usuario " + ssoId.substring(1, ssoId.length() - 1) + " eliminado exitosamente");
		return "redirect:/abm-usuarios-rdp/lista-de-usuarios";
	}

	/**
	 * This method will provide UserProfile list to views
	 */
	@ModelAttribute("roles")
	public List<UserProfile> initializeProfiles() {
		return userProfileService.findAll();
	}

}
