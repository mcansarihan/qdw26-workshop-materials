# **ANSYS HFSS 2026 R1 Installation Instructions**

You have been granted access to our ANSYS Cloud Licensing environment. Please follow the instructions below to install ANSYS HFSS 2026 R1 and connect to the shared cloud license pool.

**Important:** Sign in using the same email address that was added to the ANSYS licensing account. No local license server configuration is required. When you are **not using ANSYS HFSS**, please **close ANSYS HFSS** so the license is not checked out.

---

# **Download Installation Files**

1. Please find and use the links (check the email you registered with) provided to you to download the Ansys installer for your operating system. **Only Linux and Windows are supported.**
2. Download all installation files to your computer.
3. If the installation package consists of multiple files or archives, download all files before proceeding.
4. Extract the downloaded files to a local directory.
5. Follow the instructions below for your operating system.

# **Windows Installation**

## **System Requirements**

- Windows 10 or Windows 11 (64-bit)
- Administrator privileges
- Internet access for license authentication
- Approximately 25–30 GB of available disk space

## **Install HFSS**

1. Open the extracted installation folder.
2. Locate:  
   setup.exe
3. Right-click the file and select:  
   Run as Administrator
4. Select:  
   Install Ansys Products
5. When prompted, choose:
   - Ansys Electronics Desktop 2026 R1
   - HFSS
6. Accept the license agreement.
7. Use the default installation directory unless instructed otherwise:  
   C:\\Program Files\\ANSYS Inc\\v261
8. Click Install and wait for the installation to complete.
9. Click Finish when installation is complete.

---

## **Configure Cloud Licensing**

1. Open the Start Menu.
2. Navigate to:  
   Ansys 2026 R1 → Ansys Licensing Settings 2026 R1
3. Open the Licensing Settings application.
4. Select the Web Licensing section.
5. Enable Web Licensing.
6. Click Sign In.
7. Log in using the email address that was granted license access.
8. Complete any browser authentication steps.

---

## **Verify License Access**

After signing in:

1. Confirm that licensing information is displayed.
2. Verify that available license features appear.
3. If no licenses appear:
   - Sign out and sign back in.
   - Verify you are using the correct email address.
   - Contact the license administrator.

---

## **Launch HFSS**

1. Open:  
   Start Menu → Ansys Electronics Desktop 2026 R1
2. Create a new project.
3. Insert an HFSS Design.
4. Verify that no licensing errors are displayed.

---

# **Linux Installation**

## **System Requirements**

- Supported 64-bit Linux distribution
- Root or sudo privileges
- Graphical desktop environment
- Internet access for license authentication
- Approximately 25–30 GB of available disk space

## **Install HFSS**

1. Open a terminal.
2. Navigate to the extracted installation directory:  
   cd /path/to/extracted/files
3. Launch the installer:  
   sudo ./INSTALL
4. Select:
   - Ansys Electronics Desktop 2026 R1
   - HFSS
5. Accept the license agreement.
6. Complete the installation using the default installation location:  
   /ansys_inc/v261
7. Wait for installation to complete.

---

## **Configure Cloud Licensing**

1. Open a terminal.
2. Launch the Licensing Settings utility:  
   /ansys_inc/v261/licensingclient/linx64/LicensingSettings
3. If necessary, launch with sudo privileges:  
   sudo /ansys_inc/v261/licensingclient/linx64/LicensingSettings
4. Select the Web Licensing section.
5. Enable Web Licensing.
6. Click Sign In.
7. Log in using the email address that was granted license access.

---

## **Verify License Access**

After signing in:

1. Confirm that available license features are displayed.
2. Verify that no licensing errors are reported.
3. If licenses are not displayed:
   - Sign out and sign back in.
   - Confirm you are using the correct email address.
   - Contact the license administrator.

---

## **Launch HFSS**

From a terminal:

/ansys_inc/v261/EM/ansysedt

Alternatively, launch Ansys Electronics Desktop from your desktop environment if available.

Create a new HFSS project and verify that no licensing errors occur.

---

# **Troubleshooting**

## **No Licenses Available**

- Verify Internet connectivity.
- Confirm that Web Licensing is enabled.
- Sign out and sign back in.
- Verify that your email address has been granted access to the license pool.

## **Licensing Authentication Issues**

- Ensure you are using the same email address that received licensing access.
- Clear browser cache and retry authentication.
- Restart the Licensing Settings application.

## **HFSS Starts but Reports Licensing Errors**

- Reopen Licensing Settings.
- Confirm successful authentication.
- Verify license features are visible.
- Restart HFSS.

---

# **Installation Validation Checklist**

□ Installation completed successfully

□ Licensing Settings application opens

□ Signed in successfully using company-approved email address

□ Cloud licensing enabled

□ License features visible

□ HFSS launches successfully

□ New HFSS project can be created without licensing errors

If you encounter any issues during installation or licensing, please contact the system administrator and include screenshots of any error messages.
