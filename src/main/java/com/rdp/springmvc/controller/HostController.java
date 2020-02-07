package com.rdp.springmvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;
import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.HostArea;
import com.rdp.springmvc.model.HostUpdate;
import com.rdp.springmvc.model.User;
import com.rdp.springmvc.model.UserProfile;
import com.rdp.springmvc.service.AreaService;
import com.rdp.springmvc.service.HostService;
import com.rdp.springmvc.service.HostUpdateService;
import com.rdp.springmvc.service.MovimientoService;
import com.rdp.springmvc.service.UserProfileService;
import com.rdp.springmvc.service.UserService;

@Controller
@RequestMapping("/abm-host")
@SessionAttributes("roles")
public class HostController {

	@Autowired
	HostService hostService;

	@Autowired
	HostUpdateService hostUpdateService;

	@Autowired
	UserService usuarioService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	AreaService areaService;

	@Autowired
	MovimientoService movimientoService;

	@Autowired
	JavaMailSender mailSenderObj;

	@Autowired
	ServletContext context;

	/**
	 * This method will list all existing users.
	 */

	@RequestMapping(value = { "/lista-de-host" }, method = RequestMethod.GET)
	public String listHost(ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			String lista = hostService.traerHostJson();
			System.out.println(lista);
			model.addAttribute("listaHost", lista);
			return "bienvenido";
		} else {
			return "redirect:/index";
		}
	}

	//solo usuarios nivel gerencia
	@RequestMapping(value = { "/lista-de-equipos/" }, method = RequestMethod.GET)
	public String listaDeHost(ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			String lista = hostService.traerHostJson();
			//System.out.println(lista);
			model.addAttribute("listaHost", lista);
			model.addAttribute("gerente", true);
			model.addAttribute("abm", true);
			model.addAttribute("rol", "Gerencia");
			return "hostlist";
		} else {
			return "redirect:/index";
		}
	}

	@RequestMapping(value = { "/movimiento-host-{mac}" }, method = RequestMethod.GET)
	public String listMovimientosMac(ModelMap model, @PathVariable String mac, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			String lista = movimientoService.traerMovimientoMacJson(mac.substring(1, mac.length() - 1));
			model.addAttribute("listaHost", lista);
			return "movimientos";
		} else {
			return "redirect:/index";
		}

	}

	@RequestMapping(value = { "/host-movimientos/" }, method = RequestMethod.GET)
	public String listMovimientos(ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {

			String lista = movimientoService.traerMovimientoJson();
			model.addAttribute("listaHost", lista);

			return "movimientos";

		} else {
			return "redirect:/index";
		}

	}

	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/alta-de-host/" }, method = RequestMethod.GET)
	public String newHost(ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			Host host = new Host();
			model.addAttribute("host", host);
			model.addAttribute("edit", false);
			return "registration-host";
		} else {
			return "redirect:/index";
		}
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving user in database. It also validates the user input
	 * 
	 * @throws InterruptedException
	 */
	@RequestMapping(value = { "/alta-de-host/" }, method = RequestMethod.POST)
	public String saveHost(@Valid Host host, BindingResult result, ModelMap model, WebRequest request)
			throws InterruptedException {
		int id = 0;
		if (result.hasErrors()) {
			return "registration-host";
		}

		if (hostService.findByMAC(host.getMac()) != null) {
			FieldError ssoError = new FieldError("host", "mac",
					messageSource.getMessage("non.unique.mac", new String[] { host.getMac() }, Locale.getDefault()));
			result.addError(ssoError);
			return "registration-host";
		}
		User usuario = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);
		host.setObservacion("Alta de Host");
		host.setLoginultimomov(usuario.getId());
		hostService.saveHost(host);
		Thread.sleep(2000);
		if (hostService.findByMAC(host.getMac()) != null) {
			id = hostService.findByMAC(host.getMac()).getIdhost();
			Thread.sleep(2000);
			hostUpdateService.saveHost(new HostUpdate(new GregorianCalendar(), Integer.valueOf(id), "S/D"));
		}
		model.addAttribute("accion", true);
		model.addAttribute("success", "Host " + host.getRed_host() + " registrado exitosamente"); 

		return "redirect:/bienvenido/";
	}

	/**
	 * This method will provide the medium to update an existing user.
	 */
	@RequestMapping(value = { "/edit-host-{mac}" }, method = RequestMethod.GET)
	public String editHost(@PathVariable String mac, ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			Host host = hostService.findByMAC(mac.substring(1, mac.length() - 1));
			host.setMac(mac.substring(1, mac.length() - 1));
			model.addAttribute("host", host);
			model.addAttribute("edit", true);
			return "registration-host";

		} else {
			return "redirect:/index";
		}

	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/edit-host-{mac}" }, method = RequestMethod.POST)
	public String updateHost(@Valid Host host, BindingResult result, ModelMap model, @PathVariable String mac,
			WebRequest request) {

		if (result.hasErrors()) {
			return "bienvenido";
		}
		User usuario = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);

		host.setMac(mac.substring(1, mac.length() - 1));
		host.setObservacion("Actualizacion de contenido");
		host.setLoginultimomov(usuario.getId().longValue());
		hostService.updateHost(host);
		model.addAttribute("accion", true);
		model.addAttribute("success", "Host " + host.getRed_host() + " actualizado exitosamente ");
		return "redirect:/bienvenido/";
	}

	@RequestMapping(value = { "/observaciones-host-{mac}" }, method = RequestMethod.GET)
	public String observacionesHost(ModelMap model, WebRequest request, @PathVariable String mac,
			@RequestParam("observa") String observaciones) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {

			Host host = hostService.findByMAC(mac.substring(1, mac.length() - 1));
			User usuario = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);

			host.setObservacion(observaciones);
			host.setLoginultimomov(usuario.getId().longValue());

			System.out.println(host);

			hostService.updateHost(host);
			model.addAttribute("accion", true);
			model.addAttribute("success", "Host " + host.getRed_host() + " actualizado exitosamente ");
			return "redirect:/bienvenido/";
		} else {
			return "redirect:/index";
		}

	}

	/**
	 * This method will delete an user by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-host-{mac}" }, method = RequestMethod.GET)
	public String deleteHost(@PathVariable String mac, ModelMap model, WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {

			movimientoService.deleteMovimientoByMAC(mac.substring(1, mac.length() - 1));
			hostService.deleteHostByMAC(mac.substring(1, mac.length() - 1));
			model.addAttribute("accion", true);
			model.addAttribute("success", "Host " + mac.substring(1, mac.length() - 1) + " eliminado exitosamente");
			return "redirect:/bienvenido/";
		} else {
			return "redirect:/index";
		}
	}

	@ModelAttribute("areas")
	public List<HostArea> initializeProfiles() {
		return areaService.traerAreas();
	}

	// REST

	@RequestMapping(value = "/host/", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Host> traerHostId(@RequestParam("id") String id) {
		Host host = hostService.findById(Integer.valueOf(id));
		return new ResponseEntity<>(host, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = "/host-mac/", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Host> traerHost(@RequestParam("mac") String mac) {
		Host host = hostService.findByMAC(mac);
		return new ResponseEntity<>(host, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = "/host-alta/", method = RequestMethod.POST, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Integer> agregarHost(@RequestParam("host") String host, @RequestParam("ip") String ip)
			throws InterruptedException {
		int id = 0;
		Host h = new Gson().fromJson(host, Host.class);
		System.out.println(h);
		h.setObservacion("Alta de Host");
		h.setLoginultimomov(h.getLoginultimomov());
		hostService.saveHost(h);
		Thread.sleep(2000);
		if (hostService.findByMAC(h.getMac()) != null) {
			id = hostService.findByMAC(h.getMac()).getIdhost();
			Thread.sleep(2000);
			hostUpdateService.saveHost(new HostUpdate(new GregorianCalendar(), Integer.valueOf(id), ip));
		}

		return new ResponseEntity<>(id, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = "/host-update/", method = RequestMethod.POST, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Boolean> updateHost(@RequestParam("host") String host) throws InterruptedException {
		boolean respuesta = false;
		Host h = new Gson().fromJson(host, Host.class);
		h.setObservacion("Modificación de Host");
		h.setLoginultimomov(h.getLoginultimomov());
		hostService.updateHost(h);
		Thread.sleep(2000);
		respuesta = true;

		return new ResponseEntity<>(respuesta, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = "/host-last-update/", method = RequestMethod.POST, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Boolean> lastUpdateHost(@RequestParam("host") String host) throws InterruptedException {
		boolean respuesta = false;
		HostUpdate h = new Gson().fromJson(host, HostUpdate.class);
		h.setFechahoramov(new GregorianCalendar());
		hostUpdateService.saveHost(h);
		Thread.sleep(2000);
		respuesta = true;

		return new ResponseEntity<>(respuesta, HttpStatus.FOUND);// 302
	}

	@RequestMapping(value = "/enviar-email-update/", method = RequestMethod.POST, produces = {
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<Boolean> reportarCambios(@RequestParam("hostSinModificar") String hostSinModificar,
			@RequestParam("hostMemoria") String hostMemoria) throws InterruptedException {
		boolean respuesta = false;
		final Host equipo = new Gson().fromJson(hostSinModificar, Host.class);
		final Host equipoModificado = new Gson().fromJson(hostMemoria, Host.class);

		final String email = usuarioService.traerEmailGerencia();
		mailSenderObj.send(new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws Exception {
				String sistema = "10.68.11.218:8080/RDP/";
				MimeMessageHelper mimeMsgHelperObj = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				mimeMessage.setRecipients(Message.RecipientType.CC, InternetAddress.parse(email));

				mimeMsgHelperObj.setFrom("agentedeplaya@gmail.com");
				mimeMsgHelperObj.setSubject("RDP - Informe de cambios");
				mimeMsgHelperObj.setText(
						"<table style='font-family: Arial; text-align: left; width: 966px; height: 85px'border='1' cellspacing='2' cellpadding='2'><tbody><tr><td style='text-align: center'><img style='width: 80px; height: 90px' alt='Logo GCABA'title='Logo GCABA' src='cid:Logo-BA'  class='CToWUd'></td><td style='background-color: rgb(255, 222, 0); text-align: center'><span style='font-size: 24px'> <b>RDP</b> - Informe de Cambios</span></td></tr><tr><td style='text-align: justify' colspan='2'><br><b>Estimados Señores/as</b> <br><br> Le informamos sobre los siguientes cambios en el equipo "
								+ equipo.getRed_host()
								+ " <br> Usted puede ingresar a la aplicación para ver el historial completo: <br><ul type='square'><li>Equipo sin modificar: <br><br>"
								+ equipo.toStringMail() + "<b></b><br><br></li><li>Equipo modificado: <br><br>"
								+ equipoModificado.toStringMail()
								+ "<b></b></li></ul> <br>Saludos cordiales. <br> <br> <span style='font-size: 12px'><center><b><u>ATENCIÓN</u></b>: El presente es un mensaje generado automaticamente por el <br> <b>Sistema de Registro de Computadoras</b> del <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b> y no debe ser respondido.<br></center></span></td></tr><tr><td style='text-align: center'><img style='width: 80px; height: 90px' alt='Logo GCABA'title='Logo GCABA' src='cid:Logo-BA' class='CToWUd'></td><td style='background-color: rgb(255, 222, 0); text-align: center'><span style='font-size: 12px'> El Sistema de Registro de Computadoras es implementado en el marco de la <b>Iniciativa de la DGCACTYSV</b> <br>emprendida por el <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b>.</span></td></tr></tbody></table>",
						true);

				FileSystemResource res = new FileSystemResource(
						new File(context.getRealPath("/static/bastrap3/img/Logo.jpg")));
				mimeMsgHelperObj.addInline("Logo-BA", res);
			}
		});
		respuesta = true;
		return new ResponseEntity<>(respuesta, HttpStatus.FOUND);// 302
	}

}
