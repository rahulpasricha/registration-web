package com.registration.web.exception;

public class FoosballException extends Exception {
	
	private static final long serialVersionUID = 5176493686091199961L;

	String errorMessage;
	
	public FoosballException (String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}
	
}
