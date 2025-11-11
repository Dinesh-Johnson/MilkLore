package com.xworkz.milklore.service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.xworkz.milklore.configuration.EmailConfiguration;
import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.SupplierBankDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.*;
import com.xworkz.milklore.repository.MilkProductReceiveRepo;
import com.xworkz.milklore.repository.NotificationRepo;
import com.xworkz.milklore.repository.PaymentDetailsRepository;
import com.xworkz.milklore.repository.SupplierRepo;
import com.xworkz.milklore.utill.OTPUtill;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;



@Slf4j
@Service
public class SupplierServiceImpl implements SupplierService{

    @Autowired
    private SupplierRepo supplierRepo;

    @Autowired
    private AdminService adminService;

    @Autowired
    private EmailSenderService emailSender;

    @Autowired
    private EmailConfiguration emailConfig;

    @Autowired
    private NotificationRepo notificationRepo;

    @Autowired
    private MilkProductReceiveRepo milkProductReceiveRepo;

    @Autowired
    private PaymentDetailsRepository paymentDetailsRepository;

    @Autowired
    private QrGeneratorService qrGeneratorService;

    private static final int OTP_EXPIRY_MINUTES = 5;

    public SupplierServiceImpl(){
        log.info("SupplierServiceImpl constructor");
    }

    @Override
    public boolean addSupplier(SupplierDTO supplierDTO, String adminEmail) {
        log.info("addSupplier method in SupplierServiceImpl");

        if (adminEmail == null || adminEmail.trim().isEmpty()) {
            log.error("Admin email is null or empty. Cannot add supplier.");
            return false;
        }

        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);
        if (adminDTO == null) {
            log.error("No admin found for email: {}", adminEmail);
            return false;
        }

        SupplierEntity supplierEntity = new SupplierEntity();
        BeanUtils.copyProperties(supplierDTO, supplierEntity);

        SupplierAuditEntity supplierAuditEntity = supplierEntity.getSupplierAuditEntity();
        if (supplierAuditEntity == null) {
            supplierAuditEntity = new SupplierAuditEntity();
            supplierAuditEntity.setName(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
            supplierAuditEntity.setCreatedBy(adminDTO.getAdminName());
            supplierAuditEntity.setCreatedAt(LocalDateTime.now());
            supplierAuditEntity.setSupplierEntity(supplierEntity);
        }

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierEntity.setIsActive(true);

        if (supplierRepo.addSupplier(supplierEntity)) {
            log.info("supplier details saved");
            SupplierEntity supplier=supplierRepo.getSupplierByEmail(supplierEntity.getEmail());
            String qrcode= qrGeneratorService.generateSupplierQR(supplier.getSupplierId(),supplier.getEmail(),supplier.getPhoneNumber());
            if(emailSender.mailForSupplierRegisterSuccess(supplierEntity.getEmail(),supplierEntity.getFirstName()+supplierEntity.getLastName(),qrcode)){
                log.info("Mail sent to supplier");
                return true;
            }
        } else {
            log.error("Supplier details not saved");
        }

        return false;
    }


    @Override
    public List<SupplierDTO> getAllSuppliers(int pageNumber,int pageSize) {
        log.info("getAllSuppliers method in supplier service");
        List<SupplierEntity> supplierEntities=supplierRepo.getAllSuppliers(pageNumber,pageSize);
        List<SupplierDTO> supplierDTOS=new ArrayList<>();
        supplierEntities.forEach(supplierEntity -> {
            SupplierDTO supplierDTO=new SupplierDTO();
            BeanUtils.copyProperties(supplierEntity,supplierDTO);
            if(supplierEntity.getSupplierBankDetails()!=null)
            {
                SupplierBankDetailsDTO supplierBankDetailsDTO=new SupplierBankDetailsDTO();
                BeanUtils.copyProperties(supplierEntity.getSupplierBankDetails(),supplierBankDetailsDTO);
                supplierDTO.setSupplierBankDetails(supplierBankDetailsDTO);
                System.out.println(supplierBankDetailsDTO);
            }
            supplierDTOS.add(supplierDTO);
        });
        return supplierDTOS;
    }

