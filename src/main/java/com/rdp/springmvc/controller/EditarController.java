package com.rdp.springmvc.controller;

import java.io.File;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;

import com.rdp.springmvc.model.User;
import com.rdp.springmvc.service.HostService;
import com.rdp.springmvc.service.UserService;

@Controller
@RequestMapping("/editar")

public class EditarController {
	
	@Autowired
	HostService hostService;

	@Autowired
	UserService usuarioService;
	
	@Autowired
	JavaMailSender mailSenderObj;
	
	@Autowired
	ServletContext context; 
	
	@RequestMapping(value = "/editar-perfil/" , method = RequestMethod.GET)
	public String editar(ModelMap model,WebRequest request) {
		if (request.getAttribute("usuario", WebRequest.SCOPE_SESSION) != null) {
			User user = (User) request.getAttribute("usuario", WebRequest.SCOPE_SESSION);
			model.addAttribute("rol",user.getRoles());
			model.addAttribute("user", user);
			return "perfil";
		}else {
		return "redirect:/index";
	}

	}
	
	@RequestMapping(value = { "/editar-perfil/" }, method = RequestMethod.POST)
	public String actualizarUsuario(@Valid User user, BindingResult result,
			ModelMap model, WebRequest request) {
		
		if(!user.getEmail().isEmpty()){
		usuarioService.actualizarUsuario(user);	
		User usuario = usuarioService.findById(user.getId());
		
		alertaEmail("cambio de contraseña",usuario);
		model.addAttribute("user", usuario);
		model.addAttribute("enviado", true);
		model.addAttribute("success", "Usuario actualizado exitosamente ");
		return "redirect:/index-cambio-de-clave";
		}else{
			model.addAttribute("errorEditar", true);
			model.addAttribute("warning","No deje los campos en blanco");
			
			editar(model,request);
		}
		return "perfil";
	}
	
	public void alertaEmail(final String evento, final User usuario){
		final String email=usuario.getEmail();
		mailSenderObj.send(new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws Exception {
				String sistema="https://rdp-gcba.herokuapp.com/";
				MimeMessageHelper mimeMsgHelperObj = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				mimeMsgHelperObj.setTo(email);
				mimeMsgHelperObj.setFrom("agentedeplaya@gmail.com");	
				mimeMsgHelperObj.setSubject("RDP - Alerta Cambio de Datos en el Perfil");					
				mimeMsgHelperObj.setText("<table style='font-family:Arial;text-align:left;width:966px;height:85px' border='1' cellspacing='2' cellpadding='2'> <tbody> <tr> <td style='text-align:center'> <img style='width:80px;height:90px' alt='Logo GCABA' title='Logo GCABA' src='cid:Logo-BA' class='CToWUd'> </td> <td style='background-color:rgb(255,222,0);text-align:center'> <span style='font-size:24px'> <b>RDP</b> - Restablecer Contraseña </span> </td> </tr> <tr> <td style='text-align:justify' colspan='2'><b>Señor/a "+usuario.getLastName()+", "+usuario.getFirstName()+"</b> <br> <br> Le informamos su nueva contraseña. <br> Usted puede ingresar a la aplicación <a href='"+sistema+"'>"+sistema+"</a> para cargar sus datos personales con la siguiente información: <br> <ul type='square'> <li> Usuario: <b>"+usuario.getSsoId()+"</b><br> </li> <li> Contraseña: <b>"+usuario.getPassword()+"</b> </li> </ul> Recomendamos iniciar sesión e inmediatamente cambiar la contraseña nuevamente desde la pantalla de perfil por una de su elección. <br> Saludos cordiales. <br> <br> <span style='font-size:12px'> <center> <b><u>ATENCIÓN</u></b>: El presente es un mensaje generado automaticamente por el <br> <b>Sistema de Registro de Computadoras</b> del <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b> y no debe ser respondido.<br> </center> </span> </td> </tr> <tr> <td style='text-align:center'> <img style='width:80px;height:90px' alt='Logo GCABA' title='Logo GCABA' src='cid:Logo-BA' class='CToWUd'> </td> <td style='background-color:rgb(255,222,0);text-align:center'> <span style='font-size:12px'> El Sistema de Registro de Computadoras es implementado en el marco de la <b>Iniciativa de la DGCACTYSV</b> <br>emprendida por el <b>Gobierno de la Ciudad Autonoma de Buenos Aires</b>. </span> </td> </tr> </tbody> </table>",true);
				FileSystemResource res = new FileSystemResource(new File(context.getRealPath("/static/bastrap3/img/Logo.jpg")));
				mimeMsgHelperObj.addInline("Logo-BA", res);
			
			}
		});
		
	}
	


}
