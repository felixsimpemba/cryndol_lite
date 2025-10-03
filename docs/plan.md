# Loan Management App - Flutter Development Prompt

## Project Overview
Create a comprehensive loan management mobile application using Flutter that allows users to manage loans, track payments, calculate interest, and monitor their financial obligations.

## Core Features

### 1. User Authentication & Profile
- Simple local authentication with PIN/password stored securely
- Biometric authentication (fingerprint/face ID) as optional security
- User profile management with photo upload (stored locally)
- Single user profile (multi-user can be added with backend later)
- **Note**: Full authentication system will be integrated when backend is ready

### 2. Loan Management
- **Add New Loan**: Create loans with details like:
  - Loan amount
  - Interest rate (fixed/variable)
  - Loan type (personal, mortgage, auto, student, business)
  - Start date and end date
  - Payment frequency (weekly, bi-weekly, monthly)
  - Lender/borrower information
  - Notes and attachments
- **Loan Dashboard**: Overview of all active, completed, and pending loans
- **Loan Details**: Comprehensive view of individual loan information
- **Edit/Delete Loans**: Modify or remove loan records
- **Loan Calculator**: Pre-calculate monthly payments before creating a loan

### 3. Payment Tracking
- Record payments with date, amount, and payment method
- Payment history timeline for each loan
- Mark payments as pending, completed, or missed
- Upload payment receipts/proof
- Set up automatic payment reminders
- Track partial payments
- Generate payment schedules with amortization tables

### 4. Financial Analytics & Reports
- Dashboard with key metrics:
  - Total debt amount
  - Total paid amount
  - Remaining balance
  - Next payment due
  - Number of active loans
- Visual charts and graphs:
  - Payment progress bars
  - Pie charts for loan distribution by type
  - Line graphs for payment history over time
  - Interest vs principal breakdown
- Monthly/yearly financial reports
- Export reports as PDF or Excel

### 5. Notifications & Reminders
- Push notifications for upcoming payments
- Overdue payment alerts
- Payment confirmation notifications
- Customizable reminder schedules (1 day, 3 days, 1 week before)
- In-app notification center

### 6. Additional Features
- **Currency Support**: Multi-currency with conversion
- **Dark/Light Mode**: Theme switching
- **Search & Filter**: Find loans by type, status, date, or amount
- **Local Data Storage**: All data stored in SQLite database
- **Export Data**: Export data as JSON for backup
- **Document Management**: Store loan agreements and related documents locally
- **EMI Calculator**: Calculate equated monthly installments
- **Interest Calculator**: Compare simple vs compound interest
- **Early Payment Calculator**: See savings from early payments
- **API Ready**: Code structure prepared for future backend integration

## Design System

### Color Scheme
**Primary Colors:**
- Primary: `#1E88E5` (Vibrant Blue) - Trust, stability, financial security
- Primary Dark: `#1565C0` (Deep Blue)
- Primary Light: `#64B5F6` (Light Blue)

**Secondary Colors:**
- Secondary: `#26A69A` (Teal) - Growth, prosperity
- Secondary Dark: `#00897B`
- Secondary Light: `#80CBC4`

**Accent Colors:**
- Success: `#43A047` (Green) - Completed payments
- Warning: `#FB8C00` (Orange) - Upcoming due dates
- Error: `#E53935` (Red) - Overdue payments
- Info: `#5E35B1` (Purple) - Information highlights

**Neutral Colors:**
- Background Light: `#F5F7FA`
- Background Dark: `#121212`
- Surface: `#FFFFFF`
- Surface Dark: `#1E1E1E`
- Text Primary: `#212121`
- Text Secondary: `#757575`
- Divider: `#E0E0E0`

### Typography
- **Font Family**: 'Poppins' (primary), 'Roboto' (secondary)
- **Headings**: 
  - H1: 28sp, Bold
  - H2: 24sp, SemiBold
  - H3: 20sp, Medium
- **Body**: 
  - Body 1: 16sp, Regular
  - Body 2: 14sp, Regular
- **Caption**: 12sp, Regular

### UI Components Style

**Cards:**
- Elevated cards with subtle shadows
- Rounded corners (12-16dp border radius)
- White background in light mode, dark surface in dark mode
- Padding: 16dp

**Buttons:**
- Primary: Filled with primary color, white text
- Secondary: Outlined with secondary color
- Text buttons for less important actions
- Border radius: 8dp
- Height: 48dp minimum

**Input Fields:**
- Outlined text fields with rounded corners (8dp)
- Focused state: Primary color border
- Error state: Error color border with helper text
- Prefix icons for context (currency symbol, calendar, etc.)

**Navigation:**
- Bottom navigation bar with 4-5 main sections:
  1. Dashboard (Home icon)
  2. Loans (List icon)
  3. Add Loan (Plus icon - centered, elevated)
  4. Payments (Payment icon)
  5. Profile (Person icon)

**Charts & Visualizations:**
- Use fl_chart or syncfusion_flutter_charts package
- Animated transitions
- Interactive tooltips
- Color-coded for different loan types

### Screen Layout Guidelines

**Dashboard Screen:**
- Top section: Summary cards with total debt, paid amount, pending amount
- Middle section: Quick action buttons (Add Loan, Make Payment)
- Bottom section: Recent activity list and upcoming payments

**Loan List Screen:**
- Filterable and sortable list
- Card-based layout showing key info (amount, next payment, progress)
- Swipe actions for quick edit/delete
- Floating action button to add new loan

**Loan Details Screen:**
- Hero image/icon at top
- Tabbed interface:
  - Overview tab: All loan details
  - Payments tab: Payment history
  - Schedule tab: Amortization table
- Action buttons: Make Payment, Edit, Delete

**Payment Screen:**
- Simple form with amount, date picker, payment method
- Option to upload receipt
- Confirmation dialog before saving

## Technical Requirements

### Flutter Packages to Use:
- `provider` or `riverpod` - State management
- `sqflite` - Local database (temporary storage)
- `shared_preferences` - Local storage for settings
- `flutter_local_notifications` - Local notifications
- `fl_chart` or `syncfusion_flutter_charts` - Charts
- `pdf` - PDF generation
- `image_picker` - Image uploads
- `intl` - Internationalization and date formatting
- `local_auth` - Biometric authentication
- `file_picker` - Document uploads
- `http` or `dio` - HTTP client for future API integration

### Architecture:
- Use clean architecture principles
- Separate layers: Presentation, Domain, Data
- MVVM or BLoC pattern for state management
- Repository pattern for data access (prepare for easy API integration later)
- Dependency injection
- **Backend Ready**: Structure code to easily replace local database with API calls
- Create service interfaces that can be implemented with either local or remote data sources

### Data Models:
```dart
// Key data models to implement
- User
- Loan (id, amount, interestRate, startDate, endDate, type, status)
- Payment (id, loanId, amount, date, paymentMethod, status)
- Notification
- Document
```

## Implementation Priority
1. **Phase 1**: Authentication, basic loan CRUD, local database
2. **Phase 2**: Payment tracking, notifications, basic dashboard
3. **Phase 3**: Analytics, charts, reports
4. **Phase 4**: Cloud sync, advanced features, document management
5. **Phase 5**: Polish, animations, testing, optimization

## Additional Notes
- Ensure responsive design for various screen sizes
- Implement proper error handling and loading states
- Add empty states with helpful messages
- Include onboarding tutorial for first-time users
- Follow Material Design 3 guidelines
- Optimize for performance (lazy loading, pagination)
- Add unit tests and widget tests
- Implement data validation for all inputs
- Support both portrait and landscape orientations where appropriate