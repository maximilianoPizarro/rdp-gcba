package com.rdp.springmvc.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;
import com.rdp.springmvc.model.User;
import com.rdp.springmvc.model.UserProfile;
import com.rdp.springmvc.service.HostService;
import com.rdp.springmvc.service.UserProfileService;
import com.rdp.springmvc.service.UserService;

@Controller
@RequestMapping("/")
@SessionAttributes("usuario")
public class LoginController {

	@Autowired
	HostService hostService;

	@Autowired
	UserService usuarioService;

	@Autowired
	UserProfileService userProfileService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	JavaMailSender mailSenderObj;

	@Autowired
	ServletContext context;

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String login(ModelMap model) {
		User sessionUser = new User();
		model.addAttribute("user", sessionUser);
		return "index";
	}

	@RequestMapping(value = { "/bienvenido" }, method = RequestMethod.POST)
	public String autenticar(@Valid User user, BindingResult result, ModelMap model) {

		User sessionUser = usuarioService.usuarioExiste(user.getSsoId(), user.getPassword());

		if (sessionUser != null) {
			String lista = hostService.traerHostJson();
			model.addAttribute("listaHost", lista);
			model.addAttribute("usuario", sessionUser);

			model.addAttribute("rol", sessionUser.getRoles());
			// model.addAttribute("roles",usuario.getRol("ADMIN"));
			// model.addAttribute("roles",usuario.esAdmin());
			if (sessionUser.esAdmin()) {
				model.addAttribute("abm", true);
			}
			if (sessionUser.esCoordinador()) {
				model.addAttribute("coordinador", true);
			}
			
			if (sessionUser.esGerente()) {
				model.addAttribute("gerente", true);
				model.addAttribute("abm", true);
			}

			return "bienvenido";
		}

		result.addError(new FieldError("user", "password", messageSource.getMessage("Error.user.noexiste",
				new String[] { user.getSsoId() }, Locale.getDefault())));

		return "index";
	}

	@RequestMapping(value = { "/bienvenido/" }, method = RequestMethod.GET)
	public String volver(ModelMap model, WebRequest request) throws Exception {
		BindingResult result = null;
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			autenticar((User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION), result, model);
		} else {
			return "redirect:/index";
		}
		return "bienvenido";
	}
	
	
	

	@RequestMapping(value = { "/index" }, method = RequestMethod.GET)
	public String logout(WebRequest request, SessionStatus status) {
		status.setComplete();
		request.removeAttribute("usuario", WebRequest.SCOPE_SESSION);
		return "redirect:/";
	}

	@RequestMapping(value = { "/index-cambio-de-clave" }, method = RequestMethod.GET)
	public String cambioDeClave(@Valid User user, BindingResult result,ModelMap model, WebRequest request, SessionStatus status) {
		status.setComplete();
		request.removeAttribute("usuario", WebRequest.SCOPE_SESSION);
		model.addAttribute("enviado", true);
		model.addAttribute("success", "Usuario actualizado exitosamente ");
		return "index";
	}

	@RequestMapping(value = "/rec-cuenta", method = RequestMethod.POST)
	public String restaurar(@Valid User user, BindingResult result, ModelMap model) {

		final User usuario = usuarioService.findByEmail(user.getEmail());
		if (usuario != null) {
			final String email = usuario.getEmail();
			mailSenderObj.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws Exception {
					String sistema = "https://rdp-gcba.herokuapp.com/";
					MimeMessageHelper mimeMsgHelperObj = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					mimeMsgHelperObj.setTo(email);
					mimeMsgHelperObj.setFrom("agentedeplaya@gmail.com");
					mimeMsgHelperObj.setSubject("RDP - Restablecer Contraseña No responder");
					mimeMsgHelperObj.setText(
							"<table style='font-family:Arial;text-align:left;width:966px;height:85px' border='1' cellspacing='2' cellpadding='2'> <tbody> <tr> <td style='text-align:center'> <img style='width:80px;height:90px' alt='Logo GCABA' title='Logo GCABA' src='cid:Logo-BA' class='CToWUd'> </td> <td style='background-color:rgb(255,222,0);text-align:center'> <span style='font-size:24px'> <b>RDP</b> - Restablecer Contraseña </span> </td> </tr> <tr> <td style='text-align:justify' colspan='2'><b>Señor/a "
									+ usuario.getLastName() + ", " + usuario.getFirstName()
									+ "</b> <br> <br> Le informamos su nueva contraseña. <br> Usted puede ingresar a la aplicación <a href='"
									+ sistema + "'>" + sistema
									+ "</a> para cargar sus datos personales con la siguiente información: <br> <ul type='square'> <li> Usuario: <b>"
									+ usuario.getSsoId() + "</b><br> </li> <li> Contraseña: <b>" + usuario.getPassword()
									+ "</b> </li> </ul> Recomendamos iniciar sesión e inmediatamente cambiar la contraseña nuevamente desde la pantalla de perfil por una de su elección. <br> Saludos cordiales. <br> <br> <span style='font-size:12px'> <center> <b><u>ATENCIÓN</u></b>: El presente es un mensaje generado automaticamente por el <br> <b>Sistema de Registro de Computadoras</b> del <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b> y no debe ser respondido.<br> </center> </span> </td> </tr> <tr> <td style='text-align:center'> <img style='width:80px;height:90px' alt='Logo GCABA' title='Logo GCABA' src='cid:Logo-BA' class='CToWUd'> </td> <td style='background-color:rgb(255,222,0);text-align:center'> <span style='font-size:12px'> El Sistema de Registro de Computadoras es implementado en el marco de la <b>Iniciativa de la DGCACTYSV</b> <br>emprendida por el <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b>. </span> </td> </tr> </tbody> </table>",
							true);
					FileSystemResource res = new FileSystemResource(
							new File(context.getRealPath("/static/bastrap3/img/Logo.jpg")));
					mimeMsgHelperObj.addInline("Logo-BA", res);
				}
			});

			model.addAttribute("enviado", true);
			model.addAttribute("success", "Email enviado exitosamente!!");
		} else {
			model.addAttribute("errorEmail", true);
			model.addAttribute("danger", "No existe una cuenta asociada al email");
		}

		return "index";

	}

	// REST
	@RequestMapping(value = "/user/", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<User> traerUser(@RequestParam("id") String id) {
		User usuario = usuarioService.findById(Integer.valueOf(id));
		return new ResponseEntity<>(usuario, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = { "/autenticar/" }, method = RequestMethod.POST, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<User> existeUsuario(@RequestParam("ssoId") String ssoId,
			@RequestParam("password") String password) {
		User usuario = usuarioService.usuarioExiste(ssoId, password);
		return new ResponseEntity<>(usuario, HttpStatus.FOUND);
	}

}
