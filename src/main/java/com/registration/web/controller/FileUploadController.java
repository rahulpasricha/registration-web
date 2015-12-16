package com.registration.web.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class FileUploadController {
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public Boolean upload(@RequestParam("myimage") MultipartFile file, HttpServletResponse response) {

		if (0 == file.getSize()) {
			return sendErrorResponse(response, "Either you haven't selected an image or the image size is 0");
		} else if (!("image/png".equals(file.getContentType()) || "image/jpeg".equals(file.getContentType()))) {
			return sendErrorResponse(response, "Only PNG and JPEG uploads are allowed");
		} else if (file.getSize() > 5242880) {
			return sendErrorResponse(response, "Image size should be less than or equal to 5MB");
		}

		File convFile = new File("/opt/user-registration/gallery/" + file.getOriginalFilename());
	    try {
			convFile.createNewFile(); 
			FileOutputStream fos = new FileOutputStream(convFile); 
			fos.write(file.getBytes());
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		} 
	    
		return true;
	}
	
	@RequestMapping(value = "/getAllImages", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getImage() throws IOException {
		
		File folder = new File("/opt/user-registration/gallery/");
		File[] listOfFiles = folder.listFiles();
		List<String> listOfBase64EncodedImages = new ArrayList<>();
		
		for (File eachFile : listOfFiles) {
			ByteArrayOutputStream baos;
			BufferedImage bi;
			StringBuilder sb = new StringBuilder();
	        try {
	        	baos = new ByteArrayOutputStream();
				bi = ImageIO.read(eachFile);
	            ImageIO.write(bi, "png", baos);
	            byte[] res = baos.toByteArray();
	            sb.append("data:image/jpeg;base64,").append(Base64.encodeBase64String(res));
		        listOfBase64EncodedImages.add(sb.toString());
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	        	baos = null;
	        	bi = null;
	        	sb = null;
	        }
		}
		
//		BufferedImage bufferedImage = ImageIO.read(Files.newInputStream(Paths.get(basePath + imageSource)));
		
		return listOfBase64EncodedImages;
		
//		File imageFile = new File("/opt/user-registration/gallery/Sample 4X4.PNG");
//		ByteArrayOutputStream baos = new ByteArrayOutputStream();
//		BufferedImage bi = ImageIO.read(imageFile);
//        try {
//            ImageIO.write(bi, "png", baos);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        byte[] res = baos.toByteArray();
//        String encodeBase64String = Base64.encodeBase64String(res);
//		return "data:image/jpeg;base64," + encodeBase64String;
	}

	private boolean sendErrorResponse(HttpServletResponse response, String message) {
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		try {
			response.getWriter().write(message);
			response.flushBuffer();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return false;
	}
}
