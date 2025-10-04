package com.xworkz.milklore.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.ProductDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.SupplierService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
@Slf4j
@PropertySource("classpath:application.properties")
public class ProductController {

    @Autowired
    AdminService adminService;

    @Autowired
    SupplierService supplierService;

    @Value("${app.json-file-path}")
    private String jsonFilePath;

    @Value("${app.upload-dir}")
    private String uploadDir;

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertyConfig() {
        return new PropertySourcesPlaceholderConfigurer();
    }

    private List<ProductDTO> readProducts() {
        ObjectMapper mapper = new ObjectMapper();
        try {
            File file = new File(jsonFilePath);
            if (!file.exists()) return new ArrayList<>();
            return mapper.readValue(file, new TypeReference<List<ProductDTO>>() {});
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private void saveProducts(List<ProductDTO> products) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            mapper.writerWithDefaultPrettyPrinter().writeValue(new File(jsonFilePath), products);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ✅ JSON API for frontend
    @GetMapping("/products")
    @ResponseBody
    public List<ProductDTO> getProducts() {
        return readProducts();
    }

    @GetMapping("/manageProducts")
    public String manageProducts(Model model) {
        model.addAttribute("productList", readProducts());
        return "ManageProducts";
    }

    @PostMapping("/saveProduct")
    public String saveProduct(@RequestParam String title,
                              @RequestParam String description,
                              @RequestParam String price,
                              @RequestParam("imageFile") MultipartFile imageFile,
                              @RequestParam(required = false) Integer id,
                              Model model) throws IOException {

        List<ProductDTO> products = readProducts();

        String imagePath = "images/default-product.png"; // default
        if (imageFile != null && !imageFile.isEmpty()) {
            String filename = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            File file = new File(uploadDir, filename);
            imageFile.transferTo(file);
            imagePath = "images/" + filename;
        } else if (id != null) { // retain old image for edit
            for (ProductDTO p : products) {
                if (p.getId() == id) {
                    imagePath = p.getImagePath();
                    break;
                }
            }
        }

        ProductDTO product;
        if (id != null) { // edit existing
            product = products.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
            if (product != null) {
                product.setTitle(title);
                product.setDescription(description);
                product.setPrice(price);
                product.setImagePath(imagePath);
            }
        } else { // add new
            int newId = products.isEmpty() ? 1 : products.get(products.size() - 1).getId() + 1;
            product = new ProductDTO();
            product.setId(newId);
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);
            product.setImagePath(imagePath);
            products.add(product);
        }

        saveProducts(products);
        model.addAttribute("productList", products);
        return "ManageProducts";
    }

    @PostMapping("/deleteProduct")
    public String deleteProduct(@RequestParam int id, Model model) {
        List<ProductDTO> products = readProducts();
        ProductDTO toDelete = products.stream().filter(p -> p.getId() == id).findFirst().orElse(null);

        if (toDelete != null) {
            // ✅ delete image file if not default
            if (toDelete.getImagePath() != null && !toDelete.getImagePath().equals("images/default-product.png")) {
                File file = new File(uploadDir, new File(toDelete.getImagePath()).getName());
                if (file.exists()) file.delete();
            }
            products.remove(toDelete);
        }

        saveProducts(products);
        model.addAttribute("message", "Product deleted successfully!");
        model.addAttribute("productList", products);
        return "ManageProducts";
    }

    @GetMapping("/editProduct")
    public String editProduct(@RequestParam int id, Model model) {
        List<ProductDTO> products = readProducts();
        for (ProductDTO p : products) {
            if (p.getId() == id) {
                model.addAttribute("editProduct", p);
                break;
            }
        }
        model.addAttribute("productList", products);
        return "ManageProducts";
    }
}
