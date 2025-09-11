import 'package:flutter/material.dart';

/// Returns the FAQ HTML content to render inside HtmlContentModal.
/// Keeping this as HTML lets us use the existing flutter_html renderer
/// and style sections consistently.
String buildFaqHtml(BuildContext context) {
  return '''
<h1>Voythrix Help & Support</h1>

<div class="section">
  <h2>Getting Started</h2>
  <p><strong>What is Voythrix?</strong><br/>
  Voythrix is a privacy-first, offline trip planner designed to help you organize all aspects of your travels in one secure place. Manage trips, itineraries, tasks, bookings, expenses with advanced splitting, and travel documents completely offline.</p>
  
  <p><strong>How do I create my first trip?</strong><br/>
  1. Tap the Trips tab at the bottom<br/>
  2. Tap "Create Trip" (+ button)<br/>
  3. Enter trip title and destinations<br/>
  4. Set start and end dates<br/>
  5. Add trip members (optional but recommended for expense sharing)<br/>
  6. Choose your default currency<br/>
  7. Add a description (optional)<br/>
  8. Tap "Create Trip"</p>
  
  <p><strong>Does the app work offline?</strong><br/>
  Yes, completely! All data is stored locally on your device with no internet connection required. There's no cloud sync, ensuring your privacy.</p>
  
  <p><strong>How do I navigate between different sections?</strong><br/>
  Use the bottom navigation bar to switch between Trips, Documents, and Settings. Within each trip, use the tabs at the top to access Overview, Itinerary, To-Dos, Bookings, and Expenses.</p>
</div>

<div class="section">
  <h2>Trip Management</h2>
  <p><strong>How are my trips organized?</strong><br/>
  Trips are automatically categorized as Active (currently happening), Upcoming (future trips), or Completed (past trips). You can search by trip name or destination.</p>
  
  <p><strong>Can I edit a trip after creating it?</strong><br/>
  Yes! Open the trip and tap the menu icon (three dots) to access edit options. You can modify dates, destinations, currency, and description.</p>
  
  <p><strong>What happens when I delete a trip?</strong><br/>
  The trip and ALL related data are permanently removed: todos, bookings, expenses, itinerary activities, and trip-specific documents. This action cannot be undone.</p>
  
  <p><strong>Can I have multiple destinations per trip?</strong><br/>
  Yes! Add multiple destinations separated by commas when creating or editing your trip.</p>
</div>

<div class="section">
  <h2>Trip Members & Collaboration</h2>
  <p><strong>How do I add members to my trip?</strong><br/>
  1. Open your trip and go to the Overview tab<br/>
  2. Scroll to the Members section<br/>
  3. Tap "Add Member" or the + button<br/>
  4. Enter the member's name and optionally their email<br/>
  5. Tap "Add Member"</p>
  
  <p><strong>What's the member limit per trip?</strong><br/>
  You can add up to 8 members per trip, which is optimal for group expense management and splitting calculations.</p>
  
  <p><strong>Can I edit or remove members?</strong><br/>
  Yes! Tap on any member to edit their details or remove them. Note that removing a member who has expense splits will affect your settlement calculations.</p>
  
  <p><strong>How do members affect expense tracking?</strong><br/>
  Members are essential for expense splitting. When you add expenses, you can split costs equally among members or create custom split amounts for each person.</p>
</div>

<div class="section">
  <h2>Itinerary Planning</h2>
  <p><strong>How do I plan daily activities?</strong><br/>
  1. Open your trip and go to the Itinerary tab<br/>
  2. Select the day you want to plan<br/>
  3. Tap the + button to add an activity<br/>
  4. Choose activity type (sightseeing, meal, transport, etc.)<br/>
  5. Add title, location, times, and description<br/>
  6. Save the activity</p>
  
  <p><strong>Can I set specific times for activities?</strong><br/>
  Yes! Set start and end times, or leave them blank for all-day activities. Activities are automatically sorted by time within each day.</p>
  
  <p><strong>What activity types are available?</strong><br/>
  Sightseeing, Meal, Transport, Accommodation, Shopping, Entertainment, and Other. Each type has a unique icon and color.</p>
  
  <p><strong>How do I edit or delete activities?</strong><br/>
  Swipe left on an activity to edit it, or swipe right to delete it. You can also tap an activity to view details and access edit/delete options.</p>
</div>

<div class="section">
  <h2>To-Do Lists</h2>
  <p><strong>What can I track in my to-dos?</strong><br/>
  Each todo can have a title, detailed description, priority level (low, medium, high), and due date. Perfect for pre-trip preparation and travel tasks.</p>
  
  <p><strong>How do I organize my tasks?</strong><br/>
  Filter by priority level or completion status. Search by title or description. Swipe to quickly edit or delete tasks.</p>
  
  <p><strong>Do completed tasks affect my trip overview?</strong><br/>
  Yes! The Overview tab shows your progress with completed vs total tasks, helping you track your trip preparation.</p>
</div>

<div class="section">
  <h2>Booking Management</h2>
  <p><strong>What types of bookings can I store?</strong><br/>
  Flight, Hotel, Activity, Transport, Restaurant, and Other. Each booking can have a status: confirmed, pending, or cancelled.</p>
  
  <p><strong>Can I attach files to bookings?</strong><br/>
  Yes! Attach confirmation emails, tickets, receipts, etc. Supported formats include images (JPG, PNG), PDFs, and documents. Maximum 5MB per file.</p>
  
  <p><strong>Is there a booking limit?</strong><br/>
  Up to 15 bookings per trip to keep things organized and maintain app performance.</p>
  
  <p><strong>How do I manage booking attachments?</strong><br/>
  Tap an attachment to preview it. Use the share button to save to Photos or Files, or share with other apps. You can also delete attachments you no longer need.</p>
  
  <p><strong>Can I track booking costs?</strong><br/>
  Yes! Add cost information when creating bookings. Costs are shown in your trip's default currency.</p>
</div>

<div class="section">
  <h2>Expense Tracking & Splitting</h2>
  <p><strong>What expense information can I track?</strong><br/>
  Title, amount, category, date, who paid, description, and detailed expense splits among trip members. View totals, category breakdowns, and settlement summaries.</p>
  
  <p><strong>What expense categories are available?</strong><br/>
  Transportation, Accommodation, Food & Dining, Activities, Shopping, and Other. Each category helps you understand your spending patterns with visual charts.</p>
  
  <p><strong>How do I split expenses between people?</strong><br/>
  1. Add an expense and select who paid for it<br/>
  2. Choose splitting method: Equal Split or Custom Split<br/>
  3. For Equal Split: Select which members to include<br/>
  4. For Custom Split: Enter specific amounts for each member<br/>
  5. The app automatically calculates who owes what to whom</p>
  
  <p><strong>What splitting options are available?</strong><br/>
  • <strong>Equal Split:</strong> Divide the expense equally among selected members<br/>
  • <strong>Custom Split:</strong> Enter specific amounts for each member<br/>
  • <strong>Exclude Members:</strong> Some members don't participate in certain expenses</p>
  
  <p><strong>How do settlements work?</strong><br/>
  The app calculates simplified settlements to minimize the number of payments needed. It shows who owes money to whom and the optimal payment structure to settle all debts with minimum transactions.</p>
  
  <p><strong>Can I track individual expense settlements?</strong><br/>
  Yes! Tap on any settlement card to see the detailed breakdown of all contributing expenses. You can mark individual expenses as paid and track payment progress.</p>
  
  <p><strong>How are currency conversions handled?</strong><br/>
  Expenses are stored in the amounts you enter. The app doesn't perform automatic currency conversion, so enter amounts in your trip's default currency or note the original currency in the description.</p>
  
  <p><strong>Can I reopen settled expenses?</strong><br/>
  Yes! If you marked an expense as paid by mistake, you can reopen it from the settlement detail screen.</p>
</div>

<div class="section">
  <h2>Document Storage</h2>
  <p><strong>What documents can I store?</strong><br/>
  Personal documents (passport, visa, insurance) and trip-specific documents. Search and filter capabilities help you find documents quickly.</p>
  
  <p><strong>What file types are supported?</strong><br/>
  Images (JPG, PNG, HEIC), PDFs, and text documents (DOC, DOCX, TXT). Documents are stored securely on your device.</p>
  
  <p><strong>Is there a document limit?</strong><br/>
  Up to 10 personal documents total. Trip-specific documents have separate limits per trip.</p>
  
  <p><strong>How do I organize my documents?</strong><br/>
  Documents are categorized by type (passport, visa, insurance, other) and can be filtered accordingly. Use descriptive titles for easy searching.</p>
</div>

<div class="section">
  <h2>Backup & Restore</h2>
  <p><strong>How do I back up my data?</strong><br/>
  1. Go to Settings → Export Data<br/>
  2. Choose whether to set a password (recommended)<br/>
  3. Select where to save the backup file<br/>
  4. Wait for the .voy backup file to be created<br/>
  5. Store it safely (cloud storage, external drive, etc.)</p>
  
  <p><strong>Are backups encrypted?</strong><br/>
  If you set a password, yes! Backups use AES-256 encryption with initialization vectors and checksums. Without a password, backups are unencrypted but compressed.</p>
  
  <p><strong>How do I restore from a backup?</strong><br/>
  1. Go to Settings → Import Data<br/>
  2. Select your .voy backup file<br/>
  3. Enter the password if the backup is encrypted<br/>
  4. Wait for the import to complete<br/>
  5. Your data will be merged with existing data</p>
  
  <p><strong>What's included in backups?</strong><br/>
  All trips, itineraries, todos, bookings (with attachments), expenses, personal documents, and app settings. Backup integrity is verified with metadata checksums.</p>
  
  <p><strong>Can I recover a lost password?</strong><br/>
  No. Passwords cannot be recovered, and encrypted backups cannot be opened without them. Always store your backup passwords securely.</p>
</div>

<div class="section">
  <h2>Settings & Customization</h2>
  <p><strong>Can I change the app's language?</strong><br/>
  Yes! The app supports multiple languages. Go to Settings → Language to choose from available options including English, Spanish, French, German, and others.</p>
  
  <p><strong>Is there a dark mode?</strong><br/>
  Yes! Toggle between light and dark themes in Settings → Dark Mode. The app will remember your preference.</p>
  
  <p><strong>How do I clear all my data?</strong><br/>
  Settings → Clear All Data. This requires multiple confirmations and permanently deletes everything: trips, documents, settings, and preferences. This cannot be undone!</p>
</div>

<div class="section">
  <h2>Troubleshooting</h2>
  <ul>
    <li><strong>Import error: "Invalid/corrupted file"</strong> — Ensure you're using a valid Voythrix .voy backup file. Check the file isn't corrupted.</li>
    <li><strong>Import error: "Password required"</strong> — Enter the exact password used when creating the backup. Passwords are case-sensitive.</li>
    <li><strong>Attachment shows "File not found"</strong> — The original file was moved or deleted. Re-attach the file from its current location.</li>
    <li><strong>Attachment too large</strong> — Files must be 5MB or smaller. Compress large files before attaching.</li>
    <li><strong>App seems slow</strong> — Try closing and reopening the app. For persistent issues, consider exporting your data and clearing app data.</li>
    <li><strong>Missing trips/data</strong> — Check if you accidentally filtered your view. Try searching or changing filter settings.</li>
    <li><strong>Can't create new items</strong> — You may have reached the limit for that item type (e.g., 15 bookings per trip, 10 personal documents).</li>
  </ul>
</div>

<div class="section">
  <h2>Data & Privacy</h2>
  <p><strong>Where is my data stored?</strong><br/>
  All data is stored locally on your device in encrypted databases and secure document folders. Nothing is sent to external servers.</p>
  
  <p><strong>Is my data secure?</strong><br/>
  Yes! Data is stored in encrypted local databases. File attachments are stored in the app's private directory, inaccessible to other apps.</p>
  
  <p><strong>Does the app track me?</strong><br/>
  No. Voythrix doesn't include analytics, tracking, or telemetry. Your usage patterns and personal data stay on your device.</p>
  
  <p><strong>Can I use the app on multiple devices?</strong><br/>
  Each device maintains its own local database. To sync data between devices, export a backup from one device and import it on another.</p>
</div>

<div class="contact-info">
  <h3>Still need help?</h3>
  <p>We're here to help! Contact our support team:</p>
  <p><strong>Email:</strong> <a href="mailto:voythrix@gmail.com">voythrix@gmail.com</a><br/>
  <strong>Subject:</strong> Voythrix Support Request</p>
  
  <p>When contacting support, please include:</p>
  <ul>
    <li>Your device type (iPhone, Android, etc.)</li>
    <li>App version (found in Settings → About)</li>
    <li>Description of the issue</li>
    <li>Steps to reproduce the problem</li>
  </ul>
  
  <p>We typically respond within 24-48 hours.</p>
</div>
''';
}
