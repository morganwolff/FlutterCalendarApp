# FlutterCalendarApp

Welcome to our Flutter-based mobile application, developed as a final semester project for our mobile development course. Our team is proud to introduce this innovative tool designed to assist students in managing their schedules by directly retrieving their timetables through the CAUportal API.

## **Main Features:**

### **1. Personalizable Interactive Calendar**
- **Multiple Viewing Options**: Experience various views like day, week, and month planning to suit your preference.
- **Dual Calendar Display**: Choose between both of your calendars to display your events, you can select both at the same time

### **2. Integration with Chung Ang University API**
- **Automatic Course Calendar**: If access is granted, our app will fetch your assigned courses from the Chung Ang University API and create a dedicated calendar for your classes.
- **Manual Entry**: In case the API access is not feasible, you still have the flexibility to manually input and manage your schedule.

## **Supplementary Features:**

### **1. Settings / Profile Page**
- [ ] Customize your user experience:
    - [ ] Update your name.
    - [ ] Choose your preferred color scheme.
    - [x] Toggle between light and dark modes.
    - [x] Select your desired application language.
- [x] Display user name and student ID
- [x] Signout button

### **2. Notification System**
- [ ] Get timely alerts before the commencement of a scheduled activity to ensure you never miss out!

### **3. Integrated 'To-Do' List**
- [x] Organize your tasks efficiently with our 'To-Do' list feature.
- [x] Create varied checklists and, furthermore, link them directly to specific events in your calendar for streamlined management.

## **Developed by:**
- **Trân** (**Project Leader**)
    - Cache managment
    - Translation managment
    - To-Do List
    - Convert calendar from Chung Ang API and add it to our application.
- **Morgan** (**Project owner**)
    - Calendar page
        - Drawer for calendar view preference
        - Create an event
        - View event details
        - Modify selected event 
        - Delete selected event from calendar
    - Settings page
        - Display username and student ID
        - Implement translation and theme 
        managment
    - Navigation Tab Bar
- **Nathan**
    - Login and Register to Firebase
        - Login and register page creation
    - Get Chung Ang API for students calendar
    - Firestore management 
    - Firebase management

- **Mickey**
    - Translation managment
    - Theme managment
