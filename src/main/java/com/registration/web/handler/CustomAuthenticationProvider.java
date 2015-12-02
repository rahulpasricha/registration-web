package com.registration.web.handler;

import javax.annotation.Resource;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.registration.web.model.User;
import com.registration.web.service.EntityService;
import com.registration.web.util.EncryptionUtil;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Resource
	private EntityService entityService;
	
	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		String userName = authentication.getName().trim();
		String inputPassword = authentication.getCredentials().toString().trim();
		
		User user = entityService.getUser(userName);

		if (user == null) {
			throw new BadCredentialsException("User name not found");
		}

		String decryptedPassword = null;
		try {
			decryptedPassword = EncryptionUtil.decrypt(user.getPassword());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (!inputPassword.equals(decryptedPassword)) {
			throw new BadCredentialsException("Password is incorrect");
		}

		return new UsernamePasswordAuthenticationToken(user, inputPassword,
				user.getAuthorities());
	}
	
	@Override
	public boolean supports(Class<? extends Object> authentication) {
		return true;
	}
}