package com.openmind.neh.app.services.implimetations;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class UploadService {

    @Value("${file.upload-dir}")
    private String uploadDirectory;

    public List<String> uploadImages(List<MultipartFile> files) throws IOException {
        List<String> filenames = new ArrayList<>();

        for (MultipartFile file : files) {
            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.'));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            File directory = new File(uploadDirectory);
            if (!directory.exists()) {
                directory.mkdir();
            }

            Path filePath = Paths.get(uploadDirectory, uniqueFileName);
            Files.write(filePath, file.getBytes());

            filenames.add(uniqueFileName);
        }

        return filenames;
    }

    public byte[] getImage(String filename) throws IOException {
        Path imagePath = Paths.get(uploadDirectory, filename);
        return Files.readAllBytes(imagePath);
    }

}

