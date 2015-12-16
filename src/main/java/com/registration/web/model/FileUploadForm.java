/**
 * 
 */
package com.registration.web.model;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author rpasricha
 */
public class FileUploadForm {
	
	private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