    @Override
    public boolean checkEmail(String email) {
        log.info("checkEmail method in Supplier service");
        return supplierRepo.checkEmail(email);
    }

    @Override
    public boolean checkPhonNumber(String phoneNumber) {
        log.info("checkPhonNumber method in Supplier service");
        return supplierRepo.checkPhoneNumber(phoneNumber);
    }

    @Override
    public boolean editSupplierDetails(SupplierDTO supplierDTO, String adminEmail) {
        log.info("editSupplierDetails method in supplier service");
        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);

        SupplierEntity supplierEntity=supplierRepo.getSupplierByEmail(supplierDTO.getEmail());

        SupplierEntity sendEntity=new SupplierEntity();
        BeanUtils.copyProperties(supplierDTO,sendEntity);

        sendEntity.setSupplierAuditEntity(supplierEntity.getSupplierAuditEntity());
        SupplierAuditEntity supplierAuditEntity=sendEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null){
            log.error("getSupplier not found");
            return false;
        }if (adminDTO==null){
            log.error("Admin DTO is Null");
            return false;
        }
        supplierAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        sendEntity.setSupplierAuditEntity(supplierAuditEntity);
        return supplierRepo.updateSupplierDetails(sendEntity, false);
    }

    @Override
    public boolean deleteSupplierDetails(String email, String adminEmail) {
        log.info("deleteSupplierDetails method in supplier service");
        SupplierEntity supplierEntity = supplierRepo.getSupplierByEmail(email);
        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);

        SupplierAuditEntity supplierAuditEntity=supplierEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null){
            log.error("getSupplier not found");
            return false;
        }
        supplierAuditEntity.setDeletedBy(adminDTO.getAdminName());
        supplierAuditEntity.setDeletedAt(LocalDateTime.now());
        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        return supplierRepo.updateSupplierDetails(supplierEntity, true);
    }


    @Override
    public List<SupplierDTO> searchSuppliers(String keyword) {
        List<SupplierEntity> supplierEntities=supplierRepo.getSearchSuppliers(keyword);
        List<SupplierDTO> supplierDTOS=new ArrayList<>();
        supplierEntities.forEach(supplierEntity -> {
            SupplierDTO supplierDTO=new SupplierDTO();
            BeanUtils.copyProperties(supplierEntity,supplierDTO);
            supplierDTOS.add(supplierDTO);
        });
        return supplierDTOS;
    }

    @Override
    public SupplierDTO getSupplierDetails(String phone) {
        log.info("getSupplierDetails method in supplier service");
        SupplierEntity supplierEntity=supplierRepo.getSupplierByPhone(phone);
        SupplierDTO supplierDTO=new SupplierDTO();
        BeanUtils.copyProperties(supplierEntity,supplierDTO);
        return supplierDTO;
    }

    @Override
    public SupplierDTO getSupplierDetailsByEmail(String email) {
        log.info("Fetching supplier details by email: {}", email);

        SupplierEntity entity = supplierRepo.getSupplierByEmail(email);

        if (entity == null) {
            log.warn("No supplier found with email: {}", email);
            return null;
        }

        SupplierDTO dto = new SupplierDTO();
        BeanUtils.copyProperties(entity, dto);
        if(entity.getSupplierBankDetails()!=null)
        {
            SupplierBankDetailsDTO supplierBankDetailsDTO=new SupplierBankDetailsDTO();
            BeanUtils.copyProperties(entity.getSupplierBankDetails(),supplierBankDetailsDTO);
            dto.setSupplierBankDetails(supplierBankDetailsDTO);
        }

        log.info("Supplier details copied to DTO successfully");
        return dto;
    }


    @Override
    public boolean generateAndSendOtp(String email) {
        if (email == null || email.trim().isEmpty()) {
            log.warn("generateAndSendOtp: empty email");
            return false;
        }

        email = email.trim();
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) {
            log.warn("generateAndSendOtp: supplier not found for email {}", email);
            return false;
        }

        // Generate 6-digit numeric OTP
        String otp = OTPUtill.generateNumericOtp(6);
        supplier.setOtp(otp);
        supplier.setOtpExpiryTime(LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES));

        // Persist changes
        boolean updated = supplierRepo.updateSupplierLogin(supplier); // should update existing entity
        if (!updated) {
            log.error("generateAndSendOtp: failed to update supplier OTP for email {}", email);
            return false;
        }

        // Send OTP email
        boolean emailSent = emailSender.supplierMailOtp(email, otp);
        if (!emailSent) {
            log.error("generateAndSendOtp: failed to send OTP email to {}", email);
            return false;
        }

        log.info("generateAndSendOtp: OTP {} sent successfully to {}", otp, email);
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            log.warn("verifyOtp: email or OTP is empty");
            return false;
        }

        email = email.trim();
        otp = otp.trim();
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) {
            log.warn("verifyOtp: supplier not found for email {}", email);
            return false;
        }

        LocalDateTime now = LocalDateTime.now();
        if (supplier.getOtp() != null &&
                supplier.getOtp().equals(otp) &&
                supplier.getOtpExpiryTime() != null &&
                supplier.getOtpExpiryTime().isAfter(now)) {

            // OTP is valid -> clear it
            supplier.setOtp(null);
            supplier.setOtpExpiryTime(null);
            boolean updated = supplierRepo.updateSupplierLogin(supplier);
            if (!updated) {
                log.error("verifyOtp: failed to clear OTP for email {}", email);
                return false;
            }

            log.info("verifyOtp: OTP verified successfully for {}", email);
            return true;
        }

        log.warn("verifyOtp: invalid or expired OTP for {}", email);
        return false;
    }

    @Override
    public boolean updateSupplierDetailsBySupplier(SupplierDTO supplierDTO) {
        log.info("updateSupplierDetailsBySupplier method in supplier service");
        SupplierEntity existingEntity=supplierRepo.getSupplierByEmail(supplierDTO.getEmail());
        SupplierAuditEntity supplierAuditEntity;
        if(existingEntity==null)
        {
            log.error("Entity not found for update");
            return false;
        }
        supplierAuditEntity=existingEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null)
        {
            log.error("log not found");
            return false;
        }
        existingEntity.setFirstName(supplierDTO.getFirstName());
        existingEntity.setLastName(supplierDTO.getLastName());
        existingEntity.setAddress(supplierDTO.getAddress());
        if(supplierDTO.getProfilePath()!=null)
        {
            existingEntity.setProfilePath(supplierDTO.getProfilePath());
        }
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        supplierAuditEntity.setUpdatedBy(supplierDTO.getFirstName()+" "+supplierDTO.getLastName());
        existingEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(existingEntity);

        return supplierRepo.updateSupplierDetailsBySupplier(existingEntity);
    }

    @Override
    public boolean updateSupplierBankDetails(SupplierBankDetailsDTO supplierBankDetailsDTO, String email) {
        log.info("Entered updateSupplierBankDetails() in SupplierService with email: {}", email);
        log.info("Incoming SupplierBankDetailsDTO: {}", supplierBankDetailsDTO);

        SupplierEntity supplierEntity = supplierRepo.getSupplierByEmail(email);
        if (supplierEntity == null) {
            log.error("No SupplierEntity found for email: {}", email);
            return false;
        }

        log.info("Fetched SupplierEntity for email: {}", supplierEntity.getEmail());

        if (supplierEntity.getSupplierAuditEntity() == null) {
            log.error("SupplierAuditEntity is null for supplier with email: {}", email);
            return false;
        }

        SupplierAuditEntity supplierAuditEntity = supplierEntity.getSupplierAuditEntity();
        supplierAuditEntity.setUpdatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        log.info("Updated SupplierAuditEntity with updatedBy: {} and updatedAt: {}",
                supplierAuditEntity.getUpdatedBy(), supplierAuditEntity.getUpdatedAt());

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(supplierEntity);

        SupplierBankDetailsEntity supplierBankDetailsEntity = supplierEntity.getSupplierBankDetails();
        SupplierBankDetailsAuditEntity supplierBankDetailsAuditEntity;

        if (supplierBankDetailsEntity == null) {
            log.info("No existing SupplierBankDetailsEntity found — creating new entity");
            supplierBankDetailsEntity = new SupplierBankDetailsEntity();
            BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);

            supplierBankDetailsAuditEntity = new SupplierBankDetailsAuditEntity();
            supplierBankDetailsAuditEntity.setCreatedAt(LocalDateTime.now());
            supplierBankDetailsAuditEntity.setCreatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
            log.info("Created new SupplierBankDetailsAuditEntity with createdBy: {} and createdAt: {}",
                    supplierBankDetailsAuditEntity.getCreatedBy(), supplierBankDetailsAuditEntity.getCreatedAt());
        } else {
            log.info("Existing SupplierBankDetailsEntity found — updating existing entity");
            BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);
            supplierBankDetailsAuditEntity = supplierBankDetailsEntity.getSupplierBankDetailsAuditEntity();
            log.info("Fetched existing SupplierBankDetailsAuditEntity for update");
        }

        supplierBankDetailsAuditEntity.setUpdatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
        supplierBankDetailsAuditEntity.setUpdatedAt(LocalDateTime.now());
        log.info("Set updatedBy: {} and updatedAt: {} in SupplierBankDetailsAuditEntity",
                supplierBankDetailsAuditEntity.getUpdatedBy(), supplierBankDetailsAuditEntity.getUpdatedAt());

        supplierEntity.setSupplierBankDetails(supplierBankDetailsEntity);
        supplierBankDetailsEntity.setSupplierEntity(supplierEntity);
        supplierBankDetailsEntity.setSupplierBankDetailsAuditEntity(supplierBankDetailsAuditEntity);
        supplierBankDetailsAuditEntity.setSupplierBankDetailsEntity(supplierBankDetailsEntity);

        boolean isUpdated = supplierRepo.updateSupplierDetailsBySupplier(supplierEntity);
        log.info("Supplier bank details update status for email {}: {}", email, isUpdated);

        log.info("Exiting updateSupplierBankDetails() in SupplierService");
        if(isUpdated)
        {
            return emailSender.mailForSupplierBankDetails(supplierEntity.getEmail(), supplierBankDetailsEntity);
        }
        return false;
    }

    @Override
    public boolean updateSupplierBankDetailsByAdmin(SupplierBankDetailsDTO supplierBankDetailsDTO, String email,String adminEmail) {
        log.info("updateSupplierBankDetailsByAdmin method in supplier service");
        SupplierEntity supplierEntity=supplierRepo.getSupplierByEmail(email);
        AdminDTO adminDTO=adminService.viewAdminByEmail(adminEmail);
        if(supplierEntity.getSupplierAuditEntity()==null)
        {
            log.error("Entity not found for supplier");
            return false;
        }
        SupplierAuditEntity supplierAuditEntity=supplierEntity.getSupplierAuditEntity();
        supplierAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(supplierEntity);

        SupplierBankDetailsEntity supplierBankDetailsEntity = supplierEntity.getSupplierBankDetails();
        SupplierBankDetailsAuditEntity supplierBankDetailsAuditEntity;

        BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);
        supplierBankDetailsAuditEntity = supplierBankDetailsEntity.getSupplierBankDetailsAuditEntity();

        supplierBankDetailsAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierBankDetailsAuditEntity.setUpdatedAt(LocalDateTime.now());

        supplierEntity.setSupplierBankDetails(supplierBankDetailsEntity);
        supplierBankDetailsEntity.setSupplierEntity(supplierEntity);
        supplierBankDetailsEntity.setSupplierBankDetailsAuditEntity(supplierBankDetailsAuditEntity);
        supplierBankDetailsAuditEntity.setSupplierBankDetailsEntity(supplierBankDetailsEntity);

        if(supplierRepo.updateSupplierDetailsBySupplier(supplierEntity))
        {
            return emailSender.mailForSupplierBankDetails(supplierEntity.getEmail(), supplierBankDetailsEntity);
        }
        return false;
    }

    @Override
    public SupplierDTO getSupplierDetailsByNotificationId(Long notificationId) {
        log.info("getSupplierDetailsByNotificationId method in supplier service");
        SupplierEntity supplierEntity=notificationRepo.getSupplierEntityByNotificationId(notificationId);
        return getSupplierDetailsByEmail(supplierEntity.getEmail());
    }

    @Override
    public boolean requestForSupplierBankDetails(String supplierEmail) {
        log.info("requestForSupplierBankDetails method in supplier service");
        SupplierEntity supplierEntity=supplierRepo.getSupplierByEmail(supplierEmail);
        return emailSender.mailForBankDetailsRequest(supplierEntity);
    }

    @Override
    public void downloadInvoicePdf(Integer supplierId, LocalDate start, LocalDate end, LocalDate paymentDate, HttpServletResponse response) {
        log.info("Generating MilkLore invoice (Letterhead + Watermark) for supplierId {}", supplierId);

        try {
            // === Fetch data ===
            PaymentDetailsEntity payment = paymentDetailsRepository.getEntityBySupplierIdAndPaymentDate(paymentDate, supplierId);
            List<MilkProductReceiveEntity> milkList = milkProductReceiveRepo.getCollectMilkDetailsForSupplierById(supplierId, start, end);
            SupplierEntity supplier = supplierRepo.getSupplierDetailsAndBankById(supplierId);

            // === PDF Setup ===
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=MilkLore_Invoice_"
                    + supplier.getFirstName() + "_" + supplier.getLastName() + ".pdf");

            Document document = new Document(PageSize.A4, 50, 50, 100, 70);
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // === Apply full-page watermark ===
            String bgPath = "D:\\MilkLore\\MilkLore\\MilkLore\\src\\main\\webapp\\images\\milklore.png"; // 🔁 Replace this path
            Image bg = Image.getInstance(bgPath);
            bg.scaleToFit(PageSize.A4.getWidth(), PageSize.A4.getHeight());
            bg.setAbsolutePosition(0, 0);

            PdfContentByte canvas = writer.getDirectContentUnder();
            PdfGState gState = new PdfGState();
            gState.setFillOpacity(0.15f); // 15% transparency
            canvas.saveState();
            canvas.setGState(gState);
            canvas.addImage(bg);
            canvas.restoreState();

            // === Brand fonts & colors ===
            BaseColor milkBlue = new BaseColor(0, 153, 204);
            BaseColor darkGray = new BaseColor(40, 40, 40);
            BaseColor lightGray = new BaseColor(245, 245, 245);

            Font brandFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, milkBlue);
            Font subFont = new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, darkGray);
            Font normalFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL, darkGray);
            Font italicFont = new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC, BaseColor.GRAY);
            Font whiteBoldFont = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD, BaseColor.WHITE);

            // === LETTERHEAD HEADER ===
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);
            headerTable.setWidths(new float[]{70, 30});

            // Left: Company details
            PdfPCell companyCell = new PdfPCell();
            companyCell.setBorder(Rectangle.NO_BORDER);
            companyCell.addElement(new Paragraph("MilkLore", brandFont));
            companyCell.addElement(new Paragraph("Pure. Fresh. Local.", italicFont));
            companyCell.addElement(new Paragraph("MilkLore Pvt. Ltd.", normalFont));
            companyCell.addElement(new Paragraph("123 Dairy Road, Village Green, Pune, Maharashtra", normalFont));
            companyCell.addElement(new Paragraph("Phone: +91-98765-43210 | Email: contact@milklore.in", normalFont));

            // Right: Logo
            String logoPath = "D:\\MilkLore\\MilkLore\\MilkLore\\src\\main\\webapp\\images\\milklore.png"; // 🔁 Replace this path
            Image logo = Image.getInstance(logoPath);
            logo.scaleToFit(100, 60);
            PdfPCell logoCell = new PdfPCell(logo, false);
            logoCell.setBorder(Rectangle.NO_BORDER);
            logoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

            headerTable.addCell(companyCell);
            headerTable.addCell(logoCell);
            document.add(headerTable);

            // === Divider Line ===
            LineSeparator line = new LineSeparator();
            line.setLineColor(milkBlue);
            line.setLineWidth(2);
            document.add(new Chunk(line));
            document.add(Chunk.NEWLINE);

            // === Title & Invoice Info ===
            Paragraph title = new Paragraph("SUPPLIER INVOICE", subFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(Chunk.NEWLINE);

            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);
            infoTable.setSpacingBefore(5f);
            infoTable.addCell(createKeyValueCell("Invoice Date:", LocalDate.now().toString(), normalFont));
            infoTable.addCell(createKeyValueCell("Period:", start + " to " + end, normalFont));
            infoTable.addCell(createKeyValueCell("Supplier Name:", supplier.getFirstName() + " " + supplier.getLastName(), normalFont));
            infoTable.addCell(createKeyValueCell("Phone:", supplier.getPhoneNumber(), normalFont));
            infoTable.addCell(createKeyValueCell("Address:", supplier.getAddress(), normalFont));
            document.add(infoTable);
            document.add(Chunk.NEWLINE);

            // === Milk Collection Table ===
            Paragraph milkSection = new Paragraph("Milk Collection Details", subFont);
            document.add(milkSection);

            PdfPTable milkTable = new PdfPTable(5);
            milkTable.setWidthPercentage(100);
            milkTable.setSpacingBefore(5f);
            milkTable.setWidths(new float[]{20, 20, 20, 20, 20});

            addHeaderCell(milkTable, "Milk Type", milkBlue, whiteBoldFont);
            addHeaderCell(milkTable, "Date", milkBlue, whiteBoldFont);
            addHeaderCell(milkTable, "Quantity (L)", milkBlue, whiteBoldFont);
            addHeaderCell(milkTable, "Rate (₹)", milkBlue, whiteBoldFont);
            addHeaderCell(milkTable, "Total (₹)", milkBlue, whiteBoldFont);

            double total = 0;
            boolean alternate = false;
            for (MilkProductReceiveEntity m : milkList) {
                BaseColor bgColor = alternate ? lightGray : BaseColor.WHITE;
                milkTable.addCell(createTableCell(m.getTypeOfMilk(), normalFont, bgColor));
                milkTable.addCell(createTableCell(m.getCollectedDate().toString(), normalFont, bgColor));
                milkTable.addCell(createTableCell(String.format("%.2f", m.getQuantity()), normalFont, bgColor));
                milkTable.addCell(createTableCell(String.format("%.2f", m.getPrice()), normalFont, bgColor));
                milkTable.addCell(createTableCell(String.format("%.2f", m.getTotalAmount()), normalFont, bgColor));
                total += m.getTotalAmount();
                alternate = !alternate;
            }
            document.add(milkTable);
            document.add(Chunk.NEWLINE);

            // === Payment Details ===
            Paragraph paySection = new Paragraph("Payment Summary", subFont);
            document.add(paySection);

            PdfPTable payTable = new PdfPTable(2);
            payTable.setWidthPercentage(100);
            payTable.addCell(createKeyValueCell("Payment Date:", payment != null ? payment.getPaymentDate().toString() : "N/A", normalFont));
            payTable.addCell(createKeyValueCell("Total Amount (₹):", String.format("%.2f", total), normalFont));
            payTable.addCell(createKeyValueCell("Status:", payment != null ? payment.getPaymentStatus() : "Pending", normalFont));
            document.add(payTable);
            document.add(Chunk.NEWLINE);

            // === Footer ===
            document.add(new Chunk(line));
            Paragraph footer = new Paragraph("Thank you for partnering with MilkLore!", italicFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);
            Paragraph contactFooter = new Paragraph("www.milklore.in | +91-98765-43210 | contact@milklore.in", italicFont);
            contactFooter.setAlignment(Element.ALIGN_CENTER);
            document.add(contactFooter);

            document.close();
            log.info("MilkLore letterhead + watermark invoice generated successfully for supplier {}", supplierId);

        } catch (Exception e) {
            log.error("Error generating MilkLore invoice for supplier {}: {}", supplierId, e.getMessage(), e);
            throw new RuntimeException("Error generating MilkLore invoice PDF", e);
        }
    }

// === Helper methods ===

    private PdfPCell createKeyValueCell(String key, String value, Font font) {
        Phrase phrase = new Phrase();
        phrase.add(new Chunk(key + " ", new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD)));
        phrase.add(new Chunk(value, font));
        PdfPCell cell = new PdfPCell(phrase);
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(4f);
        return cell;
    }

    private void addHeaderCell(PdfPTable table, String text, BaseColor bgColor, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(bgColor);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPadding(6f);
        table.addCell(cell);
    }

    private PdfPCell createTableCell(String text, Font font, BaseColor bgColor) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(bgColor);
        cell.setPadding(5f);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        return cell;
    }


}
